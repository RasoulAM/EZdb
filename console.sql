CREATE DOMAIN date AS VARCHAR(10) CHECK ( VALUE ~ '^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$'); -- dd/mm/yyyy

CREATE DOMAIN age AS INTEGER CHECK (VALUE > 0);

CREATE DOMAIN "e-mail"  AS TEXT NOT NULL CHECK (VALUE ~ '(?:[a-z0-9!#$%&''*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&''*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])');

CREATE DOMAIN url AS TEXT CHECK (VALUE ~ '/(((http|ftp|https):\/{2})+(([0-9a-z_-]+\.)+(aero|asia|biz|cat|com|coop|edu|gov|info|int|jobs|mil|mobi|museum|name|net|org|pro|tel|travel|ac|ad|ae|af|ag|ai|al|am|an|ao|aq|ar|as|at|au|aw|ax|az|ba|bb|bd|be|bf|bg|bh|bi|bj|bm|bn|bo|br|bs|bt|bv|bw|by|bz|ca|cc|cd|cf|cg|ch|ci|ck|cl|cm|cn|co|cr|cu|cv|cx|cy|cz|cz|de|dj|dk|dm|do|dz|ec|ee|eg|er|es|et|eu|fi|fj|fk|fm|fo|fr|ga|gb|gd|ge|gf|gg|gh|gi|gl|gm|gn|gp|gq|gr|gs|gt|gu|gw|gy|hk|hm|hn|hr|ht|hu|id|ie|il|im|in|io|iq|ir|is|it|je|jm|jo|jp|ke|kg|kh|ki|km|kn|kp|kr|kw|ky|kz|la|lb|lc|li|lk|lr|ls|lt|lu|lv|ly|ma|mc|md|me|mg|mh|mk|ml|mn|mn|mo|mp|mr|ms|mt|mu|mv|mw|mx|my|mz|na|nc|ne|nf|ng|ni|nl|no|np|nr|nu|nz|nom|pa|pe|pf|pg|ph|pk|pl|pm|pn|pr|ps|pt|pw|py|qa|re|ra|rs|ru|rw|sa|sb|sc|sd|se|sg|sh|si|sj|sj|sk|sl|sm|sn|so|sr|st|su|sv|sy|sz|tc|td|tf|tg|th|tj|tk|tl|tm|tn|to|tp|tr|tt|tv|tw|tz|ua|ug|uk|us|uy|uz|va|vc|ve|vg|vi|vn|vu|wf|ws|ye|yt|yu|za|zm|zw|arpa)(:[0-9]+)?((\/([~0-9a-zA-Z\#\+\%@\.\/_-]+))?(\?[0-9a-zA-Z\+\%@\/&\[\];=_-]+)?)?))\b/imuS');

CREATE DOMAIN user_type VARCHAR(10) CHECK (VALUE IN ('normal', 'instructor'));

CREATE DOMAIN "time" VARCHAR(5) CHECK (VALUE ~ '^[0-2][0-3]:[0-5][0-9]$');

CREATE TABLE public."user"
(
    username VARCHAR(15) PRIMARY KEY NOT NULL,
    password VARCHAR(22) NOT NULL,
    name VARCHAR(15) NOT NULL,
    age age,
    country VARCHAR(20),
    "e-mail" "e-mail",
    published_posts INTEGER DEFAULT 0 NOT NULL,
    profile_pics url
);
CREATE UNIQUE INDEX "user_e-mail_uindex" ON public."user" ("e-mail");



CREATE TABLE public.admin
(
    username VARCHAR(15) PRIMARY KEY NOT NULL,
    CONSTRAINT admin_username_fkey FOREIGN KEY (username) REFERENCES "user" (username) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE public.non_admin
(
    username VARCHAR(15) PRIMARY KEY NOT NULL,
    type user_type,
    membership_started date NOT NULL,
    membership_expiry date NOT NULL,
    CONSTRAINT non_admin_user_username_fk FOREIGN KEY (username) REFERENCES "user" (username) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE public.lesson
(
    id VARCHAR(6) PRIMARY KEY NOT NULL,
    name VARCHAR(15) NOT NULL
);



CREATE TABLE public.request
(
    id VARCHAR(6) PRIMARY KEY NOT NULL,
    submission_date date NOT NULL ,
    submission_time time NOT NULL
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
    publish_date_date date NOT NULL,
    publish_time time NOT NULL,
    last_edit date,
    likes INTEGER DEFAULT 0 NOT NULL,
    username VARCHAR(22) NOT NULL,
    lesson_id VARCHAR(6) NOT NULL,
    topic_name VARCHAR(15) NOT NULL,
    CONSTRAINT post_user_username_fk FOREIGN KEY (username) REFERENCES "user" (username) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT post_topic_lesson_fk FOREIGN KEY (lesson_id, topic_name) REFERENCES topic (lesson_id, name) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE public.sample_test
(
    id VARCHAR(6) PRIMARY KEY NOT NULL,
    date date,
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
    date date NOT NULL ,
    time time NOT NULL,
    CONSTRAINT like_pkey PRIMARY KEY (user_username, post_id),
    CONSTRAINT like_post_id_fk FOREIGN KEY (user_username) REFERENCES post (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT like_user_username_fk FOREIGN KEY (user_username) REFERENCES "user" (username) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX like_user_username_post_id_index ON public."like" (user_username, post_id);



CREATE TABLE public.bookmark
(
    user_username VARCHAR(15) NOT NULL,
    post_id VARCHAR(6) NOT NULL,
    date date NOT NULL,
    time time NOT NULL,
    CONSTRAINT bookmark_user_username_post_id_pk PRIMARY KEY (user_username, post_id),
    CONSTRAINT bookmark_user_username_fk FOREIGN KEY (user_username) REFERENCES "user" (username) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT bookmark_post_id_fk FOREIGN KEY (post_id) REFERENCES post (id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE public.content
(
    id VARCHAR(8) PRIMARY KEY NOT NULL,
    title VARCHAR(20) NOT NULL,
    author VARCHAR(30),
    stock INT DEFAULT 0 NOT NULL,
    price VARCHAR(6) NOT NULL,
    share_username VARCHAR(15) NOT NULL,
    CONSTRAINT content_user_username_fk FOREIGN KEY (share_username) REFERENCES "user" (username) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE public.book
(
    content_id VARCHAR(8) PRIMARY KEY NOT NULL,
    isbn VARCHAR(16) NOT NULL,
    publisher VARCHAR(20),
    edition INT,
    CONSTRAINT book_content_id_fk FOREIGN KEY (content_id) REFERENCES content (id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE UNIQUE INDEX book_isbn_uindex ON public.book (isbn);



CREATE TABLE public.handout
(
    content_id VARCHAR(8) PRIMARY KEY NOT NULL,
    "#of_pages" INT DEFAULT 0 NOT NULL,
    CONSTRAINT handout_content_id_fk FOREIGN KEY (content_id) REFERENCES content (id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE public.course
(
    id VARCHAR(8) PRIMARY KEY NOT NULL,
    title VARCHAR(12) NOT NULL,
    schedule VARCHAR(16),
    capacity INT DEFAULT 0,
    attendee INT DEFAULT 0,
    "#of_sessions" INT DEFAULT 1 NOT NULL,
    price VARCHAR(6) NOT NULL,
    lesson_id VARCHAR(6),
    instructor_non_admin_username VARCHAR(15) NOT NULL,
    CONSTRAINT course_user_username_fk FOREIGN KEY (instructor_non_admin_username) REFERENCES "user" (username) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT course_lesson_id_fk FOREIGN KEY (lesson_id) REFERENCES lesson (id) ON DELETE CASCADE ON UPDATE CASCADE

);



CREATE TABLE public.start_course
(
    request_id VARCHAR(6) PRIMARY KEY NOT NULL,
    submit_non_admin_user VARCHAR(15) NOT NULL,
    submit_lesson_id VARCHAR(6) NOT NULL,
    CONSTRAINT start_course_request_id_fk FOREIGN KEY (request_id) REFERENCES request (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT start_course_non_admin_username_fk FOREIGN KEY (submit_non_admin_user) REFERENCES non_admin (username) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT start_course_lesson_id_fk FOREIGN KEY (submit_lesson_id) REFERENCES lesson (id) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE public.upgrade
(
    request_id VARCHAR(6) PRIMARY KEY NOT NULL,
    submit_non_admin_user VARCHAR(15) NOT NULL,
    CONSTRAINT upgrade_request_id_fk FOREIGN KEY (request_id) REFERENCES request (id) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE public."check"
(
    admin_username VARCHAR(15) NOT NULL,
    request_id VARCHAR(6) NOT NULL,
    date date,
    time time,
    result BOOLEAN,
    CONSTRAINT check_admin_username_request_id_pk PRIMARY KEY (admin_username, request_id),
    CONSTRAINT check_admin_username_fk FOREIGN KEY (admin_username) REFERENCES admin (username) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT check_request_id_fk FOREIGN KEY (request_id) REFERENCES request (id) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE public.enroll
(
    coures_id VARCHAR(6) NOT NULL,
    non_admin_username VARCHAR(15) NOT NULL,
    date date,
    time time,
    CONSTRAINT enroll_coures_id_non_admin_username_pk PRIMARY KEY (coures_id, non_admin_username),
    CONSTRAINT enroll_course_id_fk FOREIGN KEY (coures_id) REFERENCES course (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT enroll_non_admin_username_fk FOREIGN KEY (non_admin_username) REFERENCES non_admin (username) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE public.reference
(
    content_id VARCHAR(10) NOT NULL,
    course_id VARCHAR(6) NOT NULL,
    CONSTRAINT reference_content_id_course_id_pk PRIMARY KEY (content_id, course_id),
    CONSTRAINT reference_content_id_fk FOREIGN KEY (content_id) REFERENCES content (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT reference_course_id_fk FOREIGN KEY (course_id) REFERENCES course (id) ON DELETE CASCADE ON UPDATE CASCADE
);

