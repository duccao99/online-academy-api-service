const request = require("request");

// handles messages events
function handleMessage(sender_psid, received_message) {}

// Handles messaging post backs events
function handlePostback(sender_psid, received_postback) {}

// Sends response messages via the Send API
function callSendAPI(sender_psid, res) {}

// Get Message
function getMessage(message_obj) {
  var message = message_obj.message.text;
  console.log(message);
}

// Send Message
function sendMessage(recipient_id, message) {
  const PAGE_ACCESS_TOKEN = process.env.PAGE_ACCESS_TOKEN;
  var messageData = {
    recipient: {
      id: recipient_id,
    },
    message: {
      text: message,
    },
  };
  request(
    {
      uri: "https://graph.facebook.com/v3.2/me/messages",
      qs: {
        access_token: PAGE_ACCESS_TOKEN,
      },
      method: "POST",
      json: messageData,
    },
    function (error, response, body) {
      if (!error && response.statusCode == 200) {
        console.log("Messeage sent successsfully.");
      } else {
        console.log("Message failed - " + response.statusMessage);
      }
    }
  );
}

module.exports = {
  getMessage,
  sendMessage,
};
