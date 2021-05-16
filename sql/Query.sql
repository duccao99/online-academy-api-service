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
-- Get outstanding courses (most bought)
----------------------------------------------------------
select *
from `courses` c
inner join `orders_details` od
on od.course_id = c.course_id
having count(c.course_id) > 10;



----------------------------
-- Get 10 newsst courses
----------------------------
select *
from `courses` c
inner join `subjects` s
on s.subject_id = c.subject_id
inner join `categories` cat 
on cat.cat_id = s.cat_id
where datediff(curdate(),c.course_last_updated) <7 
and c.is_finished = 1
limit 10;

----------------------------
--  10 most viewed courses
----------------------------
select *
from `courses` c 
order by c.views desc 
limit 10;

select * from `roles`;
select * from `categories`;
select * from `subjects`;
select * from `users`;
select * from `chapters`;
select * from `lessons`;
select * from `courses`;
select * from `orders`;
select * from `orders_details`;





