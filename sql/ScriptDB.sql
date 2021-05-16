DROP DATABASE IF EXISTS `SPA_ONLINE_ACADEMY`;
CREATE DATABASE `SPA_ONLINE_ACADEMY`;
use `SPA_ONLINE_ACADEMY`;

-------------------------------------
-- Table structure for `roles`
-------------------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`(
	role_id INT(10) PRIMARY KEY NOT NULL auto_increment,
    role_name varchar(200)
);

-------------------------------------
-- Records for `roles`
-------------------------------------
insert into `roles` (role_name) values ('anonymous');
insert into `roles` (role_name) values ('student');
insert into `roles` (role_name) values ('instructor');
insert into `roles` (role_name) values ('administrator');
insert into `roles` (role_name) values ('common');
insert into `roles` (role_name) values ('chatbot_facebook');



-------------------------------------
-- Table structure for `users`
-------------------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`(
	user_id int(10) primary key not null auto_increment,
    user_name nvarchar(4000),
    password nvarchar(4000),
    email  nvarchar(4000),
    date_of_birth date,
    is_verified bool,
    otp_verify_url  nvarchar(4000),
    user_avatar_url  nvarchar(4000),
    role_id int,
    `rfToken` VARCHAR(255)  DEFAULT NULL,

	foreign key (role_id) references `roles` (role_id) on delete cascade
);

-------------------------------------
-- Records  for `users`
-------------------------------------
insert into `users` (user_name,password,email,date_of_birth,is_verified,otp_verify_url,user_avatar_url,role_id) values ('duccao','duccao','duc@gmail.com',STR_TO_DATE('27-03-1999','%d-%m-%Y'),true,'https://','https://',1);
insert into `users` (user_name,password,email,date_of_birth,is_verified,otp_verify_url,user_avatar_url,role_id) values ('duccao_admin','duccao_admin','caovanducs@gmail.com',STR_TO_DATE('27-03-1999','%d-%m-%Y'),true,'https://','https://',4);
insert into `users` (user_name,password,email,date_of_birth,is_verified,otp_verify_url,user_avatar_url,role_id) values ('lamtu_admin','lamtu_admin','chanestdevil@gmail.com',STR_TO_DATE('27-03-1999','%d-%m-%Y'),true,'https://','https://',4);

insert into `users` (user_name,password,email,date_of_birth,is_verified,otp_verify_url,user_avatar_url,role_id) values ('student01','student01','student01@gmail.com',STR_TO_DATE('27-03-1999','%d-%m-%Y'),true,'https://','https://',2);
insert into `users` (user_name,password,email,date_of_birth,is_verified,otp_verify_url,user_avatar_url,role_id) values ('student02','student02','student02@gmail.com',STR_TO_DATE('27-03-1999','%d-%m-%Y'),true,'https://','https://',2);
insert into `users` (user_name,password,email,date_of_birth,is_verified,otp_verify_url,user_avatar_url,role_id) values ('student03','student03','student03@gmail.com',STR_TO_DATE('27-03-1999','%d-%m-%Y'),true,'https://','https://',2);

insert into `users` (user_name,password,email,date_of_birth,is_verified,otp_verify_url,user_avatar_url,role_id) values ('instructor01','instructor01','instructor01@gmail.com',STR_TO_DATE('27-03-1999','%d-%m-%Y'),true,'https://','https://',3);
insert into `users` (user_name,password,email,date_of_birth,is_verified,otp_verify_url,user_avatar_url,role_id) values ('instructor02','instructor02','instructor02@gmail.com',STR_TO_DATE('27-03-1999','%d-%m-%Y'),true,'https://','https://',3);
insert into `users` (user_name,password,email,date_of_birth,is_verified,otp_verify_url,user_avatar_url,role_id) values ('instructor03','instructor03','instructor03@gmail.com',STR_TO_DATE('27-03-1999','%d-%m-%Y'),true,'https://','https://',3);

insert into `users` (user_name,password,email,date_of_birth,is_verified,otp_verify_url,user_avatar_url,role_id) values ('student04','student04','student04@gmail.com',STR_TO_DATE('27-03-1999','%d-%m-%Y'),true,'https://','https://',2);
insert into `users` (user_name,password,email,date_of_birth,is_verified,otp_verify_url,user_avatar_url,role_id) values ('student05','student05','student05@gmail.com',STR_TO_DATE('27-03-1999','%d-%m-%Y'),true,'https://','https://',2);
insert into `users` (user_name,password,email,date_of_birth,is_verified,otp_verify_url,user_avatar_url,role_id) values ('student06','student06','student06@gmail.com',STR_TO_DATE('27-03-1999','%d-%m-%Y'),true,'https://','https://',2);


-------------------------------------
-- Table structure for `categories`
-------------------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories`(
	cat_id int(10) primary key not null auto_increment,
    cat_name nvarchar(4000)
);

-------------------------------------
-- Records  for `categories`
-------------------------------------
insert into `categories`(cat_name) values ('Web application development');
insert into `categories`(cat_name) values ('Mobile application development');


-------------------------------------
-- Table structure for `subjects`
-------------------------------------
DROP TABLE IF EXISTS `subjects`;
CREATE TABLE `subjects`(
	subject_id int(10) primary key not null auto_increment,
    subject_name nvarchar(4000),
    cat_id int(10),
    foreign key (cat_id) references `categories` (cat_id) on delete cascade
);

-------------------------------------
-- Records  for `subjects`
-------------------------------------
insert into `subjects`(subject_name,cat_id) values ('NodeJS',1);
insert into `subjects`(subject_name,cat_id) values ('ReactJS',1);
insert into `subjects`(subject_name,cat_id) values ('Pure Javascript',1);
insert into `subjects`(subject_name,cat_id) values ('Pure PHP',1);
insert into `subjects`(subject_name,cat_id) values ('Pure Java',1);
insert into `subjects`(subject_name,cat_id) values ('Java Springboot',1);
insert into `subjects`(subject_name,cat_id) values ('React Native',2);
insert into `subjects`(subject_name,cat_id) values ('Flutter',2);
insert into `subjects`(subject_name,cat_id) values ('Android',2);
insert into `subjects`(subject_name,cat_id) values ('IOS',2);
insert into `subjects`(subject_name,cat_id) values ('Swift',2);



-------------------------------------
-- Table structure for `courses`
-------------------------------------
DROP TABLE IF EXISTS `courses`;
CREATE TABLE `courses`(
	course_id int(10) primary key not null auto_increment,
    course_name nvarchar(1000),
    course_title nvarchar(1000),
	course_thumbnail nvarchar(1000),
	course_avatar_url nvarchar(4000),
    course_fee nvarchar(1000),
    course_full_description nvarchar(8000),
	course_short_description nvarchar(4000),
	course_last_updated TIMESTAMP,
	is_finished bool,
    subject_id int(10),
    views int(10) default null,
    
    foreign key (subject_id) references `subjects` (subject_id) on delete cascade
);

-------------------------------------
-- Records  for `courses`
-------------------------------------
insert into `courses`(course_name,course_title,course_thumbnail,course_avatar_url,course_fee,course_full_description,course_short_description,course_last_updated,is_finished,subject_id) 
values ('React - The Complete Guide (incl Hooks, React Router, Redux)','React - The Complete Guide','','https://img-c.udemycdn.com/course/240x135/1362070_b9a1_2.jpg?Expires=1621142294&Signature=YkpacdOxrPqJxvFJWomoqv6mUEgYrLYeUyLcyrCzHootBf7kxvDQ7pZMwGq7pi3DZ068d-pN6eEK-bh02uU5PJw0k7b2v~9SUqsjgKJl0foW40YzNq~P1VHsU2zvpIuncDIKmnN24sWh-K2P4kTQcanM3ujeC~ioMEd8FXxXBa1yaTiADlmK1GGbhbRpjQtBBmXM8B2ht0~fZzBwhS551Ksf5PM427cRYp3MJFYnTEb2BKEXXDBLt6GMXXi-qfi8heQk9KBU5q-Vzm4v0OtJn0npX4-Uc~581QwHiY8Nxi8mDvM2dafpIM6pUrI3jwF~g7F5myMPlIvvyII2GsbBVw__&Key-Pair-Id=APKAITJV77WS5ZT7262A','40000000',
'<div data-purpose="safely-set-inner-html:description:description">
<p><strong>This course is the most up-to-date, comprehensive and bestselling React course on Udemy!</strong></p>
<p><strong>It was completely updated and re-recorded from the ground up in May 2021 - it teaches the very latest version of React with all the core, modern features you need to know!</strong></p>
<p>---</p>
<p>This course also comes with&nbsp;<strong>two paths</strong>&nbsp;which you can take:&nbsp;The&nbsp;<strong>"complete"&nbsp;path</strong>&nbsp;(full &gt;40h course) and the&nbsp;<strong>"summary"&nbsp;path</strong>&nbsp;(~4h summary module) - you can choose the path that best fits your time requirements!&nbsp;:-)</p>
<p>---</p>
<p>React.js is&nbsp;<strong>THE most popular JavaScript library</strong>&nbsp;you can use and learn these days to build modern, reactive user interfaces for the web.</p>
<p>This course teaches you React in-depth,&nbsp;<strong>from the ground up</strong>, step by step by diving into all the core basics, exploring tons of examples and also introducing you to advanced concepts as well.</p>
<p>You will get&nbsp;<strong>all the theory, tons of examples and demos, assignments and exercises and tons of important knowledge</strong>&nbsp;that is skipped by most other resources - after all, there is a reason why this course is that huge! :)</p>
<p>And in case you don t even know why you would want to learn React and you re just here because of some ad or "the algorithm" - no worries: ReactJS is a key technology as a web developer and&nbsp;<strong>in this course I will also explain WHY its that important</strong>!</p>
<p>&nbsp;</p>
<p><strong>Welcome to "React - The Complete Guide"!</strong></p>
<p>This course will teach you React.js in a practice-oriented way, using all the latest patterns and best practices you need. You will learn all the key fundamentals as well as advanced concepts and related topics to turn you into a React.js developer.</p>
<p>This is a huge course because&nbsp;<strong>it really covers EVERYTHING you need to know and learn to become a React.js developer!</strong></p>
<p>No matter if you&nbsp;<strong>know nothing about React</strong>&nbsp;or if you already&nbsp;<strong>got some basic React knowledge</strong>&nbsp;(not required but also not a problem), you will get&nbsp;<strong>tons of useful information and knowledge out of this course</strong>!</p>
<p>My goal with this course is to ensure that you feel confident working with React, so that you can apply for React jobs, use it in your own projects or simply enhance your portfolio as a developer - whatever your goal is: This course gets you there!</p>
<p>&nbsp;</p>
<p>I originally created this course in 2017 and I have kept it updated since that -&nbsp;<strong>redoing it from the ground up in 2021</strong>. And of course Im dedicated to keeping this course up-to-date - so that you can rely on this course to learn React in the best possible way!</p>
<p><strong>Whats in this course?</strong></p>
<ul>
<li>
<p>A thorough introduction to React.js (What is it and why would you use it?)</p>
</li>
<li>
<p>All the core basics: How React works, building components with React &amp; building UIs with React</p>
</li>
<li>
<p>Components, props &amp; dynamic data binding</p>
</li>
<li>
<p>Working with user events and state to create interactive applications</p>
</li>
<li>
<p>A (thorough) look behind the scenes to understand how React works under the hood</p>
</li>
<li>
<p>Detailed explanations on how to work with lists and conditional content</p>
</li>
<li>
<p>React Hooks (in-depth)!</p>
</li>
<li>
<p>Working with built-in Hooks and building custom Hooks</p>
</li>
<li>
<p>How to debug React apps</p>
</li>
<li>
<p>Styling React apps with "Styled Components" and "CSS Modules"</p>
</li>
<li>
<p>Working with "Fragments" &amp; "Portals"</p>
</li>
<li>
<p>Dealing with side effects</p>
</li>
<li>
<p>Class-based components and functional components</p>
</li>
<li>
<p>Sending Http requests &amp; handling transitional states + responses</p>
</li>
<li>
<p>Handling forms and user input (incl. validation)</p>
</li>
<li>
<p>Redux &amp; Redux Toolkit</p>
</li>
<li>
<p>Routing with React Router</p>
</li>
<li>
<p>An in-depth introduction into Next.js</p>
</li>
<li>
<p>Deploying React Apps</p>
</li>
<li>
<p>Implementing Authentication</p>
</li>
<li>
<p>Unit Tests</p>
</li>
<li>
<p>Combining React with TypeScript</p>
</li>
<li>
<p>Adding Animations</p>
</li>
<li>
<p>Tons of examples and demo projects so that you can apply all the things you learned in real projects</p>
</li>
<li>
<p>And so much more - check out the full curriculum on this page!</p>
</li>
</ul>
<p>This really is the "Complete Guide" - promised!</p>
<p>And best of all?</p>
<p><strong>You dont need any prior React knowledge!</strong></p>
<p>This course starts with zero knowledge assumed!&nbsp;<strong>All you need is basic web development and JavaScript knowledge</strong>&nbsp;(though the course even&nbsp;<strong>includes a brief JavaScript refresher</strong>&nbsp;to ensure that we are all on the same page!).</p>
<p><strong>Check out the full curriculum, the free preview videos and join the course risk-free thanks to the 30-day money-back guarantee!</strong></p>
</div>
<div class="styles--audience--2pZ0S" data-purpose="target-audience">
<h2 class="udlite-heading-xl styles--audience__title--1Sob_">Who this course is for:</h2>
<ul class="styles--audience__list--3NCqY">
<li>Students who want to learn how to build reactive and fast web apps</li>
<li>Anyone whos interested in learning an extremely popular technology used by leading tech companies like Netflix</li>
<li>Students who want to take their web development skills to the next level and learn a future-proof technology</li>
</ul>
</div>
<div id="eJOY__extension_root" class="eJOY__extension_root_class" style="all: unset;">&nbsp;</div>',
'<div data-purpose="safely-set-inner-html:description:description">
<div class="course-landing-page__main-content component-margin">
<div class="clp-component-render">
<div class="clp-component-render">
<div class="ud-component--course-landing-page-udlite--requirements" data-component-props="{&quot;prerequisites&quot;:[&quot;JavaScript + HTML + CSS fundamentals are absolutely required&quot;,&quot;You DONT need to be a JavaScript expert to succeed in this course!&quot;,&quot;ES6+ JavaScript knowledge is beneficial but not a must-have&quot;,&quot;NO prior React or any other JS framework experience is required!&quot;],&quot;isCollapsible&quot;:false}">
<div>
<ul class="unstyled-list udlite-block-list">
<li>
<div class="udlite-block-list-item udlite-block-list-item-small udlite-block-list-item-tight udlite-block-list-item-neutral udlite-text-sm">
<div class="udlite-block-list-item-content">JavaScript + HTML + CSS fundamentals are absolutely required</div>
</div>
</li>
<li>
<div class="udlite-block-list-item udlite-block-list-item-small udlite-block-list-item-tight udlite-block-list-item-neutral udlite-text-sm">
<div class="udlite-block-list-item-content">You DONT need to be a JavaScript expert to succeed in this course!</div>
</div>
</li>
<li>
<div class="udlite-block-list-item udlite-block-list-item-small udlite-block-list-item-tight udlite-block-list-item-neutral udlite-text-sm">
<div class="udlite-block-list-item-content">ES6+ JavaScript knowledge is beneficial but not a must-have</div>
</div>
</li>
<li>
<div class="udlite-block-list-item udlite-block-list-item-small udlite-block-list-item-tight udlite-block-list-item-neutral udlite-text-sm">
<div class="udlite-block-list-item-content">NO prior React or any other JS framework experience is required!</div>
</div>
</li>
</ul>
</div>
</div>
</div>
</div>
</div>
<div class="clp-component-render">&nbsp;</div>
</div>','2008-01-01 00:00:01',true,2);


insert into `courses`(course_name,course_title,course_thumbnail,course_avatar_url,course_fee,course_full_description,course_short_description,course_last_updated,is_finished,subject_id) 
values ('Learn and Understand NodeJS','Dive deep under the hood of NodeJS. Learn V8, Express, the MEAN stack, core Javascript concepts, and more.','','https://img-b.udemycdn.com/course/240x135/461160_8d87_6.jpg?secure=tYL9a3DZGrDtHankOr23SA%3D%3D%2C1621150709'
,'2000000',
'<div data-purpose="safely-set-inner-html:description:description">
<div class="course-landing-page__main-content component-margin">
<div class="clp-component-render">
<div class="clp-component-render">
<div class="ud-component--course-landing-page-udlite--requirements" data-component-props="{&quot;prerequisites&quot;:[&quot;JavaScript + HTML + CSS fundamentals are absolutely required&quot;,&quot;You DONT need to be a JavaScript expert to succeed in this course!&quot;,&quot;ES6+ JavaScript knowledge is beneficial but not a must-have&quot;,&quot;NO prior React or any other JS framework experience is required!&quot;],&quot;isCollapsible&quot;:false}">
<ul class="unstyled-list udlite-block-list">
<li>
<div class="udlite-block-list-item udlite-block-list-item-small udlite-block-list-item-tight udlite-block-list-item-neutral udlite-text-sm">
<div class="udlite-block-list-item-content">
<div data-purpose="safely-set-inner-html:description:description">
<p>NodeJS is a rapidy growing web server technology, and Node developers are among the highest paid in the industry. Knowing NodeJS well will get you a job or improve your current one by enabling you to build high quality, robust web applications.</p>
<p>In this course you will gain a deep understanding of Node, learn how NodeJS works under the hood, and how that knowledge helps you avoid common pitfalls and&nbsp;<em>drastically improve your ability to debug problems</em>.</p>
<p>In this course well look at&nbsp;<strong>how the C++ written V8 Javascript engine works and how NodeJS uses it to expand the abilities of Javascript</strong>. Youll learn how to structure your code for reuse and to be easier to understand, manage, and expand using&nbsp;<strong>modules and understand how modules really work</strong>.</p>
<p>Youll learn&nbsp;<strong>how asynchronous code works in Node and the Node event loop</strong>, as well as how to use the&nbsp;<strong>event emitter, streams, buffers, pipes, and work with files</strong>. Well see how that leads to&nbsp;<strong>building a web server in Node</strong>.</p>
<p>Well dive into<strong>&nbsp;web sites, web apps and APIs with Express</strong>&nbsp;and learn how Express can save us time as Node developers.</p>
<p>Youll also gain an understanding of&nbsp;<strong>npm, connecting to databases, and the MEAN stack</strong>!</p>
<p>During it all youll gain a deep understanding of the Javascript concepts and other computer science concepts that power Node.</p>
<p>NodeJS doesnt have to be hard to learn. The biggest mistake most coding tutorials make is expecting someone to learn simply by imitating others code. Real world situations are never exactly like the tutorial.</p>
<p>I believe the best way to learn is to understand how a tool works and what it does for you, look at examples, and then try it yourself. Thats how this course is built, with the goal to help you both learn and understand NodeJS.</p>
<p><em>Note: In this course youll also get&nbsp;</em><strong><em>downloadable source code</em></strong><em>. You will often be provided with starter code, giving you the base for you to start writing your code, and finished code to compare your code to.</em></p>
</div>
<div class="styles--audience--2pZ0S" data-purpose="target-audience">
<h2 class="udlite-heading-xl styles--audience__title--1Sob_">Who this course is for:</h2>
<ul class="styles--audience__list--3NCqY">
<li>Those looking to build a career as a NodeJS developer</li>
<li>Those desiring to become MEAN stack developers</li>
<li>Those who dont have server technology experience but wish to gain this skill</li>
<li>Those coming from other server technologies (like PHP, ASP.NET, or Ruby on Rails) and want to learn Node</li>
<li>Those who want to only have to write both client and server code in one language: Javascript</li>
<li>Those who want to grasp Express</li>
</ul>
</div>
</div>
</div>
</li>
</ul>
</div>
</div>
</div>
</div>
</div>','<!-- #######  YAY, I AM THE SOURCE EDITOR! #########-->
<h2 class="udlite-heading-xl what-you-will-learn--title--hropy">What youll learn</h2>
<div class="what-you-will-learn--content-spacing--3btHJ show-more--container--1QLmn">
<div class="show-more--content--isg5c show-more--with-gradient--2abmN">
<div>
<ul class="unstyled-list udlite-block-list what-you-will-learn--objectives-list--2cWZN">
<li>
<div class="udlite-block-list-item udlite-block-list-item-small udlite-block-list-item-tight udlite-block-list-item-neutral udlite-text-sm" data-purpose="objective">
<div class="udlite-block-list-item-content">Grasp how NodeJS works under the hood</div>
</div>
</li>
<li>
<div class="udlite-block-list-item udlite-block-list-item-small udlite-block-list-item-tight udlite-block-list-item-neutral udlite-text-sm" data-purpose="objective">
<div class="udlite-block-list-item-content">Understand the Javascript and technical concepts behind NodeJS</div>
</div>
</li>
<li>
<div class="udlite-block-list-item udlite-block-list-item-small udlite-block-list-item-tight udlite-block-list-item-neutral udlite-text-sm" data-purpose="objective">
<div class="udlite-block-list-item-content">Structure a Node application in modules</div>
</div>
</li>
<li>
<div class="udlite-block-list-item udlite-block-list-item-small udlite-block-list-item-tight udlite-block-list-item-neutral udlite-text-sm" data-purpose="objective">
<div class="udlite-block-list-item-content">Understand and use the Event Emitter</div>
</div>
</li>
<li>
<div class="udlite-block-list-item udlite-block-list-item-small udlite-block-list-item-tight udlite-block-list-item-neutral udlite-text-sm" data-purpose="objective">
<div class="udlite-block-list-item-content">Understand Buffers, Streams, and Pipes</div>
</div>
</li>
<li>
<div class="udlite-block-list-item udlite-block-list-item-small udlite-block-list-item-tight udlite-block-list-item-neutral udlite-text-sm" data-purpose="objective">
<div class="udlite-block-list-item-content">Build a Web Server in Node and understand how it really works</div>
</div>
</li>
<li>
<div class="udlite-block-list-item udlite-block-list-item-small udlite-block-list-item-tight udlite-block-list-item-neutral udlite-text-sm" data-purpose="objective">
<div class="udlite-block-list-item-content">Use npm and manage node packages</div>
</div>
</li>
<li>
<div class="udlite-block-list-item udlite-block-list-item-small udlite-block-list-item-tight udlite-block-list-item-neutral udlite-text-sm" data-purpose="objective">
<div class="udlite-block-list-item-content">Build a web application and API more easily using Express</div>
</div>
</li>
<li>
<div class="udlite-block-list-item udlite-block-list-item-small udlite-block-list-item-tight udlite-block-list-item-neutral udlite-text-sm" data-purpose="objective">
<div class="udlite-block-list-item-content">Connect to a SQL or Mongo database in Node</div>
</div>
</li>
<li>
<div class="udlite-block-list-item udlite-block-list-item-small udlite-block-list-item-tight udlite-block-list-item-neutral udlite-text-sm" data-purpose="objective">
<div class="udlite-block-list-item-content">Understand how the MEAN stack works</div>
</div>
</li>
<li>
<div class="udlite-block-list-item udlite-block-list-item-small udlite-block-list-item-tight udlite-block-list-item-neutral udlite-text-sm" data-purpose="objective">
<div class="udlite-block-list-item-content">Be the coder that explains NodeJS to everyone else because you understand it better than anyone else</div>
</div>
</li>
</ul>
</div>
</div>
</div>','2021-05-05- 00:00:01',true,1);



-------------------------------------
-- Table structure for `sales`
-------------------------------------
DROP TABLE IF EXISTS `sales`;
CREATE TABLE `sales`(
	sale_id int(10) primary key not null auto_increment,
    sale_percent int(10),
   course_id int(10),

    foreign key (course_id) references `courses` (course_id) on delete cascade
);

-------------------------------------
-- Records  for `sales`
-------------------------------------
insert into `sales` (sale_percent,course_id) values (90,1);
insert into `sales` (sale_percent,course_id) values (10,2);

-------------------------------------
-- Table structure for `chapters`
-------------------------------------
DROP TABLE IF EXISTS `chapters`;
CREATE TABLE `chapters`(
	chap_id int(10) primary key not null auto_increment,
    chap_name nvarchar(1000),
   course_id int(10),

    foreign key (course_id) references `courses` (course_id) on delete cascade
);

-------------------------------------
-- Records  for `chapters`
-------------------------------------
insert into `chapters` (chap_name,course_id) values ('Introduction',1);
insert into `chapters` (chap_name,course_id) values ('Getting started with React',1);
insert into `chapters` (chap_name,course_id) values ('Learn and Understand NodeJS',2);
insert into `chapters` (chap_name,course_id) values ('Big words and nodejs',2);


-------------------------------------
-- Table structure for `lessons`
-------------------------------------
DROP TABLE IF EXISTS `lessons`;
CREATE TABLE `lessons`(
	lesson_id int(10) primary key not null auto_increment,
    lesson_name nvarchar(1000),
	lesson_content nvarchar(1000),
    flag_reviewable bool,
	duration time,
	chap_id int(10) ,

    foreign key (chap_id) references `chapters` (chap_id) on delete cascade
);

-------------------------------------
-- Records  for `lessons`
-------------------------------------
insert into `lessons` (lesson_name,lesson_content,flag_reviewable,duration,chap_id) values ('lesson 1 introduction react','',1,SEC_TO_TIME(3600),1);
insert into `lessons` (lesson_name,lesson_content,flag_reviewable,duration,chap_id) values ('lesson 2 introduction node','',1,SEC_TO_TIME(7600),2);

-----------------------------------------------------
-- Table structure for `instructor_courses_uploaded`
-----------------------------------------------------
DROP TABLE IF EXISTS `instructor_courses_uploaded`;
CREATE TABLE `instructor_courses_uploaded`(
	user_id int(10) not null ,
    course_id int(10)  not null ,
    lesson_id int(10) not null ,
    chap_id int(10) not null ,
	uploaded_day timestamp,

    primary key (user_id,course_id,chap_id,lesson_id),
    
    foreign key (user_id) references `users` (user_id) on delete cascade,
	foreign key (course_id) references `courses` (course_id) on delete cascade,
	foreign key (chap_id) references `chapters` (chap_id) on delete cascade,
	foreign key (lesson_id) references `lessons` (lesson_id) on delete cascade
);

-------------------------------------------------------------
-- Records  for `instructor_courses_uploaded`
-------------------------------------------------------------
insert into `instructor_courses_uploaded` (user_id,course_id,lesson_id,chap_id,uploaded_day) values (1,1,1,1,STR_TO_DATE('21-05-2021','%d-%m-%Y'));
insert into `instructor_courses_uploaded` (user_id,course_id,lesson_id,chap_id,uploaded_day) values (4,2,2,2,STR_TO_DATE('21-05-2021','%d-%m-%Y'));


-----------------------------------------------------
-- Table structure for `course_reviews`
-----------------------------------------------------
DROP TABLE IF EXISTS `course_reviews`;
CREATE TABLE `course_reviews`(
	user_id int(10) not null ,
    course_id int(10)  not null ,
    review_content nvarchar(4000),
    star int(10),

    primary key (user_id,course_id),
    
    foreign key (user_id) references `users` (user_id) on delete cascade,
	foreign key (course_id) references `courses` (course_id) on delete cascade
);

-------------------------------------------------------------
-- Records  for `course_reviews`
-------------------------------------------------------------
insert into `course_reviews` (user_id,course_id,review_content,star) values (4,1,'Khóa này hay nè!',5);
insert into `course_reviews` (user_id,course_id,review_content,star) values (3,1,'Khóa này hay ghê like!',5);
insert into `course_reviews` (user_id,course_id,review_content,star) values (2,1,'Khóa này hay!',5);
insert into `course_reviews` (user_id,course_id,review_content,star) values (4,2,'Khóa dở tệ!',1);
insert into `course_reviews` (user_id,course_id,review_content,star) values (5,2,'Khóa này tạm được!',3);


-----------------------------------------------------
-- Table structure for `student_courses_bought`
-----------------------------------------------------
DROP TABLE IF EXISTS `student_courses_bought`;
CREATE TABLE `student_courses_bought`(
	user_id int(10) not null ,
    course_id int(10)  not null ,
	bought_day timestamp,

    primary key (user_id,course_id),
    
    foreign key (user_id) references `users` (user_id) on delete cascade,
	foreign key (course_id) references `courses` (course_id) on delete cascade
);

-------------------------------------------------------------
-- Records  for `student_courses_bought`
-------------------------------------------------------------
insert into `student_courses_bought` (user_id,course_id,bought_day) values (2,2,str_to_date('12-12-2022','%d-%m-%Y'));
insert into `student_courses_bought` (user_id,course_id,bought_day) values (3,2,str_to_date('12-12-2022','%d-%m-%Y'));


-----------------------------------------------------
-- Table structure for `carts`
-----------------------------------------------------
DROP TABLE IF EXISTS `carts`;
CREATE TABLE `carts`(
	cart_id int(10) not null auto_increment,
    user_id int(10)  not null ,
	course_id int(10)  not null ,

    primary key (cart_id,user_id,course_id),
    
    foreign key (user_id) references `users` (user_id) on delete cascade,
	foreign key (course_id) references `courses` (course_id) on delete cascade
);

-------------------------------------------------------------
-- Records  for `carts`
-------------------------------------------------------------
insert into `carts` (user_id,course_id) values (2,1);
insert into `carts` (user_id,course_id) values (3,2);




-----------------------------------------------------
-- Table structure for `orders`
-----------------------------------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`(
	order_id int(10) not null auto_increment,
    user_id int(10)  not null ,
	order_day timestamp,

    primary key (order_id),
    foreign key (user_id) references `users` (user_id) on delete cascade
);

-------------------------------------------------------------
-- Records  for `orders`
-------------------------------------------------------------
insert into `orders` (user_id,order_day,order_total_money) values (2,str_to_date('12-12-2021','%d-%m-%Y'));
insert into `orders` (user_id,order_day,order_total_money) values (3,str_to_date('13-12-2021','%d-%m-%Y'));



-----------------------------------------------------
-- Table structure for `orders_details`
-----------------------------------------------------
DROP TABLE IF EXISTS `orders_details`;
CREATE TABLE `orders_details`(
	order_detail_id int(10) not null auto_increment,
	order_day timestamp,
    course_id int(10) not null,
    order_id int(10) not null,
    total_money varchar(3000),

    primary key (order_detail_id),
    foreign key (course_id) references `courses` (course_id) on delete cascade,
	foreign key (order_id) references `orders` (order_id) on delete cascade
);

-------------------------------------------------------------
-- Records  for `orders`
-------------------------------------------------------------
insert into `orders_details` (order_day,course_id,order_id,total_money) values (str_to_date('12-12-2021','%d-%m-%Y'),1,1,'2000000');
insert into `orders_details` (order_day,course_id,order_id,total_money) values (str_to_date('13-12-2021','%d-%m-%Y'),2,1,'3000000');
insert into `orders_details` (order_day,course_id,order_id,total_money) values (str_to_date('14-12-2021','%d-%m-%Y'),2,2,'3000000');
insert into `orders_details` (order_day,course_id,order_id,total_money) values (str_to_date('14-12-2021','%d-%m-%Y'),2,2,'3000000');
insert into `orders_details` (order_day,course_id,order_id,total_money) values (str_to_date('14-12-2021','%d-%m-%Y'),2,2,'3000000');







