const router = require("express").Router();
const instructorModel = require("./../models/instructor.model");
const insUploadModel = require("../models/insUpload.model");
const bcryptjs = require("bcryptjs");
const randomstring = require("randomstring");
const { sendOTP } = require("../config/nodemailer");
const multer = require("multer");
const fs = require("fs");
const path = require("path");
const moment = require("moment");
const courseModel = require("../models/course.model");
const cloudinary = require("cloudinary").v2;
const streamifier = require("streamifier");
const { Base64 } = require("js-base64");
const chapterModel = require("../models/chapter.model");
const lessonModel = require("./../models/lesson.model");
cloudinary.config({
  cloud_name: "duccao",
  api_key: `${process.env.CLOUNDINARY_API_KEY}`,
  api_secret: `${process.env.CLOUNDINARY_API_SECRET}`,
});

router.get("/", async function (req, res) {
  const ret = await instructorModel.all();

  if (ret.length === 0) {
    return res.status(404).json({
      message: "Instructor not found!",
    });
  }

  return res.json({
    instructors: ret,
  });
});

router.patch("/toggle-finished-course", async function (req, res) {
  const body = req.body;
  const en_update = {
    is_finished: body.is_finished,
  };
  const con1_update = {
    course_id: +body.course_id,
  };
  const con2_update = {
    user_id: +body.user_id,
  };

  const ret = await instructorModel.toggleFinishedCourse(
    en_update,
    con1_update
  );

  return res.json({
    ret_finished_course: ret,
  });
});

router.patch("/toggle-preview", async function (req, res) {
  const update_entity = {
    flag_reviewable: req.body.flag_reviewable,
  };
  const update_condition = {
    lesson_id: req.body.lesson_id,
  };

  const ret = await instructorModel.togglePreviewLesson(
    update_entity,
    update_condition
  );

  return res.json({
    ret_preview_update: ret,
  });
});

router.get("/uploaded-course/:email", async function (req, res) {
  const email = req.params.email;
  const ret = await instructorModel.uploadedCourse(email);

  if (ret.length === 0) {
    return res.status(404).json({
      message: "Course not found!",
    });
  }

  return res.json({
    uploaded_course: ret,
  });
});

router.get("/chap-exists/:id", async function (req, res) {
  const insUp_course_id = +req.params.id;

  const ret = await insUploadModel.getChapterExists(insUp_course_id);

  if (ret.length === 0) {
    return res.status(404).json({ message: "Chap not found!" });
  }

  return res.json({
    chap_exists: ret,
  });
});

router.get("/lesson-exists/:chap_id", async function (req, res) {
  const chap_id = +req.params.chap_id;

  const ret = await insUploadModel.getLessonExists(chap_id);

  if (ret.length === 0) {
    return res.status(404).json({ message: "Chap not found!" });
  }

  return res.json({
    lesson_exists: ret,
  });
});

router.get("/:id", async function (req, res) {
  const id = +req.params.id;

  const ret = await instructorModel.detail(id);

  if (ret.length === 0) {
    return res.status(404).json({ message: "Instructor not found!" });
  }
  return res.json({
    instructor_detail: ret[0],
  });
});

router.post("/upload-course", async function (req, res) {
  try {
    const saveImagePath = path.join(__dirname, "../public/images");

    const storage = multer.diskStorage({
      destination: function (req, file, cb) {
        cb(null, saveImagePath);
      },
      filename: function (req, file, cb) {
        cb(null, file.originalname);
      },
    });

    // const upload = multer({ storage }).array("ava", 3);
    const upload = multer({ storage }).single("ava");

    upload(req, res, async function (err) {
      try {
        if (err) {
          console.log(err);
          throw new Error(err);
        } else {
          // cloudinary.uploader.upload(
          //   fs.readFileSync(`${saveImagePath}`, "base64"),
          //   (er, ret) => {
          //     console.log(er);
          //     console.log(ret);
          //   }
          // );
          const course = req.body;

          // console.log(req.file);
          // console.log(req.file);

          // console.log(req.files);

          // let streamUpload = (req) => {
          //   return new Promise((resolve, reject) => {
          //     let stream = cloudinary.uploader.upload_stream((er, ret) => {
          //       if (ret) {
          //         resolve(ret);
          //       } else {
          //         reject(er);
          //       }
          //     });
          //     return streamifier.createReadStream(req.file.buffer).pipe(stream);
          //   });
          // };

          // async function upLoadImage(req) {
          //   let ret = await streamUpload(req);
          //   console.log("ret upload image cl: ", ret);
          // }

          // upLoadImage(req);

          // check name
          const isNameExists = await instructorModel.isCourseNameExists(
            course.course_name
          );

          if (isNameExists === true) {
            return res.status(400).json({
              message: "Course name exists!",
            });
          }
          // convert file to base64

          // var fileInfor = [];
          // for (var i = 0; i < req.files.length; i++) {
          //   fileInfo.push({
          //     originalName: req.files[i].originalName,
          //     size: req.files[i].size,
          //     b64: new Buffer(fs.readFileSync(req.files[i].path)).toString(
          //       "base64"
          //     ),
          //   });
          //   fs.unlink(req.files[i].path);
          // }

          // console.log("req file ", req.file);
          // console.log("req files ", req.files);

          // console.log("Buffer from file ", Buffer.from(req.file));
          // AbortController.replace(/([^:]\/)\/+/g, "$1");

          const pathSaveImage = saveImagePath.replace(/([^:]\/)\/+/g, "$1");

          const cloudPath = path.join(pathSaveImage, req.file.originalname);
          let secure_url = "";

          // console.log("img path base 64 ", pathSaveImage);
          // console.log("cloudPath ", cloudPath);

          cloudinary.uploader.upload(
            `${req.file.path}`,
            {
              use_filename: true,
              unique_filename: false,
            },
            async (er, ret) => {
              try {
                console.log(er);
                console.log(ret);
                if (ret) {
                  const toDay = Date.now();

                  const course_tobe_add = {
                    course_name: course.course_name,
                    course_title: course.course_title,
                    course_fee: +course.course_fee,
                    course_full_description: course.course_full_description,
                    course_short_description: course.course_short_description,
                    subject_id: course.subject_id,
                    is_finished: false,
                    views: 0,
                    course_last_updated: moment(toDay).format(
                      "YYYY/MM/DD HH:mm:ss"
                    ),
                    course_avatar_url: ret.secure_url,
                  };
                  // add to `courses`
                  const ret_add_course = await courseModel.add(course_tobe_add);

                  // add to `instructor_courses_uploaded`

                  const insUp_entity = {
                    user_id: course.user_id,
                    course_id: ret_add_course.insertId,
                    lesson_id: null,
                    chap_id: null,
                    uploaded_day: moment(toDay).format("YYYY/MM/DD HH:mm:ss"),
                  };
                  const ret_ins_up = await insUploadModel.add(insUp_entity);

                  return res.json({
                    message: "Upload course success!",
                    ret_add_course: ret_add_course,
                    ret_ins_up: ret_ins_up,
                  });
                }
              } catch (er) {
                return res.status(500).json({
                  message: er,
                });
              }
            }
          );
        }
      } catch (er) {
        return res.status(500).json({
          message: er,
        });
      }
    });
  } catch (er) {
    return res.status(500).json({
      message: "Something broke!",
    });
  }
});

router.post("/upload-chapter", async function (req, res) {
  // course_id, chap_name, user_id
  const body = req.body;

  const chapter = {
    chap_name: body.chap_name,
  };

  // add chap
  const ret_add_chap = await chapterModel.add(chapter);

  // add chap to ins up
  const entity_insUp = {
    chap_id: ret_add_chap.insertId,
    user_id: body.user_id,
    course_id: body.course_id,
    uploaded_day: moment(Date.now()).format("YYYY/MM/DD HH:mm:ss"),
  };
  const ret_add_chap_to_insUp = await insUploadModel.addChapToInsUp(
    entity_insUp
  );

  return res.json({
    ret_add_chap,
    ret_add_chap_to_insUp,
  });
});

router.post("/upload-lesson", async function (req, res) {
  const saveVideoPath = path.join(__dirname, "../public/videos");

  const storage = multer.diskStorage({
    destination: function (req, file, cb) {
      cb(null, saveVideoPath);
    },
    filename: function (req, file, cb) {
      cb(null, file.originalname);
    },
  });

  const upload = multer({ storage }).single("lesson_video");

  upload(req, res, async function (er) {
    try {
      if (er) {
        return res.status(500).json({ er });
      } else {
        const lesson = req.body;

        cloudinary.uploader.upload_large(
          req.file.path,
          {
            resource_type: "video",
            eager_async: true,
            use_filename: true,
            unique_filename: false,
          },
          async (er, ret) => {
            try {
              if (er) {
                return res.status(500).json({ er });
              }

              console.log(ret);

              // add lesson

              const lesson_entity = {
                lesson_name: lesson.lesson_name,
                lesson_content: lesson.lesson_content,
                flag_reviewable: true,
                duration: null,
                chap_id: +lesson.chap_id,
                lesson_video_url: ret.secure_url,
              };
              const ret_add_lesson = await lessonModel.add(lesson_entity);

              // add ins up
              const insUp_entity = {
                course_id: +lesson.course_id,
                user_id: +lesson.user_id,
                chap_id: +lesson.chap_id,
                lesson_id: +ret_add_lesson.insertId,
                uploaded_day: moment(Date.now()).format("YYYY/MM/DD HH:mm:ss"),
              };
              const ret_add_ins_up = await insUploadModel.add(insUp_entity);

              // course_id: lesson.course_id,
              // user_id: lesson.user_id,

              return res.json({
                message: "upload lesson success!",
                ret_add_lesson,
                ret_add_ins_up,
              });
            } catch (er) {
              return res.status(500).json({ er });
            }
          }
        );
      }
    } catch (er) {
      return res.status(500).json({ er });
    }
  });
});

router.post("/", async function (req, res) {
  const ins = req.body;

  const ret_check_mail = await instructorModel.checkEmail(ins.email);

  if (ret_check_mail !== undefined) {
    return res.status(400).json({
      message: "Email has been use!",
    });
  }

  const hashed_pass = await bcryptjs.hashSync(ins.password, 10);

  const ins_add = {
    ...ins,
    role_id: 3,
    is_verified: false,
    otp_verify_url: "",
    password: hashed_pass,
  };

  const ret = await instructorModel.add(ins_add);

  // send otp
  const link_otp = `${process.env.DEV_URL}/${randomstring.generate(80)}`;

  const ret_add_link_otp = await instructorModel.addLinkOTP(
    link_otp,
    ins_add.email
  );

  sendOTP(ins_add.email, link_otp);

  if (+ret.affectedRows === 1) {
    return res.json({
      message: "Instructor was created!",
      ins_info: ins_add,
      ret_add_link_otp: ret_add_link_otp.message,
      link_otp,
    });
  }

  return res.status(500).json({ error_message: "Something broke!" });
});

router.patch("/:id", async function (req, res) {
  const ret = await instructorModel.edit(
    +req.params.id,
    req.body.user_name,
    req.body.email
  );

  if (+ret.affectedRows === 1) {
    return res.json({
      message: "Edited!",
      ret_update_ins: ret,
    });
  }
  return res.status(500).json({
    message: "Something broke!",
  });
});

router.delete("/:id", async function (req, res) {
  const id = +req.params.id;

  // del ins upload first
  const condition = {
    user_id: id,
  };
  const ret_del_insUpload = await insUploadModel.del(condition);

  const ret = await instructorModel.del(id);

  return res.json({
    del_ins_detail: ret,
    ret_del_insUpload,
  });
});

module.exports = router;
