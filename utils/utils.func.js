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

module.exports = {
  check_fb_signature,
};
