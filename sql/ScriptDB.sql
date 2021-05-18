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
    course_name nvarchar(500),
    course_title nvarchar(500),
	course_thumbnail nvarchar(100),
	course_avatar_url nvarchar(1000),
    course_fee nvarchar(1000),
    course_full_description nvarchar(14000),
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
values ('Fast Tracking React','React - Using fastest speed to learn ReactJS','','https://img-c.udemycdn.com/course/240x135/1362070_b9a1_2.jpg?Expires=1621142294&Signature=YkpacdOxrPqJxvFJWomoqv6mUEgYrLYeUyLcyrCzHootBf7kxvDQ7pZMwGq7pi3DZ068d-pN6eEK-bh02uU5PJw0k7b2v~9SUqsjgKJl0foW40YzNq~P1VHsU2zvpIuncDIKmnN24sWh-K2P4kTQcanM3ujeC~ioMEd8FXxXBa1yaTiADlmK1GGbhbRpjQtBBmXM8B2ht0~fZzBwhS551Ksf5PM427cRYp3MJFYnTEb2BKEXXDBLt6GMXXi-qfi8heQk9KBU5q-Vzm4v0OtJn0npX4-Uc~581QwHiY8Nxi8mDvM2dafpIM6pUrI3jwF~g7F5myMPlIvvyII2GsbBVw__&Key-Pair-Id=APKAITJV77WS5ZT7262A','40000000',
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




insert into `courses`(course_name,course_title,course_thumbnail,course_avatar_url,course_fee,course_full_description,
course_short_description,course_last_updated,is_finished,subject_id) 
values ('Modern React with Redux','Master React and Redux with React Router, Webpack, and Create-React-App. Includes Hooks!'
,'','https://d585tldpucybw.cloudfront.net/sfimages/default-source/blogs/templates/reactt-dark_870x220.png?sfvrsn=ef69fd61_3'
,'9'
,'<div data-purpose="safely-set-inner-html:description:description" style="box-sizing: border-box; margin: 0px; padding: 0px; color: rgb(60, 59, 55); font-family: "sf pro text", -apple-system, BlinkMacSystemFont, Roboto, "segoe ui", Helvetica, Arial, sans-serif, "apple color emoji", "segoe ui emoji", "segoe ui symbol"; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
    <p style="box-sizing: border-box; margin: 0px; padding: 0px; font-size: inherit; font-weight: 400; max-width: 118.4rem;"><strong style="box-sizing: border-box; margin: 0px; padding: 0px;"><em style="box-sizing: border-box; margin: 0px; padding: 0px;">Course Last Updated for React v16.6.3 and Redux v4.0.1! &nbsp;All content is brand new! &nbsp;Update includes detailed videos on the new React Hooks system.</em></strong></p>
    <p style="box-sizing: border-box; margin: 0.8rem 0px 0px; padding: 0px; font-size: inherit; font-weight: 400; max-width: 118.4rem;">Congratulations! &nbsp;You&apos;ve found the&nbsp;<em style="box-sizing: border-box; margin: 0px; padding: 0px;">most&nbsp;</em><strong style="box-sizing: border-box; margin: 0px; padding: 0px;"><em style="box-sizing: border-box; margin: 0px; padding: 0px;">popular</em></strong>,&nbsp;<em style="box-sizing: border-box; margin: 0px; padding: 0px;">most&nbsp;</em><strong style="box-sizing: border-box; margin: 0px; padding: 0px;"><em style="box-sizing: border-box; margin: 0px; padding: 0px;">complete</em></strong>, and&nbsp;<em style="box-sizing: border-box; margin: 0px; padding: 0px;">most&nbsp;</em><strong style="box-sizing: border-box; margin: 0px; padding: 0px;"><em style="box-sizing: border-box; margin: 0px; padding: 0px;">up-to-date</em></strong> resource online for learning React and Redux!</p>
    <p style="box-sizing: border-box; margin: 0.8rem 0px 0px; padding: 0px; font-size: inherit; font-weight: 400; max-width: 118.4rem;">Thousands of other engineers have learned React and Redux, and you can too. &nbsp;This course uses a&nbsp;<strong style="box-sizing: border-box; margin: 0px; padding: 0px;">time-tested, battle-proven</strong> method to make sure you understand exactly how React and Redux work, and will get you a new job working as a software engineer or help you build that app you&apos;ve always been dreaming about.</p>
    <p style="box-sizing: border-box; margin: 0.8rem 0px 0px; padding: 0px; font-size: inherit; font-weight: 400; max-width: 118.4rem;"><strong style="box-sizing: border-box; margin: 0px; padding: 0px;">The difference between this course and all the others: you will understand the design patterns used by top companies to build massively popular web apps.</strong></p>
    <p style="box-sizing: border-box; margin: 0.8rem 0px 0px; padding: 0px; font-size: inherit; font-weight: 400; max-width: 118.4rem;">React is the most popular Javascript library of the last five years, and the job market is still hotter than ever. &nbsp;Companies large and small can&apos;t hire engineers who understand React and Redux fast enough, and salaries for engineers are at an all time high. &nbsp;It&apos;s a great time to learn React!</p>
    <p style="box-sizing: border-box; margin: 0.8rem 0px 0px; padding: 0px; font-size: inherit; font-weight: 400; max-width: 118.4rem;">----------------------</p>
    <p style="box-sizing: border-box; margin: 0.8rem 0px 0px; padding: 0px; font-size: inherit; font-weight: 400; max-width: 118.4rem;"><strong style="box-sizing: border-box; margin: 0px; padding: 0px;"><em style="box-sizing: border-box; margin: 0px; padding: 0px;">What will you build?</em></strong></p>
    <p style="box-sizing: border-box; margin: 0.8rem 0px 0px; padding: 0px; font-size: inherit; font-weight: 400; max-width: 118.4rem;">This course features hundreds of videos with&nbsp;<strong style="box-sizing: border-box; margin: 0px; padding: 0px;">dozens of custom diagrams</strong> to help you understand how React and Redux work. &nbsp;No prior experience with either is necessary. Through tireless, patient explanations and many interesting practical examples, you&apos;ll learn the fundamentals of building dynamic and live web apps using React.</p>
    <p style="box-sizing: border-box; margin: 0.8rem 0px 0px; padding: 0px; font-size: inherit; font-weight: 400; max-width: 118.4rem;">Each topic included in this course is added incrementally, to make sure that you have a solid foundation of knowledge. &nbsp;You&apos;ll find plenty of discussion added in to help you understand exactly when and where to use each feature of React and Redux.</p>
    <p style="box-sizing: border-box; margin: 0.8rem 0px 0px; padding: 0px; font-size: inherit; font-weight: 400; max-width: 118.4rem;"><strong style="box-sizing: border-box; margin: 0px; padding: 0px;">My guarantee to you: there is no other course online that teaches more features of React and Redux. &nbsp;This is the most comprehensive resource there is.</strong></p>
    <p style="box-sizing: border-box; margin: 0.8rem 0px 0px; padding: 0px; font-size: inherit; font-weight: 400; max-width: 118.4rem;"><br style="box-sizing: border-box; margin: 0px; padding: 0px;"></p>
    <p style="box-sizing: border-box; margin: 0.8rem 0px 0px; padding: 0px; font-size: inherit; font-weight: 400; max-width: 118.4rem;">Below is a&nbsp;<strong style="box-sizing: border-box; margin: 0px; padding: 0px;"><em style="box-sizing: border-box; margin: 0px; padding: 0px;">partial list&nbsp;</em></strong>of the topics you&apos;ll find in this course:</p>
    <ul style="box-sizing: border-box; margin: 0.8rem 0px 0px; padding: 0px 0px 0px 2.4rem; font-size: inherit; font-weight: 400; max-width: 118.4rem;">
        <li style="box-sizing: border-box; margin: 0px; padding: 0px 0px 0px 0.8rem;">
            <p style="box-sizing: border-box; margin: 0px; padding: 0px; font-size: inherit; font-weight: 400; max-width: 118.4rem;">Master the&nbsp;<strong style="box-sizing: border-box; margin: 0px; padding: 0px;">fundamental features</strong> of React, including JSX, state, and props</p>
        </li>
        <li style="box-sizing: border-box; margin: 0.4rem 0px 0px; padding: 0px 0px 0px 0.8rem;">
            <p style="box-sizing: border-box; margin: 0px; padding: 0px; font-size: inherit; font-weight: 400; max-width: 118.4rem;">From square one, understand how to build&nbsp;<strong style="box-sizing: border-box; margin: 0px; padding: 0px;">reusable components</strong></p>
        </li>
        <li style="box-sizing: border-box; margin: 0.4rem 0px 0px; padding: 0px 0px 0px 0.8rem;">
            <p style="box-sizing: border-box; margin: 0px; padding: 0px; font-size: inherit; font-weight: 400; max-width: 118.4rem;">Dive into the&nbsp;<strong style="box-sizing: border-box; margin: 0px; padding: 0px;">source code of Redux&nbsp;</strong>to understand how it works behind the scenes</p>
        </li>
        <li style="box-sizing: border-box; margin: 0.4rem 0px 0px; padding: 0px 0px 0px 0.8rem;">
            <p style="box-sizing: border-box; margin: 0px; padding: 0px; font-size: inherit; font-weight: 400; max-width: 118.4rem;">Test your knowledge and hone your skills with&nbsp;<strong style="box-sizing: border-box; margin: 0px; padding: 0px;">numerous coding exercises</strong></p>
        </li>
        <li style="box-sizing: border-box; margin: 0.4rem 0px 0px; padding: 0px 0px 0px 0.8rem;">
            <p style="box-sizing: border-box; margin: 0px; padding: 0px; font-size: inherit; font-weight: 400; max-width: 118.4rem;">Integrate React with advanced browser features, even&nbsp;<strong style="box-sizing: border-box; margin: 0px; padding: 0px;">geolocation API&apos;s</strong>!</p>
        </li>
        <li style="box-sizing: border-box; margin: 0.4rem 0px 0px; padding: 0px 0px 0px 0.8rem;">
            <p style="box-sizing: border-box; margin: 0px; padding: 0px; font-size: inherit; font-weight: 400; max-width: 118.4rem;">Use popular&nbsp;<strong style="box-sizing: border-box; margin: 0px; padding: 0px;">styling libraries&nbsp;</strong>to build beautiful apps</p>
        </li>
        <li style="box-sizing: border-box; margin: 0.4rem 0px 0px; padding: 0px 0px 0px 0.8rem;">
            <p style="box-sizing: border-box; margin: 0px; padding: 0px; font-size: inherit; font-weight: 400; max-width: 118.4rem;">Master different techniques of&nbsp;<strong style="box-sizing: border-box; margin: 0px; padding: 0px;">deployment</strong> so you can show off the apps you build!</p>
        </li>
        <li style="box-sizing: border-box; margin: 0.4rem 0px 0px; padding: 0px 0px 0px 0.8rem;">
            <p style="box-sizing: border-box; margin: 0px; padding: 0px; font-size: inherit; font-weight: 400; max-width: 118.4rem;">See different methods of building UI&apos;s through&nbsp;<strong style="box-sizing: border-box; margin: 0px; padding: 0px;">composition of components</strong></p>
            <p style="box-sizing: border-box; margin: 0.8rem 0px 0px; padding: 0px; font-size: inherit; font-weight: 400; max-width: 118.4rem;"><br style="box-sizing: border-box; margin: 0px; padding: 0px;"></p>
        </li>
    </ul>
    <p style="box-sizing: border-box; margin: 0.8rem 0px 0px; padding: 0px; font-size: inherit; font-weight: 400; max-width: 118.4rem;">Besides just React and Redux, you&apos;ll pick up countless other tidbits of knowledge, including ES2015 syntax, popular design patterns, even the clearest explanation of the keyword &apos;<strong style="box-sizing: border-box; margin: 0px; padding: 0px;"><em style="box-sizing: border-box; margin: 0px; padding: 0px;">this&apos;</em></strong> in Javascript that you&apos;ll ever hear.</p>
    <p style="box-sizing: border-box; margin: 0.8rem 0px 0px; padding: 0px; font-size: inherit; font-weight: 400; max-width: 118.4rem;">This is the course I wanted to take when I&nbsp;first learned React: complete, up-to-date, and clear.</p>
    <p style="box-sizing: border-box; margin: 0.8rem 0px 0px; padding: 0px; font-size: inherit; font-weight: 400; max-width: 118.4rem;"><br style="box-sizing: border-box; margin: 0px; padding: 0px;"></p>
</div>
<div class="styles--audience--2pZ0S" data-purpose="target-audience" style="box-sizing: border-box; margin: 3.2rem 0px 0px; padding: 0px; color: rgb(60, 59, 55); font-family: "sf pro text", -apple-system, BlinkMacSystemFont, Roboto, "segoe ui", Helvetica, Arial, sans-serif, "apple color emoji", "segoe ui emoji", "segoe ui symbol"; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
    <h2 class="udlite-heading-xl styles--audience__title--1Sob_" style="box-sizing: border-box; margin: 0px 0px 1.6rem; padding: 0px; font-size: 2.4rem; font-weight: 700; max-width: 118.4rem; font-family: "sf pro display", -apple-system, BlinkMacSystemFont, Roboto, "segoe ui", Helvetica, Arial, sans-serif, "apple color emoji", "segoe ui emoji", "segoe ui symbol"; line-height: 1.2; letter-spacing: -0.02rem;">Who this course is for:</h2>
    <ul class="styles--audience__list--3NCqY" style="box-sizing: border-box; margin: 0px; padding: 0px 0px 0px 2.4rem; font-size: inherit; font-weight: 400; max-width: 118.4rem;">
        <li style="box-sizing: border-box; margin: 0.4rem 0px 0px; padding: 0px 0px 0px 0.8rem;">Programmers looking to learn React</li>
        <li style="box-sizing: border-box; margin: 0.4rem 0px 0px; padding: 0px 0px 0px 0.8rem;">Developers who want to grow out of just using jQuery</li>
        <li style="box-sizing: border-box; margin: 0.4rem 0px 0px; padding: 0px 0px 0px 0.8rem;">Engineers who have researched React but have had trouble mastering some concepts</li>
    </ul>
</div>'
,'<h2>What you ll learn</h2>
<div>
<ul>
<li>
<div data-purpose="objective">
<div>Build amazing single page applications with React JS and Redux</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>Master fundamental concepts behind structuring Redux applications</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>Realize the power of building composable components</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>Be the engineer who explains how Redux works to everyone else, because you know the fundamentals so well</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>Become fluent in the toolchain supporting React, including NPM, Webpack, Babel, and ES6/ES2015 Javascript syntax</div>
</div>
</li>
</ul>
</div>','2021-05-05- 00:00:01',true,2);

insert into `courses`(course_name,course_title,course_thumbnail,course_avatar_url,course_fee,course_full_description,
course_short_description,course_last_updated,is_finished,subject_id) 
values ('Javascript Projects for Complete Beginners','Learn and Deploy Four projects with pure JavaScript (No frameworks or libraries)
','','https://blog.alvasky.com/wp-content/uploads/2019/03/javascript-illustration.png','10'
,'<div data-purpose="safely-set-inner-html:description:description">
<p>This is a Javascript projects course specifically design for those of you that have completed a javascript book or course yet you cant build a project from scratch and STRICTLY for <strong>Absolutely beginners / Intermediate.&nbsp;</strong>No what is javascript or variables, we start coding straight up.</p>
<p><strong><em>#### WHATS INCLUDED? ####</em></strong></p>
<ul>
<li>
<p><strong>CRUD:&nbsp;</strong>Deploying a Mini Blog that enable you to understand what it takes to<strong>&nbsp;Create, Read, Update and Delete.</strong></p>
</li>
<li>
<p><strong>DOM Manipulation:&nbsp;</strong>Selectors, traversing the DOM, removing elements, event listeners</p>
</li>
<li>
<p><strong>OOP:</strong>&nbsp;ES5 prototypes, inheritance, ES2015 classes &amp; sub-classes, constructors</p>
</li>
<li>
<p><strong>Async JS:&nbsp;</strong>Fetch API, callbacks, promises, async / await</p>
</li>
<li>
<p><strong>ES2015+:&nbsp;</strong>Arrow functions, template strings.</p>
</li>
<li>
<p><strong>4 Projects</strong></p>
</li>
</ul>
<p><strong><em>#### PROJECTS ####</em></strong></p>
<p>1. Airport Finder</p>
<p>2. WeatherJs App</p>
<p>3. Movify Web Application</p>
<p>4. Mini Blog</p>
</div>
<div data-purpose="target-audience">
<h2>Who this course is for:</h2>
<ul>
<li>People that want to learn how to start a JavaScript project from beginning to advanced without libraries and frameworks</li>
<li>You are confused and cant start a project after completing a javascript course</li>
</ul>
</div>'
,'<div data-purpose="safely-set-inner-html:description:description">
<h2>What youll learn</h2>
<div>
<ul>
<li>
<div data-purpose="objective">
<div>Build Airport Finder, WeatherJS App &amp; Mini Blog From scratch</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>Learn How to Start a Projects From Scratch</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>Work with REST API, Mini HTTP Library, Classes, Promises, Arrow Function &amp; Async / Await</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>CRUD using Pure Javascript Newest Syntax, No frameworks or libraries</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>Kick Start project using Materialize CSS &amp; Bulma CSS Frameworks</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>ES6, ES7 ES8 Syntax</div>
</div>
</li>
</ul>
</div>
</div>','2021-05-05- 00:00:01',true,3);


insert into `courses`(course_name,course_title,course_thumbnail,course_avatar_url,course_fee,course_full_description,
course_short_description,course_last_updated,is_finished,subject_id) 
values (
'The Complete React Native '
,'Understand React Native v0.62.2 with Hooks, Context, and React Navigation.'
,''
,'https://isoftglobe.com/wp-content/uploads/2021/02/react-native.png'
,'9.99'
,'<div data-purpose="safely-set-inner-html:description:description">
<div data-purpose="safely-set-inner-html:description:description">
<p>If youre tired of spinning your wheels learning Swift or Android, this is the course for you.</p>
<p><strong>Authentication?</strong>&nbsp;You will learn it. <strong>Hooks?&nbsp;</strong>Included. <strong>Navigation?&nbsp;</strong>Of course!</p>
<p>This course will get you up and running with React Native&nbsp;quickly, and teach you the core knowledge you need to deeply understand and build React components for mobile devices.</p>
<p><strong>Both OSX and Windows supported - develop iOS or Android!</strong></p>
<p>This course includes content on both v0.62.2 and the legacy v0.30.x, which is widely used in industry.</p>
<p>We start by mastering the fundamentals of React, including JSX, &ldquo;props", &ldquo;state", and event handling. Source code is provided for each lecture, so you will always&nbsp;<strong>stay up-to-date</strong>&nbsp;with the course pacing. Special attention has been paid to creating&nbsp;<strong>reusable components</strong>&nbsp;that youll be able to make use of on your own fantastic projects.</p>
<p>React Native is an excellent solution for developing apps on mobile in a fraction of the time it takes to make an equivalent iOS or Swift app. Youll love seeing your changes instantly appear on your own device, rather than waiting for Swift/Java code to recompile! This quick feedback loop, along with excellent cross platform support, is what has catapulted React Native to the top must-have skill for Javascript engineers.</p>
<p>If you are new to React, or if youve been working to learn it but sometimes feel like you still dont quite get it, this is the React course for you! To learn React you have to understand it.</p>
<ul>
<li>
<p>Learn how to use Reacts custom markup language, JSX, to clean up your Javascript code</p>
</li>
<li>
<p>Master the process of breaking down a complex component into many smaller, interchangeable components</p>
</li>
<li>
<p>Grasp the difference between &ldquo;props" and &ldquo;state" and when to use each</p>
</li>
<li>
<p>Render interactive, media-rich components in beautifully styled apps</p>
</li>
<li>
<p>Develop apps that are unique, fun, and responsive</p>
</li>
<li>
<p>Build on&nbsp;<strong>both Android and iOS</strong>&nbsp;platforms</p>
</li>
<li>
<p>Master integration with&nbsp;<strong>Firebase for user authentication</strong></p>
</li>
<li>
<p>Learn the core principles of&nbsp;<strong>navigation</strong>&nbsp;with React Native</p>
</li>
</ul>
<p>Ive built the course that I would have wanted to take when I was learning React Native. A course that explains the concepts and how theyre implemented in the best order for you to learn and deeply understand them.</p>
</div>
<div data-purpose="target-audience">
<h2>Who this course is for:</h2>
<ul>
<li>This course is for anyone looking to make native apps with React Native</li>
</ul>
</div>
</div>'
,'<div data-purpose="safely-set-inner-html:description:description">
<h2>What youll learn</h2>
<div>
<ul>
<li>
<div data-purpose="objective">
<div>Create real-world native apps using React Native</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>Make truly reusable components that look great</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>Understand the terminology and concepts of Redux</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>Prototype and deploy your own applications to the Apple and Google Play Stores</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>Get up to speed with React design principles and methodologies</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>Discover mobile design patterns used by experienced engineers</div>
</div>
</li>
</ul>
</div>
</div>'
,'2021-05-05- 00:00:01',true,7);

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
insert into `lessons` (lesson_name,lesson_content,flag_reviewable,duration,chap_id) values ('lesson 2  JSX','',1,SEC_TO_TIME(7600),1);
insert into `lessons` (lesson_name,lesson_content,flag_reviewable,duration,chap_id) values ('lesson 3  Todo list','',1,SEC_TO_TIME(7600),1);

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
insert into `instructor_courses_uploaded` (user_id,course_id,lesson_id,chap_id,uploaded_day) values (7,1,1,1,STR_TO_DATE('21-05-2021','%d-%m-%Y'));
insert into `instructor_courses_uploaded` (user_id,course_id,lesson_id,chap_id,uploaded_day) values (8,2,2,2,STR_TO_DATE('21-05-2021','%d-%m-%Y'));


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
insert into `orders` (user_id,order_day) values (2,str_to_date('12-12-2021','%d-%m-%Y'));
insert into `orders` (user_id,order_day) values (3,str_to_date('13-12-2021','%d-%m-%Y'));
insert into `orders` (user_id,order_day) values (4,str_to_date('13-12-2021','%d-%m-%Y'));
insert into `orders` (user_id,order_day) values (5,str_to_date('13-12-2021','%d-%m-%Y'));



-----------------------------------------------------
-- Table structure for `orders_details`
-----------------------------------------------------
DROP TABLE IF EXISTS `orders_details`;
CREATE TABLE `orders_details`(
	order_detail_id int(10) not null auto_increment,
	order_id int(10) not null,
    course_id int(10) not null,
    total_money varchar(3000),

    primary key (order_detail_id),
    foreign key (course_id) references `courses` (course_id) on delete cascade,
	foreign key (order_id) references `orders` (order_id) on delete cascade
);

-------------------------------------------------------------
-- Records  for `orders`
-------------------------------------------------------------
insert into `orders_details` (course_id,order_id,total_money) values (1,1,'2000000');
insert into `orders_details` (course_id,order_id,total_money) values (2,1,'3000000');
insert into `orders_details` (course_id,order_id,total_money) values (3,1,'3000000');
insert into `orders_details` (course_id,order_id,total_money) values (1,2,'3000000');
insert into `orders_details` (course_id,order_id,total_money) values (2,2,'3000000');
insert into `orders_details` (course_id,order_id,total_money) values (3,2,'3000000');
insert into `orders_details` (course_id,order_id,total_money) values (3,3,'3000000');
insert into `orders_details` (course_id,order_id,total_money) values (3,4,'3000000');







