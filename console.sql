

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



