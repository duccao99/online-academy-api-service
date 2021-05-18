use `SPA_ONLINE_ACADEMY`;

----------------------------
-- Get all students
----------------------------
select *
from `users` u
where role_id =2 
and u.user_id = 1;

----------------------------
-- Get student detail by id
----------------------------
select  *
from `users` u
where u.role_id=2;

----------------------------------------------------------
--  outstanding courses (most bought)
----------------------------------------------------------
select c.course_id, c.course_name, c.course_title, c.course_avatar_url, c.course_fee,
sj.subject_id, sj.subject_name, c.views, u.user_name, rt.avg_rate
from `courses` c
inner join `orders_details` od
on od.course_id = c.course_id
inner join `subjects` sj
on sj.subject_id = c.subject_id
inner join `instructor_courses_uploaded` ins
on ins.course_id = c.course_id
inner join `users` u
on u.user_id = ins.user_id
inner join (
select *, avg(star) as avg_rate
from course_reviews as crw
group by crw.course_id
) rt
on rt.course_id = c.course_id
group by c.course_id
having count(od.course_id) >= 3
and rt.avg_rate >= 4
limit 3;



----------------------------
-- Get 10 newsest courses
----------------------------
select *
from `courses` c
inner join `subjects` s
on s.subject_id = c.subject_id
inner join `categories` cat 
on cat.cat_id = s.cat_id
and c.is_finished = 1
order by c.course_last_updated desc
limit 10;

----------------------------
--  10 most viewed courses
----------------------------
select *
from `courses` c 
order by c.views desc 
limit 10;

----------------------------
--  course details
----------------------------
select c.course_id, c.course_name, c.course_title, c.course_thumbnail, c.course_avatar_url, c.course_fee ,
c.course_full_description, c.course_short_description,c.course_last_updated, c.is_finished, c.subject_id,c.views ,
sj.subject_name,  u.user_name
from `courses` c 
inner join `subjects` sj 
on sj.subject_id = c.subject_id
inner join `instructor_courses_uploaded` i
on i.course_id = c.course_id
inner join `users` u
on u.user_id = i.user_id
where c.course_id = 1;

----------------------------
--  course syllabus
----------------------------
select l.lesson_id, l.lesson_name, l.lesson_content, l.flag_reviewable, l.duration
, ct.chap_id, ct.chap_name
from `courses` c
inner join `chapters` ct
on ct.course_id = c.course_id
inner join `lessons` l
on l.chap_id = ct.chap_id 
where c.course_id =1;

----------------------------
--  detail course instructor
----------------------------
select ic.course_id, ic.uploaded_day, u.user_name, u.email, u.role_id, u.user_avatar_url
from `courses` c
inner join `instructor_courses_uploaded` ic
on ic.course_id = c.course_id
inner join `users` u
on u.user_id = ic.user_id
where c.course_id = 1;

----------------------------------------------------
--   all course bought most
----------------------------------------------------
select * , count(*) num_stu_bought
from `orders_details` scb 
group by scb.course_id
having count(scb.course_id) > 0
order by count(scb.course_id) desc;



----------------------------------------------------
--  detail five course relative category
----------------------------------------------------
select c.course_id, c.course_name, c.course_title, c.course_thumbnail, c.course_avatar_url, c.course_fee ,
c.course_full_description, c.course_short_description,c.course_last_updated, c.is_finished, c.subject_id,c.views ,
sj.subject_name, scb.num_stu_bought
from `courses` c
inner join `subjects` sj
on sj.subject_id = c.subject_id
inner join (
select * , count(*) num_stu_bought
from `orders_details` scb 
group by scb.course_id
having count(scb.course_id) > 0
order by count(scb.course_id) desc
) scb
on scb.course_id = c.course_id
where sj.subject_id = 2
and c.is_finished = true
and c.course_id != 2
order by c.course_id
limit 5;

----------------------------------------------------
--  detail course review
----------------------------------------------------
select cr.course_id,c.course_name, cr.star, cr.review_content
,u.user_id, u.user_name, u.user_avatar_url, u.role_id, r.role_name
from `courses` c
inner join `course_reviews` cr
on cr.course_id = c.course_id
inner join `users` u
on u.user_id = cr.user_id
inner join `roles` r
on u.role_id = r.role_id
where c.course_id = 1;

----------------------------------------------------
--  detail all chapters, lessons
----------------------------------------------------
select *
from `chapters` c
where c.course_id =1;

select l.lesson_id, l.lesson_name, l.lesson_content, l.flag_reviewable
, l.duration, l.chap_id, c.chap_name, c.course_id
from `lessons` l
inner join `chapters` c 
on c.chap_id = l.chap_id
where c.course_id =1;


select * from `roles`;
select * from `categories`;
select * from `subjects`;
select * from `users`;
select * from `chapters`;
select * from `lessons`;
select * from `courses`;
select * from `orders`;
select * from `orders_details`;
select * from `course_reviews`;
select * from `student_courses_bought`;
select * from `instructor_courses_uploaded`;





