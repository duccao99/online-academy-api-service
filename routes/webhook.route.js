const router = require("express").Router();
const { getMessage, sendMessage } = require("../utils/chatbot.utils");

// Verify Webhook URL
router.get("/", function (req, res) {
  const VERIFY_TOKEN = process.env.VERIFY_TOKEN;
  console.log("Webhook verification step.");
  if (
    req.query["hub.mode"] === "subscribe" &&
    req.query["hub.verify_token"] === VERIFY_TOKEN
  ) {
    res.status(200).send(req.query["hub.challenge"]);
  } else {
    console.error("Authentication Failed!.");
    res.sendStatus(403);
  }
});

// Handle Post Request to receive messages.
router.post("/", function (req, res) {
  console.log("Webhook messaging step.");
  var chat_data = req.body;
  // Make sure this is a page subscription
  if (chat_data.object == "page") {
    // Iterate over each entry
    chat_data.entry.forEach(function (page_body) {
      // Iterate over each message
      page_body.messaging.forEach(function (message_obj) {
        console.log(message_obj);
        if (message_obj.message) {
          getMessage(message_obj);
          sendMessage(
            message_obj.sender.id,
            "Hế lô Tứ, t Đức nè, con Chatbot này nó tự động nhắn á nha!"
          );
        }
      });
    });

    // Indicate all went well.
    res.sendStatus(200);
  }
});

module.exports = router;
