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
--  top 10 outstanding courses (most bought)
----------------------------------------------------------
select c.course_id, c.course_name, c.course_title, c.course_avatar_url, c.course_fee,
sj.subject_id, sj.subject_name, c.views, u.user_name, rt.avg_rate, c.course_last_updated
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
where datediff(curdate(),c.course_last_updated ) <=7
and  c.is_finished = 1
group by c.course_id
having count(od.course_id) >= 3
and rt.avg_rate >= 1
limit 10;

----------------------------
-- Get 10 newsest courses
----------------------------
select c.course_id, c.course_name, c.course_title, c.course_avatar_url, c.course_fee,
sj.subject_id, sj.subject_name, c.views, u.user_name, c.course_last_updated
from `courses` c
inner join `subjects` sj
on sj.subject_id = c.subject_id
inner join `instructor_courses_uploaded` ins
on ins.course_id = c.course_id
inner join `users` u
on u.user_id = ins.user_id
where c.is_finished = 1
group by c.course_id
order by c.course_last_updated desc
limit 10;

----------------------------
--  10 most viewed courses
----------------------------
select c.course_id, c.course_name, c.course_title, c.course_avatar_url, c.course_fee,
c.course_last_updated, c.is_finished, c.views, sj.subject_name, u.user_id,
u.user_name
from `courses` c 
inner join `subjects` sj
on sj.subject_id = c.subject_id
inner join `instructor_courses_uploaded` ins 
on ins.course_id = c.course_id 
inner join `users` u
on u.user_id = ins.user_id
inner join (
select *, avg(cr.star) as avg_rate
from course_reviews cr
group by cr.course_id
) rt
on rt.course_id = c.course_id
where c.is_finished = 1
group by c.course_id
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

----------------------------------------------------------
-- top sub cat (last week)
----------------------------------------------------------
select  count(*) as num_student_enroll, cat.cat_name, sj.subject_id, sj.subject_name, c.course_id 
from `student_enrolls` se 
inner join `courses` c 
on c.course_id = se.course_id 
inner join `subjects` sj
on sj.subject_id = c.subject_id
inner join `categories` cat 
on cat.cat_id = sj.cat_id
group by se.course_id
order by num_student_enroll desc ;


----------------------------
--  course syllabus
----------------------------
select ins.course_id, ins.chap_id, ch.chap_name,  le.lesson_content,
    ins.lesson_id, le.lesson_name,le.lesson_video_url ,le.flag_reviewable
    from instructor_courses_uploaded ins
    left join `chapters` ch 
    on ch.chap_id = ins.chap_id 
    left join `lessons` le 
    on le.lesson_id = ins.lesson_id 
    where ins.course_id = 1 
    group by le.lesson_id;
    
    select * from `instructor_courses_uploaded`;
    

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

----------------------------------------------------
--  all card course without pagi
----------------------------------------------------
select c.course_id, c.course_name, c.course_title, c.course_avatar_url,
    c.course_fee, c.course_last_updated, c.is_finished, c.views, sj.subject_id, sj.subject_name,
    u.user_id, u.user_name, rt.avg_rate, count(*) num_course
    from `courses` c
    inner join `subjects` sj
    on sj.subject_id = c.subject_id
    inner join `instructor_courses_uploaded` ins
    on ins.course_id = c.course_id
    inner join `users`u
    on u.user_id = ins.user_id
    inner join (
    select *, avg(star) as avg_rate
    from course_reviews crw 
    group by crw.course_id
    ) rt
    where c.is_finished = true
    group by c.course_id;

----------------------------------------------------
--  all card course with pagi
----------------------------------------------------
select c.course_id, c.course_name, c.course_title, c.course_avatar_url,
    c.course_fee, c.course_last_updated, c.is_finished, c.views, sj.subject_id, sj.subject_name,
    u.user_id, u.user_name, rt.avg_rate
    from `courses` c
    inner join `subjects` sj
    on sj.subject_id = c.subject_id
    inner join `instructor_courses_uploaded` ins
    on ins.course_id = c.course_id
    inner join `users`u
    on u.user_id = ins.user_id
    inner join (
    select *, avg(star) as avg_rate
    from course_reviews crw 
    group by crw.course_id
    ) rt
    where c.is_finished = true
    group by c.course_id
    limit 9
    offset 17;

----------------------------------------------------
--  all course by sub cat 
----------------------------------------------------
select c.course_id, c.course_name, c.course_title, c.course_avatar_url,
c.course_fee, c.course_last_updated, c.is_finished, c.views, sj.subject_id, sj.subject_name,
u.user_id, u.user_name, rt.avg_rate
from `courses` c
inner join `subjects` sj
on sj.subject_id = c.subject_id
inner join `instructor_courses_uploaded` ins
on ins.course_id = c.course_id
inner join `users` u
on u.user_id = ins.user_id
inner join (
select *, avg(star) as avg_rate
from course_reviews crw 
group by crw.course_id
) rt
where sj.subject_name = 'reactjs'
and c.is_finished = true
group by c.course_id
limit 9
offset 0;

----------------------------------------------------
--  course Fulltext search by keyword (course name , subcat)
----------------------------------------------------
select c.course_id, c.course_name, c.course_title, c.course_avatar_url,
c.course_fee, c.course_last_updated, c.is_finished, c.views, sj.subject_id, sj.subject_name,
u.user_id, u.user_name, rt.avg_rate
from `courses` c 
left join `subjects` sj
on sj.subject_id = c.subject_id
left join `instructor_courses_uploaded` ins
on ins.course_id = c.course_id
left join `users` u
on u.user_id = ins.user_id
inner join (
select *, avg(star) as avg_rate
from course_reviews crw 
group by crw.course_id
) rt
where match(c.course_name)
against ('shiba1' in natural language mode)
or  match(sj.subject_name)
against ('shiba2' in natural language mode)
and c.is_finished = true
group by c.course_id
limit 9
offset 0; 

----------------------------------------------------
--  course Fulltext search by subcat
----------------------------------------------------
select c.course_id, c.course_name, c.course_title, c.course_avatar_url,
c.course_fee, c.course_last_updated, c.is_finished, c.views, sj.subject_id, sj.subject_name,
u.user_id, u.user_name, rt.avg_rate
from `courses` c 
inner join `subjects` sj
on sj.subject_id = c.subject_id
inner join `instructor_courses_uploaded` ins
on ins.course_id = c.course_id
inner join `users` u
on u.user_id = ins.user_id
inner join (
select *, avg(star) as avg_rate
from course_reviews crw 
group by crw.course_id
) rt
where match(sj.subject_name)
against ('nodejs' in natural language mode)
and c.is_finished = true
group by c.course_id
limit 9
offset 0; 

----------------------------------------------------
-- sort by rate ascending not pagi
----------------------------------------------------
select c.course_id, c.course_name, c.course_title, c.course_avatar_url,
c.course_fee, c.course_last_updated, c.is_finished, c.views, sj.subject_name,
ins.user_id, u.user_name, rt.avg_rate
from `courses` c
inner join `subjects` sj
on sj.subject_id = c.subject_id
inner join `instructor_courses_uploaded` ins
on ins.course_id = c.course_id
inner join `users` u
on u.user_id = ins.user_id 
inner join (
select *, avg(star) as avg_rate
from course_reviews crw
group by crw.course_id
) rt
on rt.course_id = c.course_id 
where c.is_finished = true
group by c.course_id
order by rt.avg_rate asc;

----------------------------------------------------
-- all courses not pagi
----------------------------------------------------
select c.course_id, c.course_name, c.course_title, c.course_avatar_url,
    c.course_fee, c.course_last_updated, c.is_finished, c.views, sj.subject_id, sj.subject_name,
    u.user_id, u.user_name, rt.avg_rate
    from `courses` c
    left join `subjects` sj
    on sj.subject_id = c.subject_id
    left join `instructor_courses_uploaded` ins
    on ins.course_id = c.course_id
    left join `users` u
    on u.user_id = ins.user_id
    left join (
    select *, avg(star) as avg_rate
    from course_reviews crw 
    group by crw.course_id
    ) rt
    on rt.course_id = c.course_id
    where c.is_finished = true
    group by c.course_id;


----------------------------------------------------
-- all courses  pagi
----------------------------------------------------
  select c.course_id, c.course_name, c.course_title, c.course_avatar_url,
    c.course_fee, c.course_last_updated, c.is_finished, c.views, sj.subject_id, sj.subject_name,
    u.user_id, u.user_name, rt.avg_rate
    from `courses` c
    left join `subjects` sj
    on sj.subject_id = c.subject_id
    left join `instructor_courses_uploaded` ins
    on ins.course_id = c.course_id
    left join `users` u
    on u.user_id = ins.user_id
   left join (
    select *, avg(star) as avg_rate
    from course_reviews crw 
    group by crw.course_id
    ) rt
    on rt.course_id = c.course_id
    where c.is_finished = true
    group by c.course_id
    limit 9
    offset 10;
    
----------------------------------------------------
-- by price asc
----------------------------------------------------  
select c.course_id, c.course_name, c.course_title, c.course_avatar_url,
c.course_fee, c.course_last_updated, c.is_finished, c.views, sj.subject_name,
ins.user_id, u.user_name, rt.avg_rate
from `courses` c
inner join `subjects` sj
on sj.subject_id = c.subject_id
inner join `instructor_courses_uploaded` ins
on ins.course_id = c.course_id
inner join `users` u
on u.user_id = ins.user_id 
inner join (
select *, avg(star) as avg_rate
from course_reviews crw
group by crw.course_id
) rt
on rt.course_id = c.course_id 
where c.is_finished = true
group by c.course_id
order by c.course_fee asc;

    
----------------------------------------------------
-- Detail: cat price num
----------------------------------------------------
select c.course_id, sj.subject_name, c.course_fee, sal.sale_percent,
rt.avg_rate, num_stu.num_stu_rate, num_stu_en.num_stu_enrolls
from `courses` c
inner join `subjects` sj
on sj.subject_id = c.subject_id
inner join `instructor_courses_uploaded` ins
on ins.course_id = c.course_id
inner join `users` u
on u.user_id = ins.user_id 
inner join (
select *, avg(star) as avg_rate
from course_reviews crw
group by crw.course_id
) rt
on rt.course_id = c.course_id 
inner join `sales` sal
on sal.course_id = c.course_id
inner join (
select *, count(*) as num_stu_rate 
from `course_reviews` crw
group by crw.course_id
) num_stu
on num_stu.course_id = c.course_id
inner join (
select *, count(*) as num_stu_enrolls 
from `student_enrolls` ste
group by ste.course_id
) num_stu_en
on num_stu_en.course_id = c.course_id
where c.is_finished = true
and  c.course_id = 4;


----------------------------------------------------
-- Most enroll course
----------------------------------------------------
select c.course_id, c.course_name, c.course_avatar_url, c.course_fee,
c.views, c.course_last_updated, c.is_finished, sj.subject_id, 
sj.subject_name, ins.user_id, u.user_name, sal.sale_percent, ste.num_stu_enroll
from `courses` c
inner join `subjects` sj
on sj.subject_id = c.subject_id 
inner join `instructor_courses_uploaded` ins
on ins.course_id = c.course_id
inner join `users` u
on u.user_id = ins.user_id
inner join (
select *, avg(star) as avg_rate
from course_reviews crw
group by crw.course_id
) rt
on rt.course_id = c.course_id 
inner join `sales` sal 
on sal.course_id = c.course_id
inner join (
select *,count(*) as num_stu_enroll
from `student_enrolls` ste
group by ste.course_id
) ste
on ste.course_id = c.course_id
group by c.course_id ;


----------------------------------------------------
-- Feedbacks
----------------------------------------------------
select cr.user_id, cr.course_id, cr.review_content, cr.star ,
u.user_name
from `course_reviews` cr
inner join `users` u
on u.user_id = cr.user_id;


----------------------------------------------------
-- accept all course by sub cat
----------------------------------------------------
update `courses` c 
set c.is_finished = true
where c.subject_id = 10;


----------------------------------------------------
-- get verify account status
----------------------------------------------------
select u.is_verified 
from `users` u
where u.email = 'duccao1@gmail.com';

----------------------------------------------------
-- add otp link
----------------------------------------------------
update `users` u
set u.otp_verify_url = ''
where u.email = '';


--------------------------------------------------
-- get otp link 
----------------------------------------------------
select u.otp_verify_url 
from `users` u
where u.email='';
--------------------------------------------------
-- verify account
----------------------------------------------------
update `users` u
set u.is_verified=true 
where u.otp_verify_url='';

--------------------------------------------------
-- get purchased courses
----------------------------------------------------
select c.course_id, c.course_name, c.course_title, c.course_avatar_url,
c.course_fee, c.views, u.user_name, u.user_id, sj.subject_name, sj.subject_id
from `orders` od
inner join `orders_details` odd
on od.order_id = odd.order_id
inner join `courses` c
on c.course_id = odd.course_id 
inner join `users` u
on u.user_id = od.user_id 
inner join `subjects` sj
on sj.subject_id = c.subject_id
where u.email = 'caovanducs@gmail.com';


select od.order_id, od.user_id, od.order_day, odd.course_id,
odd.total_money, c.course_name, c.course_avatar_url, sj.subject_id,
sj.subject_name, u.email
from `orders` od
inner join `orders_details` odd
on od.order_id = odd.order_id
inner join `users` u 
on u.user_id = od.user_id 
inner join `courses` c
on c.course_id = odd.course_id
inner join `subjects` sj 
on sj.subject_id = c.subject_id
where u.user_id = 7;

-------------------------------------------------
-- check pass
----------------------------------------------------
select *
from `users` u
where u.email='caovanducss@gmail.com'
and u.password = 'duccao_admin';

-------------------------------------------------
-- get count course in sub cat
----------------------------------------------------
select sj.subject_id, sj.subject_name, cat.cat_name , count(*) as count_course
from `subjects` sj
inner join `categories` cat
on cat.cat_id = sj.cat_id 
inner join `courses` c
on c.subject_id = sj.subject_id
group by  sj.subject_id
order by count_course desc;


-------------------------------------------------
-- subcat detail
----------------------------------------------------
select  sj.subject_id, sj.subject_name, c.cat_id, c.cat_name
from `subjects` sj
inner join `categories` c
on c.cat_id = sj.cat_id 
where sj.subject_id =1;

-------------------------------------------------
-- delete course
----------------------------------------------------
delete 
from `instructor_courses_uploaded` ins
where ins.course_id =1;

delete 
from `courses` cs
where c.course_id =1;


-------------------------------------------------
-- all ins
----------------------------------------------------
select  *
from `users` u
where u.role_id =3;

-------------------------------------------------
-- edit ins
----------------------------------------------------
update `users` u
set u.user_name='new'
and u.email = 'mew' 
where u.role_id = 3
and u.user_id = 7;

update users u
      set u.user_name='new 2', u.email = 'new@2g.com'
      where u.role_id = 3
      and u.user_id = 8;


-------------------------------------------------
-- check course name
----------------------------------------------------
select *
from `courses` c
where c.course_name = '1';

-------------------------------------------------
-- get uploaded courses
----------------------------------------------------
select iu.user_id, u.user_name, iu.course_id, iu.chap_id, 
iu.lesson_id, iu.uploaded_day, c.course_name, c.course_title,
c.course_avatar_url, c.course_fee, sj.subject_id, sj.subject_name
    from `instructor_courses_uploaded` iu
    inner join `users` u
    on u.user_id = iu.user_id 
    inner join `courses` c
    on c.course_id = iu.course_id
    inner join `subjects` sj
    on sj.subject_id = c.subject_id
    where u.email = 'ch01@yopmail.com'
    group by c.course_id;
    
    
-------------------------------------------------
-- upload chapter
----------------------------------------------------
update `instructor_courses_uploaded` ins_up
set ins_up.chap_id = 2, ins_up.uploaded_day = '2021-11-11 00:00:00'
where ins_up.user_id = 15 and ins_up.course_id = 32;

    
-------------------------------------------------
-- get course upload exists
----------------------------------------------------
select c.chap_id, c.chap_name, ins_up.course_id, ins_up.user_id,
cou.course_name
from `instructor_courses_uploaded` ins_up
inner join `chapters` c
on c.chap_id = ins_up.chap_id
inner join `courses` cou 
on cou.course_id = ins_up.course_id
where ins_up.course_id = 22;

-------------------------------------------------
-- get lesson exists
----------------------------------------------------
select ls.lesson_id, ls.lesson_name, chap.chap_id,
chap.chap_name
from `lessons` ls
inner join `chapters` chap
on chap.chap_id = ls.chap_id
where ls.chap_id = 1;


-------------------------------------------------
-- get chapter in syllabus
----------------------------------------------------
select ins.course_id, ins.chap_id, ch.chap_name, le.lesson_content
ins.lesson_id, le.lesson_name, le.lesson_video_url, le.flag_reviewable
from `instructor_courses_uploaded` ins
inner join `chapters` ch 
on ch.chap_id = ins.chap_id 
inner join `lessons` le 
on le.lesson_id = ins.lesson_id 
where ins.course_id = 22;


-------------------------------------------------
-- edit short des 
----------------------------------------------------
update `courses` as c 
set c.course_short_description = 'dasd'
where course_id = 1;

-------------------------------------------------
-- check ins up course 
----------------------------------------------------
select *
from `instructor_courses_uploaded` ins 
where ins.course_id = 1 
and ins.user_id = 1;

-------------------------------------------------
--  get favorite coruse
----------------------------------------------------
select sf.fav_id, sf.user_id as stu_id, sf.course_id, sf.is_favorite,
u.user_name as stu_name, c.course_name, c.course_fee, ins.user_name as ins_name
 from  `student_favorites` sf
 left join `users` u
 on u.user_id = sf.user_id
 left join `courses` c
 on c.course_id = sf.course_id 
 left join (
 select u.user_name, ins.user_id, c.course_id
 from `instructor_courses_uploaded` ins
 inner join `courses` c
 on ins.course_id = c.course_id 
 inner join `users` u
 on u.user_id = ins.user_id
 ) ins
 on ins.course_id = c.course_id
 where sf.is_favorite = true
 and sf.user_id = 15;
 
-------------------------------------------------
--  is favorite
----------------------------------------------------
select sf.is_favorite
from `student_favorites` sf 
where  sf.user_id =3
and sf.course_id =3;

-------------------------------------------------
--  toggle favorite
----------------------------------------------------
update `student_favorites` sf
set sf.is_favorite = false
where sf.user_id =3
and sf.course_id = 3;


-------------------------------------------------
--  add to favorite
----------------------------------------------------
insert 
into `student_favorites` 
(user_id,course_id,is_favorite) 
values (3,2,true);

-------------------------------------------------
--  get history
----------------------------------------------------
select h.start_time
from `student_watching` h
where h.user_id = 19
and h.lesson_id = 5;

select * from `users` inner join instructor_courses_uploaded c
on c.user_id = users.user_id;

select c.course_name , c.course_id
from `courses` c
where c.course_id in 
(
select d.course_id
from `orders_details` d
group by d.course_id
order by count(*) desc
)
limit 3;


select substr("123456",1,1);
select substr("123456",length("123456"),3);

select u.user_name
from `users` u
where substr(u.user_name,1,1)  in ('a','e','o','u','i')
and substr(u.user_name,length(u.user_name),1)  in ('a','e','o','u','i');

select u.user_name
from `users` u
where u.user_name not  regexp'^[aeoui]';


-- ---------------
--	Bug full text search 
-- ----------------
select c.course_id, c.course_name, c.course_title, c.course_avatar_url,
    c.course_fee, c.course_last_updated, c.is_finished, c.views, sj.subject_id, sj.subject_name,
    u.user_id, u.user_name, rt.avg_rate, rt.total_review, ste.num_stu_enroll
    from `courses` c 
    left join `subjects` sj
    on sj.subject_id = c.subject_id
    left join `instructor_courses_uploaded` ins
    on ins.course_id = c.course_id
    left join `users` u
    on u.user_id = ins.user_id
    left join (
    select *, count(*) as total_review, avg(star) as avg_rate
    from course_reviews crw 
    group by crw.course_id
    ) rt
    on rt.course_id = c.course_id
    left join (
    select *,count(*) as num_stu_enroll
    from `student_enrolls` ste
    group by ste.course_id
    ) ste
    on ste.course_id = c.course_id
    where 
	c.is_finished = true
    and 
    match(c.course_name)
    against ('shiba' in natural language mode)
    or  
    match(sj.subject_name)
    against ('shiba' in natural language mode)
    group by c.course_id
    limit 20
    offset 0;




use `SPA_ONLINE_ACADEMY`;
select * from `users`;

select * from `users` 
where user_name = any 
union
select * from `courses`;

select * from `courses` c
where c.is_finished = false 
or c.is_finished = true ;


select * from `instructor_courses_uploaded`;
select * from `chapters`;
select * from `lessons`;
select * from `student_favorites`;

select * from `subjects`;
select * from `roles`;
select * from `categories`;
select * from `student_watching`;

select * from `sales`;
select count(*) from `courses`;
select * from `carts`;
select * from `orders`;
select * from `orders_details`;
select * from `course_reviews`;

select * from `student_enrolls`;




--------------------------------------------------
-- del user 
----------------------------------------------------
delete from `users` u
where u.email='caovanducs@gmail.com';



