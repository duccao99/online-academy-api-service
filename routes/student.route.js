const router = require('express').Router();
const db = require('../config/db');
const studentModel = require('../models/student.model');
const feedbackModel = require('../models/feedback.model');

router.get('/', async function (req, res) {
  const student_data = await studentModel.all();

  if (student_data.length === 0) {
    return res.status(404).json({
      message: 'Student not found'
    });
  }

  return res.json({
    all_students: student_data
  });
});

router.get('/is-favorite', async function (req, res) {
  const course_id = +req.query.course_id;
  const user_id = +req.query.user_id;

  const ret = await studentModel.isFavorite(course_id, user_id);

  return res.json({
    is_favorite: ret
  });
});
router.get('/favorite-courses/:user_id', async function (req, res) {
  const user_id = +req.params.user_id;
  const ret = await studentModel.getFavoriteCourse(user_id);

  if (ret.length === 0) {
    return res.status(404).json({ message: 'Course not found!' });
  }

  return res.json({
    favorite_courses: ret
  });
});

router.patch('/toggle-favorite', async function (req, res) {
  const data = {
    user_id: +req.body.user_id,
    course_id: +req.body.course_id,
    is_favorite: !req.body.is_favorite
  };

  // check if exists
  const is_exists = await studentModel.isExistsFavorite(
    data.user_id,
    data.course_id
  );

  if (is_exists === true) {
    const ret = await studentModel.toggleFavorite(
      data.user_id,
      data.course_id,
      data.is_favorite
    );
    return res.json({
      ret_toggle_favorite: ret
    });
  } else {
    // if the course is not favorite before
    const ret_add_to_favorite = await studentModel.addToFavorite(
      data.user_id,
      data.course_id,
      true
    );
    return res.json({
      ret_add_to_favorite
    });
  }
});

router.get('/purchased-courses/:email', async function (req, res) {
  const email = req.params.email;

  const ret = await studentModel.getPurchasedCourses(email);

  if (ret.length === 0) {
    return res.status(404).json({ message: 'Course not found!' });
  }

  return res.json({
    purchased_courses: ret
  });
});

router.post('/upload-feedback', async function (req, res) {
  if (
    !req.body.user_id ||
    !req.body.course_id ||
    !req.body.review_content ||
    !req.body.star
  ) {
    return res.status(400).json({
      message: 'Cannot empty!'
    });
  }

  const isExists = await feedbackModel.isExists(
    +req.body.course_id,
    +req.body.user_id
  );

  if (isExists === true) {
    return res.status(400).json({
      message: 'Feedback already exists!'
    });
  }

  const feedback = {
    user_id: +req.body.user_id,
    course_id: +req.body.course_id,
    review_content: req.body.review_content,
    star: +req.body.star
  };

  const ret = await feedbackModel.add(feedback);

  if (+ret.affectedRows) {
    return res.json({
      message: 'Added new feedback!',
      ret_add_feedback: ret
    });
  }
});

router.get('/your-feedback', async function (req, res) {
  if (!req.query.user_id || !req.query.course_id) {
    return res.status(400).json({
      message: 'Cannot empty!'
    });
  }

  const data = {
    user_id: +req.query.user_id,
    course_id: +req.query.course_id
  };

  const ret = await feedbackModel.yourFeedback(data.user_id, data.course_id);

  if (ret === undefined) {
    return res.status(404).json({
      message: 'Do not have feedback!'
    });
  }

  return res.json({
    your_feedback: ret
  });
});

router.get('/:id', async function (req, res) {
  const user_id = +req.params.id;

  const user_detail = await studentModel.detail(user_id);

  if (user_detail === undefined) {
    return res.status(404).json({
      message: 'Student not found'
    });
  }

  return res.json({
    student_detail: user_detail
  });
});

router.delete('/:id', async function (req, res) {
  const student_id = req.params.id;

  // check if student id is in db
  const student_detail = await studentModel.detail(student_id);

  if (student_detail === undefined) {
    // if does not in

    return res.status(404).json({
      message: 'Student not found'
    });
  }

  // if in then delete
  const condition = {
    user_id: student_id
  };

  const ret = await studentModel.del(condition);

  if (+ret.affectedRows === 1) {
    return res.json({
      message: 'Deleted'
    });
  }

  return res.status(500);
});

router.patch('/:id', async function (req, res) {
  const student_edit_info = req.body;
  const student_id = +req.params.id;
  // check curr user id is a student

  const student_detail = await studentModel.detail(student_id);

  if (student_detail === undefined) {
    return res.status(204).json({
      message: 'No content'
    });
  }

  const entity = {
    ...student_edit_info
  };

  const condition = {
    user_id: student_id
  };
  const ret = await studentModel.edit(entity, condition);

  if (+ret.affectedRows === 1) {
    return res.json({
      message: 'Edited'
    });
  }

  return res.status(500);
});

module.exports = router;
