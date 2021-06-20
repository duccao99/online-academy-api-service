
CREATE TABLE `roles`(
	role_id INT(10) PRIMARY KEY NOT NULL auto_increment,
    role_name varchar(200)
);


insert into `roles` (role_name) values ('anonymous');
insert into `roles` (role_name) values ('student');
insert into `roles` (role_name) values ('instructor');
insert into `roles` (role_name) values ('administrator');
insert into `roles` (role_name) values ('common');
insert into `roles` (role_name) values ('chatbot_facebook');




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

insert into `users` (user_name,password,email,date_of_birth,is_verified,otp_verify_url,user_avatar_url,role_id) values ('duccao','duccao','duc@gmail.com',STR_TO_DATE('27-03-1999','%d-%m-%Y'),false,'https://','https://',1);
insert into `users` (user_name,password,email,date_of_birth,is_verified,otp_verify_url,user_avatar_url,role_id) values ('duccao_admin','123123','caovanducss@gmail.com',STR_TO_DATE('27-03-1999','%d-%m-%Y'),true,'https://','https://',4);
insert into `users` (user_name,password,email,date_of_birth,is_verified,otp_verify_url,user_avatar_url,role_id) values ('lamtu_admin','lamtu_admin','chanestdevil@gmail.com',STR_TO_DATE('27-03-1999','%d-%m-%Y'),true,'https://','https://',4);
insert into `users` (user_name,password,email,date_of_birth,is_verified,otp_verify_url,user_avatar_url,role_id) values ('admin','123123','admin@gmail.com',STR_TO_DATE('27-03-1999','%d-%m-%Y'),true,'https://','https://',4);

insert into `users` (user_name,password,email,date_of_birth,is_verified,otp_verify_url,user_avatar_url,role_id) values ('student01','student01','student01@gmail.com',STR_TO_DATE('27-03-1999','%d-%m-%Y'),true,'https://','https://',2);
insert into `users` (user_name,password,email,date_of_birth,is_verified,otp_verify_url,user_avatar_url,role_id) values ('student02','student02','student02@gmail.com',STR_TO_DATE('27-03-1999','%d-%m-%Y'),true,'https://','https://',2);
insert into `users` (user_name,password,email,date_of_birth,is_verified,otp_verify_url,user_avatar_url,role_id) values ('student03','student03','student03@gmail.com',STR_TO_DATE('27-03-1999','%d-%m-%Y'),true,'https://','https://',2);

insert into `users` (user_name,password,email,date_of_birth,is_verified,otp_verify_url,user_avatar_url,role_id) values ('instructor01','instructor01','instructor01@gmail.com',STR_TO_DATE('27-03-1999','%d-%m-%Y'),true,'https://','https://',3);
insert into `users` (user_name,password,email,date_of_birth,is_verified,otp_verify_url,user_avatar_url,role_id) values ('instructor02','instructor02','instructor02@gmail.com',STR_TO_DATE('27-03-1999','%d-%m-%Y'),true,'https://','https://',3);
insert into `users` (user_name,password,email,date_of_birth,is_verified,otp_verify_url,user_avatar_url,role_id) values ('instructor03','instructor03','instructor03@gmail.com',STR_TO_DATE('27-03-1999','%d-%m-%Y'),true,'https://','https://',3);

insert into `users` (user_name,password,email,date_of_birth,is_verified,otp_verify_url,user_avatar_url,role_id) values ('student04','student04','student04@gmail.com',STR_TO_DATE('27-03-1999','%d-%m-%Y'),true,'https://','https://',2);
insert into `users` (user_name,password,email,date_of_birth,is_verified,otp_verify_url,user_avatar_url,role_id) values ('student05','student05','student05@gmail.com',STR_TO_DATE('27-03-1999','%d-%m-%Y'),true,'https://','https://',2);
insert into `users` (user_name,password,email,date_of_birth,is_verified,otp_verify_url,user_avatar_url,role_id) values ('student06','student06','student06@gmail.com',STR_TO_DATE('27-03-1999','%d-%m-%Y'),true,'https://','https://',2);




CREATE TABLE `categories`(
	cat_id int(10) primary key not null auto_increment,
    cat_name nvarchar(4000)
);


insert into `categories`(cat_name) values ('Web application development');
insert into `categories`(cat_name) values ('Mobile application development');




CREATE TABLE `subjects`(
	subject_id int(10) primary key not null auto_increment,
    subject_name nvarchar(4000),
    cat_id int(10),
    foreign key (cat_id) references `categories` (cat_id) on delete cascade,
    fulltext(subject_name)
)ENGINE=InnoDB;


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
insert into `subjects`(subject_name,cat_id) values ('Advanced React',1);
insert into `subjects`(subject_name,cat_id) values ('Advanced Javascript',1);



CREATE TABLE `courses`(
	course_id int(10) primary key not null auto_increment,
    course_name nvarchar(500),
    course_title nvarchar(500),
	course_thumbnail nvarchar(100),
	course_avatar_url nvarchar(1000),
    course_fee int(10),
    course_full_description nvarchar(14000),
	course_short_description nvarchar(4000),
	course_last_updated datetime,
	is_finished bool,
    subject_id int(10),
    views int(10) default null,
    
    foreign key (subject_id) references `subjects` (subject_id) on delete cascade,
    fulltext(course_name)
)ENGINE=InnoDB;


insert into `courses`(course_name,course_title,course_thumbnail,course_avatar_url,course_fee,course_full_description,course_short_description,course_last_updated,is_finished,subject_id,views) 
values ('React - The Complete Guide','React - The Complete Guide (incl Hooks, React Router, Redux)','','https://img-c.udemycdn.com/course/240x135/1362070_b9a1_2.jpg?Expires=1621142294&Signature=YkpacdOxrPqJxvFJWomoqv6mUEgYrLYeUyLcyrCzHootBf7kxvDQ7pZMwGq7pi3DZ068d-pN6eEK-bh02uU5PJw0k7b2v~9SUqsjgKJl0foW40YzNq~P1VHsU2zvpIuncDIKmnN24sWh-K2P4kTQcanM3ujeC~ioMEd8FXxXBa1yaTiADlmK1GGbhbRpjQtBBmXM8B2ht0~fZzBwhS551Ksf5PM427cRYp3MJFYnTEb2BKEXXDBLt6GMXXi-qfi8heQk9KBU5q-Vzm4v0OtJn0npX4-Uc~581QwHiY8Nxi8mDvM2dafpIM6pUrI3jwF~g7F5myMPlIvvyII2GsbBVw__&Key-Pair-Id=APKAITJV77WS5ZT7262A',20,
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
</div>',curdate(),true,2,10);

insert into `courses`(course_name,course_title,course_thumbnail,course_avatar_url,course_fee,course_full_description,course_short_description,course_last_updated,is_finished,subject_id,views) 
values ('Fast Tracking React','React - Using fastest speed to learn ReactJS','','https://img-c.udemycdn.com/course/240x135/1362070_b9a1_2.jpg?Expires=1621142294&Signature=YkpacdOxrPqJxvFJWomoqv6mUEgYrLYeUyLcyrCzHootBf7kxvDQ7pZMwGq7pi3DZ068d-pN6eEK-bh02uU5PJw0k7b2v~9SUqsjgKJl0foW40YzNq~P1VHsU2zvpIuncDIKmnN24sWh-K2P4kTQcanM3ujeC~ioMEd8FXxXBa1yaTiADlmK1GGbhbRpjQtBBmXM8B2ht0~fZzBwhS551Ksf5PM427cRYp3MJFYnTEb2BKEXXDBLt6GMXXi-qfi8heQk9KBU5q-Vzm4v0OtJn0npX4-Uc~581QwHiY8Nxi8mDvM2dafpIM6pUrI3jwF~g7F5myMPlIvvyII2GsbBVw__&Key-Pair-Id=APKAITJV77WS5ZT7262A'
,12,
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
</div>',curdate(),true,2,9);


insert into `courses`(course_name,course_title,course_thumbnail,course_avatar_url,course_fee,course_full_description,course_short_description,course_last_updated,is_finished,subject_id,views) 
values ('Learn and Understand NodeJS','Dive deep under the hood of NodeJS. Learn V8, Express, the MEAN stack, core Javascript concepts, and more.','','https://img-b.udemycdn.com/course/240x135/461160_8d87_6.jpg?secure=tYL9a3DZGrDtHankOr23SA%3D%3D%2C1621150709'
,15,
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
</div>',curdate(),true,1,8);




insert into `courses`(course_name,course_title,course_thumbnail,course_avatar_url,course_fee,course_full_description,
course_short_description,course_last_updated,is_finished,subject_id,views) 
values ('Modern React with Redux','Master React and Redux with React Router, Webpack, and Create-React-App. Includes Hooks!'
,'','https://d585tldpucybw.cloudfront.net/sfimages/default-source/blogs/templates/reactt-dark_870x220.png?sfvrsn=ef69fd61_3'
,9
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
</div>',str_to_date('12-12-2020','%d-%m-%Y'),true,2,7);

insert into `courses`(course_name,course_title,course_thumbnail,course_avatar_url,course_fee,course_full_description,
course_short_description,course_last_updated,is_finished,subject_id,views) 
values ('Javascript Projects for Complete Beginners','Learn and Deploy Four projects with pure JavaScript (No frameworks or libraries)
','','https://blog.alvasky.com/wp-content/uploads/2019/03/javascript-illustration.png'
,2
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
</div>',str_to_date('12-12-2020','%d-%m-%Y'),true,3,6);


insert into `courses`(course_name,course_title,course_thumbnail,course_avatar_url,course_fee,course_full_description,
course_short_description,course_last_updated,is_finished,subject_id,views) 
values (
'The Complete React Native '
,'Understand React Native v0.62.2 with Hooks, Context, and React Navigation.'
,''
,'https://isoftglobe.com/wp-content/uploads/2021/02/react-native.png'
,8
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
,str_to_date('12-12-2020','%d-%m-%Y'),true,7,5);


insert into `courses`(course_name,course_title,course_thumbnail,course_avatar_url,course_fee,course_full_description,
course_short_description,course_last_updated,is_finished,subject_id,views) 
values (
'React Native - The Practical Guide'
,'Use React Native and your React knowledge to build native iOS and Android Apps - incl. Push Notifications, Hooks, Redux'
,''
,'https://miro.medium.com/max/5144/1*m8V2pAYonX7i9jEJt9yx3w.png'
,7
,'<div data-purpose="safely-set-inner-html:description:description">
<p><strong>This course was completely updated and now does not only cover the latest version of React Native but also includes refreshers on JavaScript &amp;&nbsp;React.js!</strong></p>
<p>In addition, a&nbsp;<strong>whole section&nbsp;</strong>on "<strong>Push&nbsp;Notifications</strong>" was added.</p>
<p>---</p>
<p><strong>Mobile apps</strong>&nbsp;are one of the best ways to engage with users - no wonder everyone wants to build one!</p>
<p>Wouldnt it be great if you could use your&nbsp;<strong>web development knowledge</strong>, combined with your&nbsp;<strong>React</strong>&nbsp;knowledge, to&nbsp;<strong>build mobile apps</strong>&nbsp;with that?</p>
<p><strong>Thats exactly what React Native allows you to do!</strong></p>
<p>No need&nbsp;to learn Java, Android, Swift, ObjectiveC or anything of that -&nbsp;<strong>React and JavaScript is all you need&nbsp;</strong>to create awesome native mobile apps that work on both Android and iOS. Thats probably the reason why Instagram, AirBnB,&nbsp;Skype and many other global companies&nbsp;are using it to build their mobile apps!</p>
<p>With this course, you can join this league. Ill teach you all you need to create your own React Native apps, publish them to the Google Play Store and Apple App Store and dive really deep into the React Native ecosystem.</p>
<p>Youll learn all about the theory behind React Native, its core concepts, how to build responsive designs that work on different device sizes, how to animate React Native apps, how to navigate around, use maps and the camera and so much more!</p>
<p>And which better way to learn&nbsp;than by&nbsp;<strong>building a real app?</strong>&nbsp;Well build the "<strong>Awesome Places</strong>"&nbsp;app in this course, an app where users can share amazing pictures and the location where they took them. This app will allow you to see things like using maps, the camera, user authentication, connecting to a server and much more in action.</p>
<p>By the end of the course, well of course also go through all steps required to get it into an app store.</p>
<p><strong>Heres a detailed look at what youll get:</strong></p>
<ul>
<li>
<p>The core concepts and theory</p>
</li>
<li>
<p>How to use React, JavaScript and native components</p>
</li>
<li>
<p>Understand how to navigate in React Native apps</p>
</li>
<li>
<p>A closer look at styling and animating React Native apps</p>
</li>
<li>
<p>Instructions on how to use third-party libraries in your React Native app</p>
</li>
<li>
<p>Detailed examples on how to use maps or an image picker</p>
</li>
<li>
<p>A full user authentication flow</p>
</li>
<li>
<p>How to connect to a backend server from your app</p>
</li>
<li>
<p>Debugging instructions</p>
</li>
<li>
<p>And so much more!</p>
</li>
</ul>
<p><strong>What will you need to succeed in this course?</strong></p>
<ul>
<li>
<p>NO&nbsp;Android, Java, Swift or ObjectiveC knowledge is required!</p>
</li>
<li>
<p>JavaScript and React (for the web) knowledge is required though - you dont need to be an expert but the basics need to be set (though there are refresher sections in this course!)</p>
</li>
</ul>
<p>Id be very happy to welcome you in the course!</p>
<p>Max</p>
</div>
<div data-purpose="target-audience">
<h2>Who this course is for:</h2>
<ul>
<li>Anyone who wants to use React to build native mobile apps</li>
<li>Every mobile developer who wishes to learn only one language to write cross-platform mobile apps</li>
<li>Every mobile or web developer whos interested in writing high-performance native apps with JavaScript</li>
</ul>
</div>'
,'<h2>What youll learn</h2>
<div>
<ul>
<li>
<div data-purpose="objective">
<div>Build native mobile apps with JavaScript and React</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>Dive deeper into React Native</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>Develop cross-platform (iOS and Android) mobile apps without knowing Swift, ObjectiveC or Java/ Android</div>
</div>
</li>
</ul>
</div>'
,curdate(),true,7,4);





insert into `courses`(course_name,course_title,course_thumbnail,course_avatar_url,course_fee,course_full_description,
course_short_description,course_last_updated,is_finished,subject_id,views) 
values(
'The Complete Android N Developer Course'
,'Learn Android App Development with Android 7 Nougat by building real apps including Uber, Whatsapp and Instagram!'
,''
,'https://kynangso.net/wp-content/uploads/2019/06/Android-Banner.png'
,6
,'<div data-purpose="safely-set-inner-html:description:description">
<p><strong><em>Please note support for this course has now stopped, and that&nbsp;there is a newer version of the course (The Complete Android Oreo Developer Course) available.</em></strong></p>
<p><em>In this Android N&nbsp;version of the&nbsp;course I use Android Studio versions 2.0 and 2.1.2, and recommend students do the same.</em></p>
<p>So you want to build your own apps?</p>
<p>And you want to build them&hellip; from the comfort of your home&hellip; in your own time&hellip; without having to attend class&hellip; or wade through endless textbooks (or online guides).&nbsp;<em>Am I right?</em></p>
<p>And let me guess: you&nbsp;<em>only</em>&nbsp;want the latest technology, software and techniques&mdash;because you&rsquo;ve got big plans, big ideas&mdash;and let&rsquo;s be honest&hellip; you&rsquo;re impatient and you want to jump the queue?</p>
<p>My name&rsquo;s Rob Percival, creator of the world&rsquo;s best-selling online coding courses&hellip; andI&rsquo;ve designed<strong>&nbsp;The Complete Android N&nbsp;Developer Course</strong>, especially for YOU.</p>
<p>Building on last year&rsquo;s runaway success: The Complete Android Developer Course (Udemy&rsquo;s best-ever-selling Android course, with over 50,000 happy students),&nbsp;<strong>The Complete Android N&nbsp;Developer Course</strong>&nbsp;has been refined, honed and microscopically polished to deliver even more valuable content, all designed for the latest Android 7.&nbsp;</p>
<p>A huge range of technologies are covered, including open source&nbsp;Parse Server, Firebase, Admob, GDX&nbsp;(game development), Bluetooth and a whole lot more.</p>
<p>This time, using hot-off-the-press&nbsp;<strong>Android Nougat</strong>&nbsp;(putting unparalleled levels of performance, productivity and security directly into your hands),&nbsp;<strong>The Complete Android N&nbsp;Developer Course&nbsp;</strong>includes building a WhatsApp clone PLUS three&nbsp;<em>brand spanking new</em>&nbsp;chapters on how to market your apps&mdash;and start piling in the cash.</p>
<p><strong>What&rsquo;s stopping you from signing up to today?</strong></p>
<p>&middot; You don&rsquo;t have enough time:&nbsp;<em>Not an issue</em>. We&rsquo;ve designed this course so you can learn everything you need in as little as SIX WEEKS.</p>
<p>&middot; You&rsquo;re still weighing up the value:&nbsp;<em>Listen.&nbsp;</em>We&rsquo;ve made this course bigger, better and more affordable&mdash;with even more content and more insider money-making tips&mdash;than EVER before. In fact, if you don&rsquo;t 100% get everything you need from it&hellip; we&rsquo;ll give you your MONEY BACK.</p>
<p>&middot; You don&rsquo;t have any previous experience:&nbsp;<em>Seriously, not a problem</em>. This course is expertly designed to teach everyone from complete beginners, right through to pro developers. <em>(And yes, even pro developers take this course to quickly absorb the latest skills, while refreshing existing ones).</em></p>
<p><em>&ldquo;Detailed instructions for beginners, easy to follow as all Robs courses. I would definitely recommend this course :)&rdquo;</em></p>
<p><em>&ldquo;As a full time developer, I dreamed of writing a game, but never got anywhere. Too much analysis, object-oriented development training. Then Rob built flappy birds right before my eyes. Now I have a game going into the app store. This course is great for pro-developers too!&rdquo;</em></p>
<p>Straight up: No other course will take you to expert app developer in as fast a time as this.&nbsp;<em>Have other courses done this for you?</em>&nbsp;</p>
<p><strong>Buy this course today and this is what you&rsquo;ll get.</strong></p>
<p>Firstly, using Java and Android Studio, Ill teach you how to build real, marketable apps by cloning WhatsApp, Uber and Instagram.</p>
<p>And by the way&mdash;just like my other record-smashing courses&mdash;this course is project based, which means you build your own apps in REALTIME&hellip;As. You. Learn.</p>
<p>Over half a million students tell me this is THE most motivating and effective way to absorb information.</p>
<p>&middot; Youll start by downloading Android Studio and building an easy-peasy Currency Converter app.</p>
<p>&middot; Next up: youll build a Favourite Places app and a Brain Training app, before working your way up to WhatsApp, Uber and Instagram clones&nbsp;&mdash;&nbsp;using Parse Server.</p>
<p>&middot; Youll also get a full guide on submitting your apps to Google Play, plus THREE BRAND NEW WALK-THROUGH chapters explaining exactly how to effectively market your apps&mdash;and generate revenue with Google Ads.</p>
<p>&middot; Youll learn all the latest Android N features, including App Permissions and Android Pay.</p>
<p>&middot; And finally, well take a look at Android Wear - the future of wearable computing.</p>
<p><strong>Can you believe you get all this (and more) for just $200?</strong></p>
<p><em>&ldquo;Amazing course that teaches you everything you want to learn about making android apps from the basic to the advanced. Even if you have no knowledge you can learn so much from this course.&rdquo;</em></p>
<p><strong>What else will I get if I buy this course now?</strong></p>
<p>&middot; FULL LIFETIME ACCESS (including video downloads and updates) for a ludicrously affordable one-off fee.</p>
<p>&middot; $50 Amazon AWS&nbsp;Credit for hosting your own social apps.</p>
<p>&middot; PEACE OF MIND: Learn from the creator of three of the most popular online courses, successfully teaching over 200,000 students and receiving 10,000 5* reviews.</p>
<p>&middot; CONTINUOUS PROJECT SUPPORT: Whenever you need it, in the course forums.</p>
<p>&middot; SUPERIOR LEARNING: Build your own real apps as you go, with not a yawnsome programming concept in sight.</p>
<p>&middot; &pound;300 WORTH OF EXCLUSIVE APP TEMPLATES, icons and backgrounds (designed for Android N)</p>
<p>&middot; ONE YEAR&rsquo;S FREE WEB HOSTING on Eco Web Hostings Advanced Package, worth &pound;119. *Limited to one year per student not per course*</p>
<p><em>&ldquo;So much more understandable than the other 6+ classes I have taken elsewhere. This course is a must! Thank you!&rdquo;</em></p>
<p><strong>Why learn to make Android apps?</strong></p>
<p>&middot; Android is without a doubt THE biggest mobile platform in the world, with over 80% market share and over 1 billion devices sold in 2016&nbsp;alone.</p>
<p>&middot; You can develop for Android on a Windows, Mac or Linux computer.</p>
<p>&middot; Java is a fantastic language to learn, allowing you to make apps for PC, Mac and the web, as well as Android.</p>
<p>&middot; Android app discovery is way superior to the App Store, so your app has a far better chance of getting seen&mdash;and bought.</p>
<p>&middot; Ad-based revenue is a lot more common on Android than on iOS, and a cinch to set up with Google Ads.</p>
<p><em>&ldquo;Top class professional presentation of a well-constructed course. Consistently pitched at the right level to remain interesting and challenging, this course quickly brings the student to a point where generating their own applications is realistic and fun</em>.&rdquo;</p>
<p><strong>Who is this for?</strong></p>
<p>Anyone who wants to learn to code to become an app developer: This is a&nbsp;complete&nbsp;course, just like my Complete Web, iOS and Apple Watch courses. So once you&rsquo;re up and coding like a demon app developer, it&rsquo;ll ALSO teach you how to&nbsp;<em>make money from your apps</em>.</p>
<p>Sound good?</p>
<p>It&rsquo;s also for anyone who wants to understand how computers work: Learning to code is so much more than being able to make apps - knowing how computers work opens news doors to our awesome digital world</p>
<p><em>&ldquo;Rob has a knack for explaining material in an easily digestible way. The mini challenges he presents within his lectures are an excellent way to commit things to memory. The lectures are well paced - fast enough to maintain your interest but not so fast that you get left in the dust!&rdquo;</em></p>
<p><strong>Is this course right for me?</strong></p>
<p>Look: if you&rsquo;re still not convinced, I urge you to check out my 5* reviews. There&rsquo;s over half a million of them on Udemy, alone. No other course on the World Wide Web has achieved such consistent ratings.</p>
<p><em>Coding and app development is the future</em>. Whether you&rsquo;ve got plans to create the next Facebook, or you want to get ahead at work and increase your earning potential, I GUARANTEE anyone will find&nbsp;<strong>The Complete Android N&nbsp;Developer Course</strong>&nbsp;course show-stoppingly useful.</p>
<p>A quick summary of why&nbsp;<strong>The Complete Android N&nbsp;Developer Course</strong>&nbsp;is the number one resource for budding app developers, like you:</p>
<p>&middot; Time-tested, quick-to-pick up learning strategies</p>
<p>&middot; Quality insider tips, that only the pros normally know</p>
<p>&middot; Home-based learning&mdash;so you can go as fast or slow as you please</p>
<p>&middot; Simple, jargon-free language and HD definition</p>
<p><strong>Who Am I?</strong></p>
<p>Im Rob.</p>
<p>I run three of the most successful online coding courses on the planet, and I&rsquo;m so excited to share them with you.</p>
<p>I have a degree in Mathematics from Cambridge University, and am a web and app developer based in Cambridge, UK. Since working as a secondary school teacher for 10 years, I&rsquo;ve never lost my love for teaching.</p>
<p>Maybe that&rsquo;s why my goal is so simple: To get as many people benefitting from app development as possible. But more importantly, that my courses are enjoyable and deliver tangible results for you&hellip; Today and tomorrow.</p>
<p>These are the things that drive me to keep pushing what&rsquo;s possible in online learning.</p>
<p>OK, let&rsquo;s begin&hellip;&nbsp;</p>
<p><em>&ldquo;Outstanding! Rob delivers high quality content once more. Its not just the endless content and the clear explanations that you get but more importantly the confidence that you build. A must for any developer.&rdquo;</em></p>
</div>
<div data-purpose="target-audience">
<h2>Who this course is for:</h2>
<ul>
<li>Anyone who wants to be an app developer: This is a complete course, just like my Complete Web, iOS and Apple Watch courses. It will teach you how to make money from your apps as well as how to code.</li>
<li>Anyone who wants to learn to code: Java is a fantastic language to learn how to code with.</li>
<li>Anyone who wants to understand how computers work: Learning to code is so much more than being able to make apps - knowing how computers work is your key to a hugely powerful world.</li>
</ul>
</div>'
,'<h2>What youll learn</h2>
<div>
<ul>
<li>
<div data-purpose="objective">
<div>Make pretty much any Android app you like (your only limit is your imagination)</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>Submit your apps to Google Play and generate revenue with Google Pay and Google Ads</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>Become a professional app developer, take freelance gigs and work from anywhere in the world</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>Bored with the same old, same old? Apply for a new job in a software company as an Android developer</div>
</div>
</li>
</ul>
</div>'
,'2021-05-05 - 00:00:01',true,9,3);



insert into `courses`(course_name,course_title,course_thumbnail,course_avatar_url,course_fee,course_full_description,
course_short_description,course_last_updated,is_finished,subject_id,views) 
values (
'iOS & Swift - The Complete iOS App Development',
'From Beginner to iOS App Developer with Just One Course! Fully Updated with a Comprehensive Module Dedicated to SwiftUI!',
'',
'https://theme.hstatic.net/1000255974/1000341244/14/banner_product_home_2.jpg?v=55',
100,
'<div data-purpose="safely-set-inner-html:description:description">
<div data-purpose="safely-set-inner-html:description:description">
<p>Welcome to the&nbsp;<strong>Complete iOS App Development Bootcamp</strong>. With over 39,000 5 star ratings and a 4.8 average my iOS course is the HIGHEST RATED iOS Course in the history of Udemy!</p>
<p>At 55+ hours, this iOS 13 course is the&nbsp;<strong>most comprehensive</strong>&nbsp;iOS development course online!</p>
<p>This Swift 5.1 course is based on our<strong>&nbsp;in-person</strong>&nbsp;app development bootcamp in London, where weve perfected the curriculum over 4 years of in-person teaching.</p>
<p>Our complete app development bootcamp teaches you how to code using Swift 5.1 and build&nbsp;<em>beautiful</em>&nbsp;iOS 13 apps for iPhone and iPad. Even if you have&nbsp;<strong>ZERO</strong>&nbsp;programming experience.</p>
<p>Ill take you step-by-step through engaging and fun video tutorials and teach you everything you need to know to succeed as an iOS app developer.</p>
<p>The course includes 55+<strong>&nbsp;hours</strong>&nbsp;of HD video tutorials and builds your programming knowledge while making real world apps. e.g. Pokemon Go, Whatsapp, QuizUp and Yahoo Weather.</p>
<p>The curriculum has been completely revamped for iOS 13 and Xcode 11. Including comprehensive modules on Apples latest technology -&nbsp;<strong>SwiftUI</strong>&nbsp;iOS, iPadOS and macOS app interface design,&nbsp;<strong>ARKit</strong>&nbsp;for making&nbsp;<strong>Augmented Reality</strong>&nbsp;apps as well as&nbsp;<strong>CoreML &amp; CreateML</strong>&nbsp;for making intelligent apps with&nbsp;<strong>Machine Learning</strong>. Youll be building 3D augmented reality apps that look like Pokemon Go and Harry Potters magical newspapers!</p>
<p>By the end of this course, you will be&nbsp;<strong>fluently</strong>&nbsp;programming in&nbsp;<strong>Swift 5.1</strong>&nbsp;and be ready to make your own apps or start a freelancing job as an iOS 13 developer.</p>
<p>Youll also have a portfolio of over 25 apps that you can show off to any potential employer.</p>
<p><strong>Sign up today, and look forwards to:</strong></p>
<ul>
<li>
<p>Over 55 hours of HD 1080p video content, everything youll ever need to succeed as a iOS developer.</p>
</li>
<li>
<p>Building over 25 fully-fledged apps including ones that use machine learning and augmented reality</p>
</li>
<li>
<p>All the knowledge you need to start building any app you want</p>
</li>
<li>
<p>A giant bundle of design assets</p>
</li>
<li>
<p>Our best selling 12 Rules to Learn to Code eBook</p>
</li>
<li>
<p>$8000+ app development bootcamp course materials and curriculum</p>
</li>
</ul>
<p><strong>From Beginner to iOS 13 App Developer with Just One Course</strong></p>
<p>We know that youre here because you value your time. If you wanted to watch someone program for hours and hours without explaining what theyre doing, youd be on YouTube.</p>
<p>By getting this course, you can be rest assured that the course is carefully thought out and edited. There are beautiful animations that explain all the difficult concepts and the videos are&nbsp;<strong>fully up to date</strong>&nbsp;with the latest versions of Swift and Xcode.</p>
<p>So by the end of the course, youll completely understand:</p>
<ul>
<li>
<p>Concepts of Object Oriented Programming (OOP): The type system, variables, functions and methods, inheritance, structures, classes and protocols.</p>
</li>
<li>
<p>Control Structures: Using If/&shy;Else clauses, Switch statements and logic to control the flow of execution.</p>
</li>
<li>
<p>Data Structures: How to work with collections, such as arrays and dictionaries.</p>
</li>
<li>
<p>Software Design: How to organise and format code for readability and how to implement the Model &shy;View&shy; Controller (MVC) design pattern, Apples favourite delegation pattern and the publisher pattern.</p>
</li>
<li>
<p>Networking: How to make asynchronous API calls, store and retrieve data from the cloud, and use the JSON format for server communication.</p>
</li>
<li>
<p>Persistent Local Data Storage: How to use Core Data, Realm, Codable and User Defaults to store your app data locally.</p>
</li>
<li>
<p>How to Implement In-App Purchases with Apple StoreKit</p>
</li>
<li>
<p>Machine Learning: How to make artificially intelligent apps and build your own machine learning models using iOS 13s new CoreML2 and CreateML frameworks.</p>
</li>
<li>
<p>Augmented Reality: How to create 3D objects in augmented reality and create incredible 3D animations and real-life interactions using Apples latest ARKit2 framework.</p>
</li>
<li>
<p>SwiftUI: How to use Apples brand new UI framework to create user interfaces programmatically that look good across all Apple products.</p>
</li>
</ul>
<p><strong>Don&rsquo;t waste your time</strong></p>
<p>Dont waste another minute of your precious life on poor quality videos on YouTube. Or instructors who you cant understand. Or teachers who have no real world in-person teaching experience. Your time is precious. Take this course and find out why everybody is raving about it and why over 39,000 students rated it&nbsp;<strong>5 stars</strong>!</p>
<p><strong>Dont waste your money</strong></p>
<p>Inside this course, youre getting exactly the same course materials and curriculum as our 12 week in-person programming bootcamp. Instead of spending&nbsp;<strong>$8000 dollars&nbsp;</strong>and taking time off work, save loads of money by getting this course and do it at your own pace!</p>
<p><strong>Dont just take my word for it, see what my past students had to say about the course:</strong></p>
<p><em>"You will not find a better teacher than Angela. She does a wonderful job of encouraging you to learn swift the right way. I want to encourage everyone thinking about taking this class to get it, as it is the&nbsp;</em><strong><em>BEST Swift programming class</em></strong><em>&nbsp;Ive seen on anywhere and Ive tried more than a few of them. If you are looking for an excellent swift programming course, stop there here because you have found it. You will learn Swift from the very beginning of programming all the way through making your own apps that you can upload to the App store." - Ian Hopjins</em></p>
<p><em>"SO GOOD!!!&nbsp;</em><strong><em>Retention rate is incredible</em></strong><em>&nbsp;because Angela does a great job in explaining and teaching every aspect of what we are doing. Most of the other instructors on Udemy put code on the screen and pretend nothing happened. This course is amazing! 5/5"</em>&nbsp;- Muhammad Ibrahim</p>
<p><em>"Angela is a&nbsp;</em><strong><em>spectacular</em></strong><em>&nbsp;teacher!"</em>&nbsp;- Marco Zanirato</p>
<p><em>"This course was terrific. Only after taking a few more courses from others that I</em><strong><em>&nbsp;realized how good this course</em></strong><em>&nbsp;was. This course taught me more than I was expecting, it provided great instructions and a lot of hands-on tasks to drill-in the concept." - Marc</em></p>
<p><em>"Best use of your money! I was a complete beginner but&nbsp;</em><strong><em>Angela made me a pro</em></strong><em>&nbsp;in weeks."</em>&nbsp;- Burak Tun&ccedil;bilek</p>
<p><em>"IT IS #1!!!!!!!!! Absolutely Amazing. The best iOS course i have ever taken. Angela explains everything the way it needs to be explained, so everything is easily understood. The concept of&nbsp;</em><strong><em>this course is built to make you learn, not just watch</em></strong><em>&nbsp;and repeat. Angela is highly educated and it is very much noticeable during the entire course. Again, it is fantastic. Thank you. Please create more courses!!!!!"</em>&nbsp;- Eduard Khachian</p>
<p><strong>Are you trying to choose between all the different iOS courses on Udemy? Take a look at what students on my course had to say about this:</strong></p>
<p><em>I have revamped my expectation for what a</em><strong><em>&nbsp;5 star course&nbsp;</em></strong><em>should be for Udemy. Angela, youre awesome! I already rated the course as 5 stars early on (at about 20% completion), but after completing roughly 70% of the course, I can say this is my favourite Udemy course as of today. Brilliant course Angela!</em>&nbsp;- Alberto L</p>
<p><em>"I took a lot of courses on Udemy and elsewhere and non of them were as clear and perfectly paced as this one! Angelas approach is really awesome,&nbsp;</em><strong><em>deep and clear</em></strong><em>." - Žan Fras</em></p>
<p><em>"I have taken several iOS courses, so far this course had the&nbsp;</em><strong><em>best explanation&nbsp;</em></strong><em>on swift and xcode documentation. The lecturer is kinda humorous sometimes which make this course even more enjoyable." - Bryan Pukanda</em></p>
<p><em>"I have taken lots of courses on udemy and elsewhere for self learning and i can tell you with all the honesty this is one course which&nbsp;</em><strong><em>i did not want it to end</em></strong><em>. It is like one of those movies that you wish keeps going. Whatever concepts are covered were covered very beautifully and made learning quite simple. I got so many answers to Why? in this course like how closures work and why they work that way... why delegates work that way. Thank you so much for this course." - Arun Lakhera</em></p>
<p><em>"I compare this to another top iOS class on Udemy, but I think that this one beats it. The reason? Angela doesnt show you a plethora of material and then say that we will discuss this later, or say "just do this. You will see why later." She goes into the&nbsp;</em><strong><em>reason for doing something</em></strong><em>&nbsp;before doing it."</em>&nbsp;- Clyde Addison</p>
<p><strong>Do you have some experience developing iOS apps and wonder if this course is for you? Take a look at what students on my course had to say about this:</strong></p>
<p><em>"This is the best-organized course for starting Swift that Ive seen. The course is excellent for teaching Swift programming including vital information using Xcode, Github, Cocoapods, Stack Overflow, Alamofire, Firebase, REST APIs and all the services commonly used by app developers. They show all the ways of using Xcode and other services that took me months to learn willy nilly.&nbsp;</em><strong><em>Wish I had this course a year ago</em></strong><em>&nbsp;but even with a year of Swift experience I still found a lot of great information and helpful tips. Love all the extras the course provides especially the assets(graphics, sound files, etc) for practice projects as Im always taking too much time to find some assets to play with. This course understands how to teach programmers by giving them the toolsets and abilities they need to build apps. The course teaches the foundation of the language as well as skills to build your knowledge and improve your troubleshooting skills. Angela is a wonderful speaker and should do the voiceovers on everyones instructional videos, seriously. :)" - Marcy Vernon</em></p>
<p><em>"Def. an amazing and awesome class for learning iOS programming. Ive been coding for years and taken many programming related classes on Udemy and this is def. one of the best. The instructor walks you through all the ins and outs of developing apps for the iOS platform.&nbsp;</em><strong><em>Top Shelf A++ class</em></strong><em>."</em>&nbsp;- Mirko Cukich</p>
<p><strong>REMEMBER&hellip; Im so confident that youll love this course that were offering a FULL money back guarantee for 30 days! So its a complete no-brainer, sign up today with ZERO risk and EVERYTHING to gain.</strong></p>
<p>So what are you waiting for? Click the buy now button and join the worlds most highly rated iOS 13 app development course.</p>
</div>
<div data-purpose="target-audience">
<h2>Who this course is for:</h2>
<ul>
<li>If you are an absolute beginner to coding, then take this course.</li>
<li>If you are a seasoned programmer, then take this course to to get up to speed quickly with Swift 5.1 and native app development. Start with the Xcode walkthrough lesson and well get you familiar with iOS development in no time!</li>
<li>If you are switching from Objective-C to Swift then this is a fast-track way of doing it. You can get started straight away with the Intermediate Swift Language module.</li>
<li>If you are a pro iOS developer and want to quickly get up to date with Apples latest technology, then start with the modules on SwiftUI, ARKit and CoreML.</li>
</ul>
</div>
</div>',
'<div data-purpose="safely-set-inner-html:description:description">
<h2>What youll learn</h2>
<div>
<ul>
<li>
<div data-purpose="objective">
<div>Be able to build any app you want</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>Start your own app based business</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>Create a portfolio of apps to apply for junior developer jobs at a technology company</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>Become a digital nomad by working as a freelance iOS developer</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>Learn to work with Apples latest UI Framework - SwiftUI</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>Master creating Augmented Reality apps using Apple&rsquo;s new ARKit</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>Create apps that use Machine Learning using Apple&rsquo;s new CoreML</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>Master app design so youll know how to wireframe, mockup and prototype your app idea</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>Master app marketing so you can publish your apps and generate downloads</div>
</div>
</li>
</ul>
</div>
</div>'
,curdate(),true,10,2);



insert into `courses`(course_name,course_title,course_thumbnail,course_avatar_url,course_fee,course_full_description,
course_short_description,course_last_updated,is_finished,subject_id,views)
values (
'PHP for Beginners - Become a PHP Master - CMS Project'
,'PHP for Beginners: learn everything you need to become a professional PHP developer with practical exercises & projects.'
,''
,'https://thietkeweb9999.com/data/upload/Banner-Thietkeweb-PHP.jpg'
,9
,'<div data-purpose="safely-set-inner-html:description:description">
<div data-purpose="safely-set-inner-html:description:description">
<div data-purpose="safely-set-inner-html:description:description">
<p><strong>One of the biggest PHP Courses in UDEMY ........</strong></p>
<p><strong>Best Rated PHP course on UDEMY......</strong></p>
<p><strong>Over 90,000 Students taking this course already.........</strong></p>
<p><strong>BEST Reviewed PHP beginners course for a reason.....</strong></p>
<p><strong>-------------------------------------------------------------------------------------------------------------</strong></p>
<p><strong>Are you new to PHP or need a refresher?</strong>&nbsp;Then this course will help you get all the fundamentals of Procedural PHP, Object Oriented PHP, MYSQLi, and ending the course by building a CMS system similar to WordPress, Joomla, or Drupal.</p>
<p><strong>Knowing PHP has allowed me to make enough money to stay home and make courses like this one for students all over the world.</strong>&nbsp;Being a PHP developer can allow anyone to make really good money online and offline, developing dynamic applications.</p>
<p>Knowing&nbsp;<strong>PHP&nbsp;</strong>will allow you to build web applications, websites or Content Management systems, like WordPress, Facebook, Twitter or even Google.</p>
<p><strong>There is no limit to what you can do with this knowledge.</strong>&nbsp;PHP is one of the most important web programming languages to learn, and knowing it, will give you&nbsp;<strong>SUPER POWERS</strong>&nbsp;in the web development world and job market place.</p>
<p><strong>Why?</strong></p>
<p>Because Millions of websites and applications (the majority) use PHP. You can find a job anywhere or even work on your own, online and in places like freelancer or Odesk. You can definitely make a substantial income once you learn it.</p>
<p><strong>Some of my students reviews for this course and others</strong></p>
<p><strong><em>Holy cr*********</em></strong></p>
<p><em>Readed some books about PHP but it was such boring that i never finished a book and withhold me from learning, this course helped me out straight.. After seeing a free tut on youtube i subscribed the course and jeez, i dont even need goals to get or stay motivated cause i have the instructor: Edwin Diaz, his way of teaching is friggin awesome (and fun) and easy listening! To be honest its keeping me away from bed xD.. I really really love the course. If i need to describe the course from my personal view, one word: Epic! Really looking forward for the stuff that will be added in the future! Great job and thumbs up! Greetings from a Dutchy</em></p>
<p><strong><em>Best PHP course************</em></strong></p>
<p><em>This course is just awesome. You will learn the basics and then you will jump to making your own CMS. Every little piece of code is described very well, so you exactly know, what you are doing. After finishing this course I was ready to make my own social networking site and thats amazing isnt it? Another great part of this course is its instructor, who helps you with every issue you have in short time. Ive have already done many internet courses, but this is definetly the best one.</em></p>
<p><strong><em>The Best Php course made FUN and EASY worth The Money!!! *************</em></strong></p>
<p><em>Hi Edwin You have made learning PHP very fun an easy to follow. I got so many ideas that I want to do and had been searching around for 3 years now looking for the right course and lecturer that will help me fulfill my dream. I want to thank you that I have gone through more than half of your online course now and I am still interested to complete it. Thank you for your motivation and kind words. It what keeps me going and I know that once I finish this, I will be able to achieve my goal. I believe that your course is the key to my success in fulfilling my dream. AND the best part is the Lecturer always replies to your questions</em></p>
<p><strong><em>The best course I have taken so far ***************</em></strong></p>
<p><em>Every programming course I have taken until now has been extremely boring and I found it difficult to concentrate, but your course was clear, entertaining and kept me hooked till the very end. I remember everything I learnt in your course and have gained a deeper understanding of terms and methodologies that seems incomprehensible until now. Thank you</em></p>
<p><strong><em> ***************************End of Reviews ***********************</em></strong></p>
<p><strong>My Promise to You</strong></p>
<p>I created this course not just to make money but to teach you the knowledge that will help you with PHP since I was in your shoes some years ago. If you need support, I will be just a message or an email away. I love what I do, but most importantly I love when my students succeed and that for me is priceless. You success depends on yours and I will make sure with that you get all the help you need when you need it.</p>
<p><strong>I will not bore you :)</strong></p>
<p>I take my courses very seriously but at the same time I try to make it fun since I know how difficult learning from an instructor with a monotone voice or boring attitude is. This course is fun, and when you need some energy to keep going, you will get it from me.</p>
<p><strong>My Approach</strong>&nbsp;</p>
<p>Practice, practice and more practice. Every section inside this course has a practice lecture at the end, reinforcing everything with went over in the lectures. I also created a small application the you will be able to download to help you practice PHP. To top it off, we will build and awesome CMS like WordPress, Joomla or Drupal.</p>
<p><strong>Your $ invested in this course will be multiplied over and over again</strong></p>
<p>With over&nbsp;<strong>176 lectures and over of 20 hours&nbsp;</strong>of PURE PHP knowledge from the real world, you can bet, your money will be well spent in this course.</p>
<p><strong>100% Money Back if you dont like it</strong></p>
<p>With 100% money guaranteed within 30 days, you have NOTHING to lose and a world of possibilities for your future. If for some reason you dont like the course or me, you can get your money back from Udemy.</p>
<p><strong>Commonly Asked Questions.....</strong>&nbsp;</p>
<p><strong>Q: Is PHP worth it to learn?&nbsp;</strong>&nbsp;</p>
<p><strong>A: YES YES YES...</strong>&nbsp;</p>
<p>PHP is one of the best web programming languages in the world, and all the large important websites, like Google, Apple, Facebook, Yahoo, Wikipedia and many more use it for their web applications.&nbsp;</p>
<p><strong>Q: Can I make Money if I know PHP?</strong>&nbsp;</p>
<p><strong>A: LOTS of it</strong>&nbsp;</p>
<p>Go over to freelancer dot com and search for PHP projects. You will see so many projects waiting for people to finish them in that site. There are actually more projects in PHP than in any other language.&nbsp;</p>
<p><strong>This PHP Course Covers the following and then some...</strong>&nbsp;</p>
<ul>
<li>
<p>Databases in PHP</p>
</li>
<li>
<p>Object Oriented PHP</p>
</li>
<li>
<p>CMS project-similar to (Wordpress)</p>
</li>
<li>
<p>Form Submissions in PHP</p>
</li>
<li>
<p>Security in PHP</p>
</li>
<li>
<p>Variables in PHP</p>
</li>
<li>
<p>Math in PHP</p>
</li>
<li>
<p>Arrays in PHP</p>
</li>
<li>
<p>Control Structures in PHP</p>
</li>
<li>
<p>Comparison Operators in PHP</p>
</li>
<li>
<p>Mayor Loops in PHP</p>
</li>
<li>
<p>Functions in PHP</p>
</li>
<li>
<p>Constants in PHP</p>
</li>
<li>
<p>Super Globals in PHP</p>
</li>
<li>
<p>Sessions in PHP</p>
</li>
<li>
<p>Cookies in PHP</p>
</li>
<li>
<p>Learn to work with FILES</p>
</li>
<li>
<p>Custom search feature</p>
</li>
<li>
<p>Authentication</p>
</li>
<li>
<p>Learn to use jQuery + Bootstrap</p>
</li>
<li>
<p>RealTime Notifications with JS</p>
</li>
<li>
<p>Protect your credentials with .ENV</p>
</li>
<li>
<p>Learn Composer (PHP dependency Manager)</p>
</li>
<li>
<p>Learn to send emails - from PHP or using a third party Package</p>
</li>
<li>
<p><strong>And much much more .....</strong></p>
</li>
</ul>
<p>With the AMAZING&nbsp;project we build, you will learn all the SKILLS&nbsp;to land that job or project. This is a real project that we take online and I&nbsp;walk step by step on everything from scratch.</p>
<p><strong>Please look at all the lectures to see more things that are covered.</strong>&nbsp;</p>
</div>
<div data-purpose="target-audience">
<h2>Who this course is for:</h2>
<ul>
<li>This course is meant for TOTAL beginners in PHP</li>
<li>No programming experience is needed at all</li>
</ul>
</div>
</div>
</div>'
,'<div data-purpose="safely-set-inner-html:description:description">
<div data-purpose="safely-set-inner-html:description:description">
<h2>What youll learn</h2>
<div>
<div>
<div>
<ul>
<li>
<div data-purpose="objective">
<div>You will learn to create a (CMS) Content Management System like WordPress, Drupal or Joomla</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>You will learn how to use Databases</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>You will learn MySQL</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>Object Oriented Programming</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>You will learn how to launch your application online</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>How to use forms to submit data to databases</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>How to use AJAX to submit data to the server without refreshing the page</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>You will learn about PHP security</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>You will learn about sessions</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>Password hashing</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>Email sending</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>You will learn to use composer (PHP package manager)</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>You will learn to create clean URLs and remove the .php from files</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>You will learn to use bootstrap by getting experience from the project</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>You will learn to debug your code</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>You will learn to create pagination</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>You will code refactoring</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>You will learn to debug (fix your code)</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>You will learn to use an API to bring data from a database to a graphical interface</div>
</div>
</li>
<li>
<div data-purpose="objective">
<div>There is so much more and my hands are just tired of typing :)</div>
</div>
</li>
</ul>
</div>
</div>
</div>
</div>
</div>'
,curdate(),true,4,1);


insert into `courses`(course_name,course_title,course_thumbnail,course_avatar_url,course_fee,course_full_description,
course_short_description,course_last_updated,is_finished,subject_id,views)
values (
'The Complete React Native + Hooks Course'
,'Understand React Native with Hooks, Context, and React Navigation.'
,''
,'https://augnitive.com/wp-content/uploads/2019/10/reactbanner.png'
,9
,'<div data-purpose="safely-set-inner-html:description:description">
<p>If youre tired of spinning your wheels learning Swift or Android, this is the course for you.</p>
<p><strong>Authentication?</strong>&nbsp;You will learn it. <strong>Hooks?&nbsp;</strong>Included. <strong>Navigation?&nbsp;</strong>Of course!</p>
<p>This course will get you up and running with React Native&nbsp;quickly, and teach you the core knowledge you need to deeply understand and build React components for mobile devices.</p>
<p><strong>Both OSX and Windows supported - develop iOS or Android!</strong></p>
<p>This course includes content on both v0.62.2 and the legacy v0.30.x, which is widely used in industry.</p>
<p>Well start by mastering the fundamentals of React, including JSX, &ldquo;props", &ldquo;state", and event handling. Source code is provided for each lecture, so you will always&nbsp;<strong>stay up-to-date</strong>&nbsp;with the course pacing. Special attention has been paid to creating&nbsp;<strong>reusable components</strong>&nbsp;that youl be able to make use of on your own fantastic projects.</p>
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
</div>'
,'<h2>What youll learn</h2>
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
</div>'
,curdate(),true,2,12);


insert into `courses`(course_name,course_title,course_thumbnail,course_avatar_url,course_fee,course_full_description,
course_short_description,course_last_updated,is_finished,subject_id,views)
values (
'Complete React Developer in 2021'
,'Become a Senior React Developer! Build a massive E-commerce app with Redux, Hooks, GraphQL, ContextAPI, Stripe, Firebase'
,''
,'https://js.devexpress.com/Content/ImagesNew/Overview/react-banner.jpg'
,9
,''
,''
,curdate(),true,2,12);


insert into `courses`(course_name,course_title,course_thumbnail,course_avatar_url,course_fee,course_full_description,
course_short_description,course_last_updated,is_finished,subject_id,views)
values (
'React Front To Back'
,'Learn Modern React 16.8+ Including Hooks, Context API, Full Stack MERN & Redux By Building Real Life Projects'
,''
,'https://techvedika.com/wp-content/uploads/2018/01/react.jpg'
,9
,''
,''
,curdate(),true,2,1);


insert into `courses`(course_name,course_title,course_thumbnail,course_avatar_url,course_fee,course_full_description,
course_short_description,course_last_updated,is_finished,subject_id,views)
values (
'Advanced React and Redux'
,'Walkthroughs on advanced React v16.6.3 and Redux v4.0.0 - Authentication, Testing, Middlewares, HOCs, and Deployment'
,''
,'https://www.cloudways.com/blog/wp-content/uploads/Why-ReactJS-Should-be-a-Perfect-Choice-for-Your-Next-Front-end-Application-Banner.jpg'
,9
,''
,''
,curdate(),true,2,12);







insert into `courses`(course_name,course_title,course_thumbnail,course_avatar_url,course_fee,course_full_description,
course_short_description,course_last_updated,is_finished,subject_id,views)
values (
'The Complete React Native + Hooks Course'
,'Understand React Native with Hooks, Context, and React Navigation.'
,''
,'https://augnitive.com/wp-content/uploads/2019/10/reactbanner.png'
,9
,''
,''
,curdate(),true,2,12);

insert into `courses`(course_name,course_title,course_thumbnail,course_avatar_url,course_fee,course_full_description,
course_short_description,course_last_updated,is_finished,subject_id,views)
values (
'Complete React Native in 2021: Zero to Mastery [with Hooks]'
,'Master React Native for iOS and Android Mobile App Development using JavaScript. Build a modern e-commerce mobile app!'
,''
,'https://www.dreamsoft4u.com/images/react-banner.jpg'
,9
,''
,''
,curdate(),true,2,0);

insert into `courses`(course_name,course_title,course_thumbnail,course_avatar_url,course_fee,course_full_description,
course_short_description,course_last_updated,is_finished,subject_id,views)
values (
'Complete React Native in 2021: Zero to Mastery [with Hooks]'
,'Master React Native for iOS and Android Mobile App Development using JavaScript. Build a modern e-commerce mobile app!'
,''
,'https://www.dreamsoft4u.com/images/react-banner.jpg'
,9
,''
,''
,curdate(),true,2,0);

insert into `courses`(course_name,course_title,course_thumbnail,course_avatar_url,course_fee,course_full_description,
course_short_description,course_last_updated,is_finished,subject_id,views)
values (
'MERN Stack Front To Back: Full Stack React, Redux & Node.js'
,'Master React Native for iOS and Android Mobile App Development using JavaScript. Build a modern e-commerce mobile app!'
,''
,'https://www.dreamsoft4u.com/images/react-banner.jpg'
,9
,''
,''
,curdate(),true,2,0);


insert into `courses`(course_name,course_title,course_thumbnail,course_avatar_url,course_fee,course_full_description,
course_short_description,course_last_updated,is_finished,subject_id,views)
values (
'Microservices with Node JS and React'
,'Build, deploy, and scale an E-Commerce app using Microservices built with Node, React, Docker and Kubernetes'
,''
,'https://www.linkites.com/wp-content/uploads/2019/04/React-native-Banner.png'
,9
,''
,''
,curdate(),true,10,0);

insert into `courses`(course_name,course_title,course_thumbnail,course_avatar_url,course_fee,course_full_description,
course_short_description,course_last_updated,is_finished,subject_id,views)
values (
'Course no finished 1'
,'Build, deploy, and scale an E-Commerce app using Microservices built with Node, React, Docker and Kubernetes'
,''
,'https://www.linkites.com/wp-content/uploads/2019/04/React-native-Banner.png'
,3
,''
,''
,curdate(),false,10,0);

insert into `courses`(course_name,course_title,course_thumbnail,course_avatar_url,course_fee,course_full_description,
course_short_description,course_last_updated,is_finished,subject_id,views)
values (
'Course no finished 2'
,'Build, deploy, and scale an E-Commerce app using Microservices built with Node, React, Docker and Kubernetes'
,''
,'https://www.linkites.com/wp-content/uploads/2019/04/React-native-Banner.png'
,3
,''
,''
,curdate(),false,10,0);






CREATE TABLE `sales`(
	sale_id int(10) primary key not null auto_increment,
    sale_percent int(10),
   course_id int(10),

    foreign key (course_id) references `courses` (course_id) on delete cascade
);


insert into `sales` (sale_percent,course_id) values (5,1);
insert into `sales` (sale_percent,course_id) values (10,2);
insert into `sales` (sale_percent,course_id) values (5,3);



CREATE TABLE `chapters`(
	chap_id int(10) primary key not null auto_increment,
    chap_name nvarchar(1000)
);


insert into `chapters` (chap_name) values ('Introduction');
insert into `chapters` (chap_name) values ('Getting started with React');
insert into `chapters` (chap_name) values ('Learn and Understand NodeJS');
insert into `chapters` (chap_name) values ('Big words and nodejs');

insert into `chapters` (chap_name) values ('Introduction');
insert into `chapters` (chap_name) values ('Getting started with React');
insert into `chapters` (chap_name) values ('Learn and Understand NodeJS');
insert into `chapters` (chap_name) values ('Big words and nodejs');

insert into `chapters` (chap_name) values ('Introduction');
insert into `chapters` (chap_name) values ('Getting started with React');
insert into `chapters` (chap_name) values ('Learn and Understand NodeJS');
insert into `chapters` (chap_name) values ('Big words and nodejs');

insert into `chapters` (chap_name) values ('Introduction');
insert into `chapters` (chap_name) values ('Getting started with React');
insert into `chapters` (chap_name) values ('Learn and Understand NodeJS');
insert into `chapters` (chap_name) values ('Big words and nodejs');

insert into `chapters` (chap_name) values ('Introduction');
insert into `chapters` (chap_name) values ('Getting started with React');
insert into `chapters` (chap_name) values ('Learn and Understand NodeJS');
insert into `chapters` (chap_name) values ('Big words and nodejs');

CREATE TABLE `lessons`(
	lesson_id int(10) primary key not null auto_increment,
    lesson_name nvarchar(1000),
	lesson_content nvarchar(1000),
    flag_reviewable bool,
    lesson_video_url nvarchar(5000) default null,
	duration time,
	chap_id int(10) ,

    foreign key (chap_id) references `chapters` (chap_id) on delete cascade
);


insert into `lessons` (lesson_name,lesson_content,flag_reviewable,duration,chap_id) values ('lesson 1 introduction react','',1,SEC_TO_TIME(3600),1);
insert into `lessons` (lesson_name,lesson_content,flag_reviewable,duration,chap_id) values ('lesson 2 introduction node','',1,SEC_TO_TIME(7600),2);
insert into `lessons` (lesson_name,lesson_content,flag_reviewable,duration,chap_id) values ('lesson 2  JSX','',1,SEC_TO_TIME(7600),1);
insert into `lessons` (lesson_name,lesson_content,flag_reviewable,duration,chap_id) values ('lesson 3  Todo list','',1,SEC_TO_TIME(7600),1);


DROP TABLE IF EXISTS `instructor_courses_uploaded`;
CREATE TABLE `instructor_courses_uploaded`(
	id int(10) primary key auto_increment ,
	user_id int(10) not null ,
    course_id int(10)  not null ,
    lesson_id int(10) default null ,
    chap_id int(10) default null ,
	uploaded_day datetime,

--     primary key (user_id,course_id,chap_id,lesson_id),
    
    
    
       foreign key (user_id) references `users` (user_id) ,
	foreign key (course_id) references `courses` (course_id) ,
	foreign key (chap_id) references `chapters` (chap_id) ,
	foreign key (lesson_id) references `lessons` (lesson_id) 
    
--     foreign key (user_id) references `users` (user_id) on delete cascade,
-- 	foreign key (course_id) references `courses` (course_id) on delete cascade,
-- 	foreign key (chap_id) references `chapters` (chap_id) on delete cascade,
-- 	foreign key (lesson_id) references `lessons` (lesson_id) on delete cascade
);


insert into `instructor_courses_uploaded` (user_id,course_id,lesson_id,chap_id,uploaded_day) values (10,1,1,1,STR_TO_DATE('21-05-2021','%d-%m-%Y'));
insert into `instructor_courses_uploaded` (user_id,course_id,lesson_id,chap_id,uploaded_day) values (10,2,1,1,STR_TO_DATE('21-05-2021','%d-%m-%Y'));
insert into `instructor_courses_uploaded` (user_id,course_id,lesson_id,chap_id,uploaded_day) values (10,3,1,1,STR_TO_DATE('21-05-2021','%d-%m-%Y'));
insert into `instructor_courses_uploaded` (user_id,course_id,lesson_id,chap_id,uploaded_day) values (10,4,1,2,STR_TO_DATE('21-05-2021','%d-%m-%Y'));
insert into `instructor_courses_uploaded` (user_id,course_id,lesson_id,chap_id,uploaded_day) values (8,5,2,2,STR_TO_DATE('21-05-2021','%d-%m-%Y'));
insert into `instructor_courses_uploaded` (user_id,course_id,lesson_id,chap_id,uploaded_day) values (8,6,3,3,STR_TO_DATE('21-05-2021','%d-%m-%Y'));
insert into `instructor_courses_uploaded` (user_id,course_id,lesson_id,chap_id,uploaded_day) values (9,7,4,4,STR_TO_DATE('21-05-2021','%d-%m-%Y'));
insert into `instructor_courses_uploaded` (user_id,course_id,lesson_id,chap_id,uploaded_day) values (9,8,4,4,STR_TO_DATE('21-05-2021','%d-%m-%Y'));
insert into `instructor_courses_uploaded` (user_id,course_id,lesson_id,chap_id,uploaded_day) values (9,9,4,4,STR_TO_DATE('21-05-2021','%d-%m-%Y'));
insert into `instructor_courses_uploaded` (user_id,course_id,lesson_id,chap_id,uploaded_day) values (9,10,4,4,STR_TO_DATE('21-05-2021','%d-%m-%Y'));
insert into `instructor_courses_uploaded` (user_id,course_id,lesson_id,chap_id,uploaded_day) values (9,11,1,5,STR_TO_DATE('21-05-2021','%d-%m-%Y'));
insert into `instructor_courses_uploaded` (user_id,course_id,lesson_id,chap_id,uploaded_day) values (9,12,1,6,STR_TO_DATE('21-05-2021','%d-%m-%Y'));
insert into `instructor_courses_uploaded` (user_id,course_id,lesson_id,chap_id,uploaded_day) values (9,13,1,7,STR_TO_DATE('21-05-2021','%d-%m-%Y'));
insert into `instructor_courses_uploaded` (user_id,course_id,lesson_id,chap_id,uploaded_day) values (9,14,1,8,STR_TO_DATE('21-05-2021','%d-%m-%Y'));
insert into `instructor_courses_uploaded` (user_id,course_id,lesson_id,chap_id,uploaded_day) values (9,15,1,9,STR_TO_DATE('21-05-2021','%d-%m-%Y'));
insert into `instructor_courses_uploaded` (user_id,course_id,lesson_id,chap_id,uploaded_day) values (9,16,1,10,STR_TO_DATE('21-05-2021','%d-%m-%Y'));
insert into `instructor_courses_uploaded` (user_id,course_id,lesson_id,chap_id,uploaded_day) values (9,17,1,11,STR_TO_DATE('21-05-2021','%d-%m-%Y'));
insert into `instructor_courses_uploaded` (user_id,course_id,lesson_id,chap_id,uploaded_day) values (9,18,1,12,STR_TO_DATE('21-05-2021','%d-%m-%Y'));
insert into `instructor_courses_uploaded` (user_id,course_id,lesson_id,chap_id,uploaded_day) values (9,19,1,13,STR_TO_DATE('21-05-2021','%d-%m-%Y'));
-- insert into `instructor_courses_uploaded` (user_id,course_id,lesson_id,chap_id,uploaded_day) values (15,22,null,null,STR_TO_DATE('21-05-2021','%d-%m-%Y'));






CREATE TABLE `course_reviews`(
	user_id int(10) not null ,
    course_id int(10)  not null ,
    review_content nvarchar(4000),
    star int(10),

    primary key (user_id,course_id),
    
    foreign key (user_id) references `users` (user_id) on delete cascade,
	foreign key (course_id) references `courses` (course_id) on delete cascade
);


insert into `course_reviews` (user_id,course_id,review_content,star) values (4,1,'Khóa này hay nè!',5);


insert into `course_reviews` (user_id,course_id,review_content,star) values (2,1,'Khóa này hay!',5);
insert into `course_reviews` (user_id,course_id,review_content,star) values (2,2,'Khóa này hay!',5);
insert into `course_reviews` (user_id,course_id,review_content,star) values (2,3,'Khóa này tạm được!',4);
insert into `course_reviews` (user_id,course_id,review_content,star) values (4,2,'Khóa dở tệ!',1);
insert into `course_reviews` (user_id,course_id,review_content,star) values (5,2,'Khóa này tạm được!',3);
insert into `course_reviews` (user_id,course_id,review_content,star) values (5,3,'Khóa này tạm được!',3);
insert into `course_reviews` (user_id,course_id,review_content,star) values (5,1,'Khóa này tạm được!',3);
insert into `course_reviews` (user_id,course_id,review_content,star) values (1,2,'Khóa này hay!',5);
insert into `course_reviews` (user_id,course_id,review_content,star) values (7,3,'Khóa này hay!',5);
insert into `course_reviews` (user_id,course_id,review_content,star) values (7,2,'Khóa này hay!',5);
insert into `course_reviews` (user_id,course_id,review_content,star) values (3,1,'Khóa này hay ghê like!',5);
insert into `course_reviews` (user_id,course_id,review_content,star) values (3,2,'Khóa này hay!',5);
insert into `course_reviews` (user_id,course_id,review_content,star) values (3,3,'Khóa này hay!',5);
insert into `course_reviews` (user_id,course_id,review_content,star) values (3,4,'Khóa này hay!',5);
insert into `course_reviews` (user_id,course_id,review_content,star) values (3,5,'Khóa này hay!',5);
insert into `course_reviews` (user_id,course_id,review_content,star) values (3,6,'Khóa này hay!',5);
insert into `course_reviews` (user_id,course_id,review_content,star) values (3,7,'Khóa này hay!',5);
insert into `course_reviews` (user_id,course_id,review_content,star) values (3,8,'Khóa này hay!',5);
insert into `course_reviews` (user_id,course_id,review_content,star) values (3,9,'Khóa này hay!',5);
insert into `course_reviews` (user_id,course_id,review_content,star) values (3,10,'Khóa này hay!',5);
insert into `course_reviews` (user_id,course_id,review_content,star) values (3,11,'Khóa này hay!',5);
insert into `course_reviews` (user_id,course_id,review_content,star) values (3,12,'Khóa này hay!',5);
insert into `course_reviews` (user_id,course_id,review_content,star) values (3,13,'Khóa này hay!',5);

DROP TABLE IF EXISTS `carts`;
CREATE TABLE `carts`(
	cart_id int(10) not null auto_increment,
    user_id int(10)  not null ,
	course_id int(10)  not null ,

    primary key (cart_id,user_id,course_id),
    
    foreign key (user_id) references `users` (user_id) on delete cascade,
	foreign key (course_id) references `courses` (course_id) on delete cascade
);


insert into `carts` (user_id,course_id) values (2,1);
insert into `carts` (user_id,course_id) values (3,2);




DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`(
	order_id int(10) not null auto_increment,
    user_id int(10)  not null ,
	order_day timestamp,


    primary key (order_id),
    foreign key (user_id) references `users` (user_id) on delete cascade
);


insert into `orders` (user_id,order_day) values (2,str_to_date('12-12-2021','%d-%m-%Y'));
insert into `orders` (user_id,order_day) values (3,str_to_date('13-12-2021','%d-%m-%Y'));
insert into `orders` (user_id,order_day) values (4,str_to_date('13-12-2021','%d-%m-%Y'));
insert into `orders` (user_id,order_day) values (5,str_to_date('13-12-2021','%d-%m-%Y'));
insert into `orders` (user_id,order_day) values (6,str_to_date('13-12-2021','%d-%m-%Y'));
insert into `orders` (user_id,order_day) values (1,str_to_date('13-12-2021','%d-%m-%Y'));
insert into `orders` (user_id,order_day) values (7,str_to_date('13-12-2021','%d-%m-%Y'));




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

insert into `orders_details` (course_id,order_id,total_money) values (1,1,'2000000');
insert into `orders_details` (course_id,order_id,total_money) values (2,1,'3000000');
insert into `orders_details` (course_id,order_id,total_money) values (3,1,'3000000');
insert into `orders_details` (course_id,order_id,total_money) values (1,2,'3000000');
insert into `orders_details` (course_id,order_id,total_money) values (2,2,'3000000');
insert into `orders_details` (course_id,order_id,total_money) values (3,2,'3000000');
insert into `orders_details` (course_id,order_id,total_money) values (3,2,'3000000');
insert into `orders_details` (course_id,order_id,total_money) values (3,3,'3000000');
insert into `orders_details` (course_id,order_id,total_money) values (3,4,'3000000');
insert into `orders_details` (course_id,order_id,total_money) values (1,5,'3000000');
insert into `orders_details` (course_id,order_id,total_money) values (2,5,'3000000');
insert into `orders_details` (course_id,order_id,total_money) values (3,5,'3000000');
insert into `orders_details` (course_id,order_id,total_money) values (1,6,'3000000');
insert into `orders_details` (course_id,order_id,total_money) values (2,6,'3000000');
insert into `orders_details` (course_id,order_id,total_money) values (3,6,'3000000');
insert into `orders_details` (course_id,order_id,total_money) values (2,7,'300');





CREATE TABLE `student_enrolls`(
	enroll_id int(10) not null auto_increment,
    user_id int(10)  not null ,
    course_id int(10)  not null ,

    primary key (enroll_id),
    foreign key (user_id) references `users` (user_id) on delete cascade,
	foreign key (course_id) references `courses` (course_id) on delete cascade
);


insert into `student_enrolls` (user_id,course_id) values (2,1);
insert into `student_enrolls` (user_id,course_id) values (2,2);
insert into `student_enrolls` (user_id,course_id) values (2,3);
insert into `student_enrolls` (user_id,course_id) values (2,4);
insert into `student_enrolls` (user_id,course_id) values (2,5);
insert into `student_enrolls` (user_id,course_id) values (3,1);
insert into `student_enrolls` (user_id,course_id) values (3,2);
insert into `student_enrolls` (user_id,course_id) values (3,3);
insert into `student_enrolls` (user_id,course_id) values (3,4);
insert into `student_enrolls` (user_id,course_id) values (3,5);
insert into `student_enrolls` (user_id,course_id) values (4,7);
insert into `student_enrolls` (user_id,course_id) values (4,6);
insert into `student_enrolls` (user_id,course_id) values (1,7);
insert into `student_enrolls` (user_id,course_id) values (1,6);
insert into `student_enrolls` (user_id,course_id) values (1,1);



CREATE TABLE `student_favorites`(
	fav_id int(10) not null auto_increment,
    user_id int(10)  not null ,
    course_id int(10)  not null ,
	is_favorite bool not null ,

    primary key (fav_id),
    foreign key (user_id) references `users` (user_id),
	foreign key (course_id) references `courses` (course_id) 
);

insert into `student_favorites` (user_id,course_id,is_favorite) values (3,1,true);
insert into `student_favorites` (user_id,course_id,is_favorite) values (3,2,true);
insert into `student_favorites` (user_id,course_id,is_favorite) values (3,3,true);
insert into `student_favorites` (user_id,course_id,is_favorite) values (3,4,true);
insert into `student_favorites` (user_id,course_id,is_favorite) values (3,5,true);
insert into `student_favorites` (user_id,course_id,is_favorite) values (2,1,true);
insert into `student_favorites` (user_id,course_id,is_favorite) values (2,2,true);
insert into `student_favorites` (user_id,course_id,is_favorite) values (2,3,true);




CREATE TABLE `student_watching`(
	watch_id int(10) not null  auto_increment,
    user_id int(10)  not null ,
	lesson_id int(10)  not null ,
    start_time int(10)  not null ,


    primary key (watch_id),
    foreign key (user_id) references `users` (user_id),
	foreign key (lesson_id) references `lessons` (lesson_id)
);

insert into `student_watching` (user_id,lesson_id,start_time) values (2,1,4);
insert into `student_watching` (user_id,lesson_id,start_time) values (2,1,3);





