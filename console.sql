CREATE TABLE public.user
(
    username VARCHAR(15) PRIMARY KEY CHECK (char_length(username) >= 5),
    password VARCHAR(22) NOT NULL CHECK (char_length(password) >= 8),
    name VARCHAR(15) NOT NULL,
    age INT,
    country VARCHAR(20),
    "e-mail" VARCHAR(50) NOT NULL,
    published_posts INT DEFAULT 0 NOT NULL,
    profile_pics VARCHAR(255)
);
CREATE UNIQUE INDEX "user_e-mail_uindex" ON public.user ("e-mail");


CREATE TABLE admin
(
    username VARCHAR(17) PRIMARY KEY,
    FOREIGN KEY (username) REFERENCES public.user (username) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE public.other
(
    username VARCHAR(15) PRIMARY KEY,
    type BOOLEAN DEFAULT FALSE  NOT NULL,
    membership_started VARCHAR(10) NOT NULL,
    membership_expiry VARCHAR(10) NOT NULL,
    CONSTRAINT other_user_username_fk FOREIGN KEY (username) REFERENCES "user" (username) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE public.lesson
(
    id VARCHAR(6) PRIMARY KEY NOT NULL,
    name VARCHAR(15) NOT NULL
);
CREATE UNIQUE INDEX lesson_lesson_id_uindex ON public.lesson (id);




CREATE TABLE public.request
(
    id VARCHAR(6) PRIMARY KEY NOT NULL,
    submission_time VARCHAR(12) NOT NULL
);
CREATE UNIQUE INDEX request_id_uindex ON public.request (id);


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
    id VARCHAR(6) NOT NULL,
    context VARCHAR(512) NOT NULL,
    publish_date_day INT NOT NULL CHECK (0 <=  publish_date_day  AND publish_date_day <= 31),
    publish_date_month INT NOT NULL CHECK (0 <= publish_date_month AND publish_date_month <= 12),
    publish_date_year INT NOT NULL,
    publish_time VARCHAR(5) NOT NULL,
    last_edit INT DEFAULT 1 NOT NULL,
    likes INT DEFAULT 0 NOT NULL,
    username VARCHAR(22) NOT NULL ,
    lesson_id VARCHAR(6) NOT NULL,
    topic_name VARCHAR(6) NOT NULL,
    CONSTRAINT post_user_username_fk FOREIGN KEY (username) REFERENCES "user" (username) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT post_topic_lesson_fk FOREIGN KEY (lesson_id, topic_name) REFERENCES topic (lesson_id, name) ON DELETE CASCADE ON UPDATE CASCADE
    );
CREATE UNIQUE INDEX post_id_uindex ON public.post (id);
CREATE UNIQUE INDEX post_lesson_id_uindex ON public.post (lesson_id);


CREATE TABLE public.sample_test
(
    id VARCHAR(6) PRIMARY KEY NOT NULL,
    date VARCHAR(10),
    uni_held VARCHAR(40),
    "#_of_questions" INTEGER,
    lesson_id VARCHAR(6) NOT NULL,
    CONSTRAINT sample_test_lesson_lesson_id_fk FOREIGN KEY (lesson_id) REFERENCES lesson (id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE UNIQUE INDEX sample_test_id_uindex ON public.sample_test (id);
CREATE UNIQUE INDEX sample_test_pkey ON public.sample_test (id);
CREATE UNIQUE INDEX sample_test_lesson_id_uindex ON public.sample_test (lesson_id);


CREATE TABLE public.question
(
    post_id VARCHAR(6) PRIMARY KEY NOT NULL,
    title VARCHAR(50) NOT NULL,
    sample_test_id VARCHAR(6) NOT NULL,
    CONSTRAINT question_sample_test_id_fk FOREIGN KEY (sample_test_id) REFERENCES sample_test (id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE UNIQUE INDEX question_post_id_uindex ON public.question (post_id);
CREATE UNIQUE INDEX question_sample_test_id_uindex ON public.question (sample_test_id);



CREATE TABLE public.answer
(
    post_id VARCHAR(6) PRIMARY KEY NOT NULL,
    question_id VARCHAR(6) NOT NULL,
    CONSTRAINT answer_question_post_id_fk FOREIGN KEY (question_id) REFERENCES question (post_id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE UNIQUE INDEX answer_post_id_uindex ON public.answer (post_id);
CREATE UNIQUE INDEX answer_question_id_uindex ON public.answer (question_id);

CREATE TABLE public."like"
(
    user_username VARCHAR(15) NOT NULL,
    post_id VARCHAR(6) NOT NULL,
    time VARCHAR(14) NOT NULL,
    CONSTRAINT like_user_username_fk FOREIGN KEY (user_username) REFERENCES "user" (username) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT like_post_id_fk FOREIGN KEY (user_username) REFERENCES post (id) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (user_username, post_id)
);
CREATE UNIQUE INDEX like_user_username_uindex ON public."like" (user_username);
CREATE UNIQUE INDEX like_post_id_uindex ON public."like" (post_id);



