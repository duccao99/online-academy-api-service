const request = require("request");

// check facebook signature
function check_fb_signature(req, res, buf) {
  console.log("Check facebook signature step.");
  var fb_signature = req.headers["x-hub-signature"];
  const APP_SECRET = process.env.APP_SECRET;
  if (!fb_signature) {
    throw new Error("Signature ver failed.");
  } else {
    var sign_splits = signature.split("=");
    var method = sign_splits[0];
    var sign_hash = sign_splits[1];

    var real_hash = crypto
      .createHmac("sha1", APP_SECRET)
      .update(buf)
      .digest("hex");

    if (sign_hash != real_hash) {
      throw new Error("Signature ver failed.");
    }
  }
}

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
        console.log("Message sent successsfully.");
      } else {
        console.log(error);
        console.log(response.body.error);

        console.log("Message failed - " + response.statusMessage);
      }
    }
  );
}

module.exports = {
  getMessage,
  sendMessage,
  check_fb_signature,
};
