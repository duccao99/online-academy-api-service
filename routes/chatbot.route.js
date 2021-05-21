const catModel = require("../models/category.model");
const courseModel = require("../models/course.model");
const subCatModel = require("../models/subCategory.model");
const { getMessage, sendMessage } = require("../utils/chatbot.utils");

const router = require("express").Router();

router.get("/", function (req, res) {
  const VERIFY_TOKEN = process.env.VERIFY_TOKEN;
  console.log("Webhook verification step");

  if (
    req.query["hub.mode"] === "subscribe" &&
    req.query["hub.verify_token"] === VERIFY_TOKEN
  ) {
    res.status(200).send(req.query["hub.challenge"]);
  } else {
    console.log("Authentication failed!");
    res.sendStatus(403);
  }
});

router.post("/", function (req, res) {
  console.log("Webhook messaging step");
  var chat_data = req.body;

  console.log(chat_data);
  console.log("Chat data object: ", chat_data.object);

  if (chat_data.object == "page") {
    chat_data.entry.forEach((page_body) => {
      page_body.messaging.forEach(async function (mess_obj) {
        console.log(mess_obj);

        if (mess_obj.message) {
          getMessage(mess_obj);
          const sender_id = mess_obj.sender.id;
          const text = mess_obj.message.text;

          await handleThreeFeature(sender_id, text);
        }
      });
    });

    res.sendStatus(200);
  }
});

function SayHi(sender_id) {
  const message = `
  Hi! I'm a Chat Bot Service From Online Academy API Service server!\n
Right now I'm only have three features\n
And those are:\n
1. Search course by keyword\n
2. Accept course by category\n
3. View course detail\n
Which feature do you want to use?\n
  `;
  return sendMessage(sender_id, message);
}

async function searchCourseByKeyword(keyword) {
  const ret = await courseModel.fullTextSearchPagi(keyword, 9, 0);
  return ret;
}
async function detailCat(id) {
  const sub_cat_detail = await subCatModel.detail(id);
  if (sub_cat_detail === undefined) {
    return undefined;
  }
  return sub_cat_detail;
}

async function detailCourse(id) {
  const course_detail = await courseModel.detail(id);
  if (course_detail === undefined) {
    return undefined;
  }
  const ret = `Result
  course_id:${course_detail.course_id}
  \ncourse_name:${course_detail.course_name}
  \ncourse_title:${course_detail.course_title}
  \ncourse_avatar_url:${course_detail.course_avatar_url}
  \ncourse_fee:${course_detail.course_fee}
  \ncourse_last_updated:${course_detail.course_last_updated}
  \nviews:${course_detail.views}
  \ncategory:${course_detail.subject_name}
  \ninstructor:${course_detail.user_name}
  \nis_finished:${course_detail.is_finished}`;
  return ret;
}

async function handleAcceptByCat(subcat_id) {
  const ret = await courseModel.acceptAllCourseBySubcat(subcat_id);

  return ret.affectedRows;
}

async function handleThreeFeature(sender_id, text) {
  if (!isNaN(+text)) {
    switch (+text) {
      case 1:
        //  Search course by keyword\n
        const message = "Enter keyword";
        await sendMessage(sender_id, message);
        break;
      case 2:
        //  Accept course by category\n
        const message2 = "There are categories list";
        await sendMessage(sender_id, message2);

        const allCat = await subCatModel.all();

        let mess_cat = "";
        for (let i = 0; i < allCat.length; ++i) {
          mess_cat += `Cat ${i + 1}: ${allCat[i].subject_name}\n`;
        }
        setTimeout(async () => {
          await sendMessage(sender_id, mess_cat);
        }, 200);
        setTimeout(async () => {
          await sendMessage(
            sender_id,
            "Which category that you want to accept courses?\nPlease follow this syntax to enter: 'cat:1'"
          );
        }, 400);
        break;
      case 3:
        //   View course detail\n
        const message3 = "Enter course id and follow this syntax 'course_id:1'";
        await sendMessage(sender_id, message3);
        break;

      default:
        await sendMessage(
          sender_id,
          "This message was sent from Online Academy API Service server!"
        );
        await SayHi(sender_id);
        break;
    }
  } else if (text.includes("cat")) {
    const curr_text = text;
    let id = "";

    for (let i = curr_text.indexOf(":") + 1; i < curr_text.length; ++i) {
      id += curr_text[i];
    }

    const ret = await detailCat(id);

    if (ret !== undefined) {
      const ret_handle_accept_courses = await handleAcceptByCat(id);

      await sendMessage(
        sender_id,
        `There are ${+ret_handle_accept_courses} in category ${
          ret.subject_name
        } were accepted\n`
      );
    } else {
      await sendMessage(sender_id, `Category not found!`);
    }
  } else if (text.includes("course_id")) {
    const curr_text = text;
    let id = "";

    for (let i = curr_text.indexOf(":") + 1; i < curr_text.length; ++i) {
      id += curr_text[i];
    }
    const ret = await detailCourse(id);

    if (ret !== undefined) {
      await sendMessage(sender_id, ret);
    } else {
      await sendMessage(sender_id, `Course not found!`);
    }
  } else {
    const courses_by_keyword = await searchCourseByKeyword(text);

    if (courses_by_keyword.length !== 0) {
      for (let i = 0; i < courses_by_keyword.length; ++i) {
        await sendMessage(
          sender_id,
          `Result ${i + 1}:\nName: ${
            courses_by_keyword[i].course_name
          }\nPrice: ${courses_by_keyword[i].course_fee}\nIs finished: ${
            courses_by_keyword[i].is_finished
          }\nCategory:  ${courses_by_keyword[i].subject_name}\navg_rate:${
            courses_by_keyword[i].avg_rate
          }`
        );
      }
    } else {
      await SayHi(sender_id);
    }
  }
}

module.exports = router;
