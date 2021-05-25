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

upload(req, res, async function (er) {
  try {
    if (er) {
      return res.status(500).json({ er });
    } else {
      const lesson = req.body;
      console.log(lesson);

      console.log("video file: ", req.file);
    }
  } catch (er) {
    return res.status(500).json({ er });
  }
});
