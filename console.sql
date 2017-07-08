
CREATE TABLE public."user"
(
    username VARCHAR(15) PRIMARY KEY NOT NULL,
    password VARCHAR(22) NOT NULL,
    name VARCHAR(15) NOT NULL,
    age INTEGER,
    country VARCHAR(20),
    "e-mail" VARCHAR(50) NOT NULL,
    published_posts INTEGER DEFAULT 0 NOT NULL,
    profile_pics VARCHAR(255)
);
CREATE UNIQUE INDEX "user_e-mail_uindex" ON public."user" ("e-mail");



CREATE TABLE public.admin
(
    username VARCHAR(17) PRIMARY KEY NOT NULL,
    CONSTRAINT admin_username_fkey FOREIGN KEY (username) REFERENCES "user" (username) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE public.other
(
    username VARCHAR(15) PRIMARY KEY NOT NULL,
    type BOOLEAN DEFAULT false NOT NULL,
    membership_started VARCHAR(10) NOT NULL,
    membership_expiry VARCHAR(10) NOT NULL,
    CONSTRAINT other_user_username_fk FOREIGN KEY (username) REFERENCES "user" (username) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE public.lesson
(
    id VARCHAR(6) PRIMARY KEY NOT NULL,
    name VARCHAR(15) NOT NULL
);



CREATE TABLE public.request
(
    id VARCHAR(6) PRIMARY KEY NOT NULL,
    submission_time VARCHAR(12) NOT NULL
);



CREATE TABLE public.topic
(
    lesson_id VARCHAR(6) NOT NULL,
    name VARCHAR(22) NOT NULL,
    subtopic1 VARCHAR(20),
    subtopic2 VARCHAR(20),
    CONSTRAINT topic_pkey PRIMARY KEY (lesson_id, name),
    CONSTRAINT topic_lesson_id_fk FOREIGN KEY (lesson_id) REFERENCES lesson (id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE UNIQUE INDEX topic_lesson_id_name_uindex ON public.topic (lesson_id, name);



CREATE TABLE public.post
(
    id VARCHAR(6) PRIMARY KEY NOT NULL,
    context VARCHAR(512) NOT NULL,
    publish_date_day INTEGER NOT NULL,
    publish_date_month INTEGER NOT NULL,
    publish_date_year INTEGER NOT NULL,
    publish_time VARCHAR(5) NOT NULL,
    last_edit INTEGER DEFAULT 1 NOT NULL,
    likes INTEGER DEFAULT 0 NOT NULL,
    username VARCHAR(22) NOT NULL,
    lesson_id VARCHAR(6) NOT NULL,
    topic_name VARCHAR(6) NOT NULL,
    CONSTRAINT post_user_username_fk FOREIGN KEY (username) REFERENCES "user" (username) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT post_topic_lesson_fk FOREIGN KEY (lesson_id, topic_name) REFERENCES topic (lesson_id, name) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE public.sample_test
(
    id VARCHAR(6) PRIMARY KEY NOT NULL,
    date VARCHAR(10),
    uni_held VARCHAR(40),
    "#_of_questions" INTEGER,
    lesson_id VARCHAR(6) NOT NULL,
    CONSTRAINT sample_test_lesson_lesson_id_fk FOREIGN KEY (lesson_id) REFERENCES lesson (id) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE public.question
(
    post_id VARCHAR(6) PRIMARY KEY NOT NULL,
    title VARCHAR(50) NOT NULL,
    sample_test_id VARCHAR(6),
    CONSTRAINT question_sample_test_id_fk FOREIGN KEY (sample_test_id) REFERENCES sample_test (id) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE public.answer
(
    post_id VARCHAR(6) PRIMARY KEY NOT NULL,
    question_id VARCHAR(6) NOT NULL,
    CONSTRAINT answer_question_post_id_fk FOREIGN KEY (question_id) REFERENCES question (post_id) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE public."like"
(
    user_username VARCHAR(15) NOT NULL,
    post_id VARCHAR(6) NOT NULL,
    time VARCHAR(14) NOT NULL,
    CONSTRAINT like_pkey PRIMARY KEY (user_username, post_id),
    CONSTRAINT like_post_id_fk FOREIGN KEY (user_username) REFERENCES post (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT like_user_username_fk FOREIGN KEY (user_username) REFERENCES "user" (username) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX like_user_username_post_id_index ON public."like" (user_username, post_id);



CREATE TABLE public.bookmark
(
    user_username VARCHAR(15) NOT NULL,
    post_id VARCHAR(6) NOT NULL,
    time VARCHAR(14) NOT NULL,
    CONSTRAINT bookmark_user_username_post_id_pk PRIMARY KEY (user_username, post_id),
    CONSTRAINT bookmark_user_username_fk FOREIGN KEY (user_username) REFERENCES "user" (username) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT bookmark_post_id_fk FOREIGN KEY (post_id) REFERENCES post (id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE UNIQUE INDEX bookmark_user_username_post_id_pk ON public.bookmark (user_username, post_id);



CREATE TABLE public.content
(
    id VARCHAR(8) PRIMARY KEY NOT NULL,
    title VARCHAR(20) NOT NULL,
    author VARCHAR(30) NOT NULL,
    stock INT DEFAULT 0 NOT NULL,
    price VARCHAR(6) NOT NULL,
    share_username VARCHAR(15) NOT NULL,
    CONSTRAINT content_user_username_fk FOREIGN KEY (share_username) REFERENCES "user" (username) ON DELETE CASCADE ON UPDATE CASCADE
);


-------*****chera moghe ezafe kardan foreign key khodesh auto complete nakard? shayad ghalat bashe
CREATE TABLE public.book
(
    content_id VARCHAR(8) PRIMARY KEY NOT NULL,
    isbn VARCHAR(16) NOT NULL,
    publisher VARCHAR(20) NOT NULL,
    edition INT DEFAULT 1 NOT NULL,
    CONSTRAINT book_content_id_fk FOREIGN KEY (content_id) REFERENCES content (id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE UNIQUE INDEX book_isbn_uindex ON public.book (isbn);



CREATE TABLE public.handout
(
    content_id VARCHAR(8) PRIMARY KEY NOT NULL,
    "#of_pages" INT DEFAULT 1 NOT NULL
);



CREATE TABLE public.course
(
    id VARCHAR(8) PRIMARY KEY NOT NULL,
    title VARCHAR(12) NOT NULL,
    schedule VARCHAR(16) NOT NULL,
    capacity INT DEFAULT 1 NOT NULL,
    attendee INT DEFAULT 1 NOT NULL,
    "#of_sessions" INT DEFAULT 1 NOT NULL,
    price VARCHAR(6) NOT NULL,
    lesson_id VARCHAR(6),
    inst_other_username VARCHAR(15) NOT NULL,
    CONSTRAINT course_user_username_fk FOREIGN KEY (inst_other_username) REFERENCES "user" (username) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT course_lesson_id_fk FOREIGN KEY (lesson_id) REFERENCES lesson (id) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE public.start_course
(
    request_id VARCHAR(6) PRIMARY KEY NOT NULL,
    submit_other_user VARCHAR(15) NOT NULL,
    submit_lesson_id VARCHAR(6) NOT NULL,
    CONSTRAINT start_course_request_id_fk FOREIGN KEY (request_id) REFERENCES request (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT start_course_other_username_fk FOREIGN KEY (submit_other_user) REFERENCES other (username) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT start_course_lesson_id_fk FOREIGN KEY (submit_lesson_id) REFERENCES lesson (id) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE public.upgrade
(
    request_id VARCHAR(6) PRIMARY KEY NOT NULL,
    submit_other_user VARCHAR(15) NOT NULL,
    CONSTRAINT upgrade_request_id_fk FOREIGN KEY (request_id) REFERENCES request (id) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE public."check"
(
    admin_username VARCHAR(15) NOT NULL,
    request_id VARCHAR(6) NOT NULL,
    check_time VARCHAR(14),
    result BOOLEAN,
    CONSTRAINT check_admin_username_request_id_pk PRIMARY KEY (admin_username, request_id),
    CONSTRAINT check_admin_username_fk FOREIGN KEY (admin_username) REFERENCES admin (username) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT check_request_id_fk FOREIGN KEY (request_id) REFERENCES request (id) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE public.enroll
(
    coures_id VARCHAR(6) NOT NULL,
    other_username VARCHAR(15) NOT NULL,
    enrollment_date VARCHAR(14),
    CONSTRAINT enroll_coures_id_other_username_pk PRIMARY KEY (coures_id, other_username),
    CONSTRAINT enroll_course_id_fk FOREIGN KEY (coures_id) REFERENCES course (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT enroll_other_username_fk FOREIGN KEY (other_username) REFERENCES other (username) ON DELETE CASCADE ON UPDATE CASCADE
);