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

select * from `roles`;
select * from `categories`;
select * from `subjects`;
select * from `users`;
select * from `chapters`;
select * from `lessons`;