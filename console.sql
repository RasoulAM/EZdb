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
    "e-mail" "e-mail" NOT NULL ,
    published_posts INTEGER DEFAULT 0 NOT NULL,
    profile_pics url
);
CREATE UNIQUE INDEX "user_e-mail_uindex" ON public."user" ("e-mail");



CREATE TABLE public.admin
(
    username VARCHAR(15) PRIMARY KEY NOT NULL,
    password VARCHAR(22) NOT NULL,
    name VARCHAR(15) NOT NULL,
    "e-mail" "e-mail" NOT NULL,
    CONSTRAINT admin_username_fkey FOREIGN KEY (username) REFERENCES "user" (username) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE UNIQUE INDEX "admin_e-mail_uindex" ON public.admin ("e-mail");



CREATE TABLE public.non_admin
(
    username VARCHAR(15) PRIMARY KEY NOT NULL,
    password VARCHAR(22) NOT NULL,
    name VARCHAR(15) NOT NULL,
    "e-mail" "e-mail" NOT NULL,
    type user_type,
    membership_started date NOT NULL,
    membership_expiry date NOT NULL,
    CONSTRAINT non_admin_user_username_fk FOREIGN KEY (username) REFERENCES "user" (username) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE UNIQUE INDEX "non_admin_e-mail_uindex" ON public.admin ("e-mail");



CREATE TABLE public.lesson
(
    id VARCHAR(6) PRIMARY KEY NOT NULL,
    name VARCHAR(15) NOT NULL
);



CREATE TABLE public.request
(
    id VARCHAR(6) PRIMARY KEY NOT NULL,
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
    publish_date date NOT NULL,
    publish_time time NOT NULL,
    last_edit date NOT NULL,
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
    context VARCHAR(512) NOT NULL,
    publish_date date NOT NULL,
    publish_time time NOT NULL,
    last_edit date NOT NULL,
    username VARCHAR(22) NOT NULL,
    lesson_id VARCHAR(6) NOT NULL,
    topic_name VARCHAR(15) NOT NULL,
    title VARCHAR(50) NOT NULL,
    sample_test_id VARCHAR(6),
    CONSTRAINT question_sample_test_id_fk FOREIGN KEY (sample_test_id) REFERENCES sample_test (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT question_user_username_fk FOREIGN KEY (username) REFERENCES "user" (username) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT question_topic_lesson_fk FOREIGN KEY (lesson_id, topic_name) REFERENCES topic (lesson_id, name) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE public.answer
(
    post_id VARCHAR(6) PRIMARY KEY NOT NULL,
    context VARCHAR(512) NOT NULL,
    publish_date date NOT NULL,
    publish_time time NOT NULL,
    last_edit date NOT NULL,
    username VARCHAR(22) NOT NULL,
    lesson_id VARCHAR(6) NOT NULL,
    topic_name VARCHAR(15) NOT NULL,
    question_id VARCHAR(6) NOT NULL,
    CONSTRAINT answer_question_post_id_fk FOREIGN KEY (question_id) REFERENCES question (post_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT answer_user_username_fk FOREIGN KEY (username) REFERENCES "user" (username) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT answer_topic_lesson_fk FOREIGN KEY (lesson_id, topic_name) REFERENCES topic (lesson_id, name) ON DELETE CASCADE ON UPDATE CASCADE
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
    stock INT DEFAULT 0,
    price VARCHAR(6),
    share_username VARCHAR(15) NOT NULL,
    CONSTRAINT content_user_username_fk FOREIGN KEY (share_username) REFERENCES "user" (username) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE public.book
(
    content_id VARCHAR(8) PRIMARY KEY NOT NULL,
    title VARCHAR(20) NOT NULL,
    isbn VARCHAR(16) NOT NULL,
    publisher VARCHAR(20),
    edition INT,
    share_username VARCHAR(15) NOT NULL,
    CONSTRAINT book_content_id_fk FOREIGN KEY (content_id) REFERENCES content (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT book_user_username_fk FOREIGN KEY (share_username) REFERENCES "user" (username) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE UNIQUE INDEX book_isbn_uindex ON public.book (isbn);



CREATE TABLE public.handout
(
    content_id VARCHAR(8) PRIMARY KEY NOT NULL,
    title VARCHAR(20) NOT NULL,
    "#of_pages" INT DEFAULT 0 NOT NULL,
    share_username VARCHAR(15) NOT NULL,
    CONSTRAINT handout_content_id_fk FOREIGN KEY (content_id) REFERENCES content (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT handout_user_username_fk FOREIGN KEY (share_username) REFERENCES "user" (username) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE public.course
(
    id VARCHAR(6) PRIMARY KEY NOT NULL,
    title VARCHAR(12),
    schedule VARCHAR(16),
    capacity INT DEFAULT 0,
    attendee INT DEFAULT 0,
    "#of_sessions" INT DEFAULT 1,
    price VARCHAR(6),
    lesson_id VARCHAR(6) NOT NULL ,
    instructor_non_admin_username VARCHAR(15) NOT NULL,
    CONSTRAINT course_user_username_fk FOREIGN KEY (instructor_non_admin_username) REFERENCES "user" (username) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT course_lesson_id_fk FOREIGN KEY (lesson_id) REFERENCES lesson (id) ON DELETE CASCADE ON UPDATE CASCADE

);



CREATE TABLE public.start_course
(
    request_id VARCHAR(6) PRIMARY KEY NOT NULL,
    submission_time time NOT NULL,
    submit_non_admin_user VARCHAR(15) NOT NULL,
    submit_lesson_id VARCHAR(6) NOT NULL,
    CONSTRAINT start_course_request_id_fk FOREIGN KEY (request_id) REFERENCES request (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT start_course_non_admin_username_fk FOREIGN KEY (submit_non_admin_user) REFERENCES non_admin (username) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT start_course_lesson_id_fk FOREIGN KEY (submit_lesson_id) REFERENCES lesson (id) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE public.upgrade
(
    request_id VARCHAR(6) PRIMARY KEY NOT NULL,
    submission_time time NOT NULL,
    submit_non_admin_user VARCHAR(15) NOT NULL,
    CONSTRAINT upgrade_request_id_fk FOREIGN KEY (request_id) REFERENCES request (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT upgrade_non_admin_username_fk FOREIGN KEY (submit_non_admin_user) REFERENCES non_admin (username) ON DELETE CASCADE ON UPDATE CASCADE
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
    CONSTRAINT enroll_course_id_non_admin_username_pk PRIMARY KEY (coures_id, non_admin_username),
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

------------                    --------------
                --Triggers--
------------                    --------------


CREATE OR REPLACE FUNCTION failure_message()
    RETURNS TRIGGER AS $course_held_by_instructor$
    BEGIN
        IF new.submit_non_admin_user NOT IN (SELECT username FROM non_admin WHERE type = 'instructor') THEN
            RAISE EXCEPTION 'you are not an instructor' ;
        END IF;
        RETURN new;
    END;
    $course_held_by_instructor$ LANGUAGE plpgsql;


CREATE TRIGGER course_held_by_instructor
    BEFORE INSERT ON start_course
    FOR EACH ROW
    EXECUTE PROCEDURE failure_message();



CREATE OR REPLACE FUNCTION update_user_type_procedure()
    RETURNS TRIGGER AS $request_acception$
    DECLARE
        a1 VARCHAR(6);
        b1 VARCHAR(15);
    BEGIN
        a1:= (select submit_lesson_id from start_course, lesson WHERE start_course.submit_lesson_id = lesson.id);
        b1:= (select name from non_admin, start_course where start_course.submit_non_admin_user = non_admin.username);

        IF non_admin.username IN (SELECT submit_non_admin_user FROM upgrade NATURAL JOIN "check"
            WHERE "check".request_id=upgrade.request_id AND result=TRUE)
            THEN UPDATE non_admin SET type='instructor';
        ELSEIF non_admin.username IN (SELECT submit_non_admin_user FROM start_course NATURAL JOIN "check"
            WHERE "check".request_id=start_course.request_id AND result = TRUE)
            THEN INSERT INTO course (lesson_id, instructor_non_admin_user) VALUES(a1, b1);
        END IF;
        RETURN NULL;
    END;
    $request_acception$ LANGUAGE plpgsql;

CREATE TRIGGER request_acception
    AFTER UPDATE OF result ON "check"
    EXECUTE PROCEDURE update_user_type_procedure();

-------------user is-a-----------------

CREATE OR REPLACE FUNCTION can_not_change_user()
    RETURNS TRIGGER AS $can_not_change_user$
    BEGIN
        RAISE EXCEPTION 'can not change user';
    END;
    $can_not_change_user$ LANGUAGE plpgsql;

CREATE TRIGGER can_not_change_user
    BEFORE UPDATE ON "user"
    EXECUTE PROCEDURE can_not_change_user();

-- DROP TRIGGER can_not_change_user ON public."user";

CREATE OR REPLACE FUNCTION add_user()
    RETURNS TRIGGER AS $name$
    BEGIN
        INSERT INTO "user" VALUES (new.username,new.password,new.name, NULL ,NULL ,new."e-mail", 0 ,NULL);
        RETURN new ;
    END
    $name$ LANGUAGE plpgsql;


CREATE TRIGGER add_user_before_add_non_admin
    BEFORE INSERT ON non_admin
    FOR EACH ROW
    EXECUTE PROCEDURE add_user();

CREATE TRIGGER add_user_before_add_admin
    BEFORE INSERT ON admin
    FOR EACH ROW
    EXECUTE PROCEDURE add_user();

CREATE OR REPLACE FUNCTION check_capacity()
    RETURNS TRIGGER AS $enroll_if_has_capacity$
        BEGIN
            IF (SELECT attendee FROM enroll  NATURAL JOIN course WHERE coures_id=new.coures_id) >= (SELECT capacity FROM enroll  NATURAL JOIN course WHERE coures_id=new.coures_id) THEN
                RAISE EXCEPTION 'course does not have capacity';
            ELSE
                RETURN new;
            END IF ;
        END;
    $enroll_if_has_capacity$ LANGUAGE plpgsql;


CREATE TRIGGER enroll_if_has_capacity
    BEFORE INSERT ON enroll
    FOR EACH ROW
    EXECUTE PROCEDURE check_capacity();

-----------post is-a-----------------
CREATE OR REPLACE FUNCTION can_not_change_post()
    RETURNS TRIGGER AS $can_not_change_post$
    BEGIN
        RAISE EXCEPTION 'can not change post';
    END;
    $can_not_change_post$ LANGUAGE plpgsql;

CREATE TRIGGER can_not_change_post
    BEFORE UPDATE ON post
    EXECUTE PROCEDURE can_not_change_post();


CREATE OR REPLACE FUNCTION add_post()
    RETURNS TRIGGER AS $add_post_before_add_question$
    BEGIN
        INSERT INTO post VALUES (new.post_id, new.context, new.publish_date, new.publish_time, new.last_edit, new.username, new.lesson_id, new.topic_name);
        RETURN new;
    END;
    $add_post_before_add_question$ LANGUAGE plpgsql;

CREATE TRIGGER add_post_before_add_question
    BEFORE INSERT ON question
    FOR EACH ROW
    EXECUTE PROCEDURE add_post();

CREATE TRIGGER add_post_before_add_answer
    BEFORE INSERT ON answer
    FOR EACH ROW
    EXECUTE PROCEDURE add_post();

-----------content is-a-----------------
CREATE OR REPLACE FUNCTION can_not_change_content()
    RETURNS TRIGGER AS $can_not_change_content$
    BEGIN
        RAISE EXCEPTION 'can not change content';
        RETURN new;
    END;
    $can_not_change_content$ LANGUAGE plpgsql;

CREATE TRIGGER can_not_change_content
    BEFORE UPDATE ON content
    EXECUTE PROCEDURE can_not_change_content();


CREATE OR REPLACE FUNCTION add_content()
    RETURNS TRIGGER AS $add_content_before_add_book$
    BEGIN
        INSERT INTO content VALUES (new.content_id, new.title, NULL, NULL, NULL, new.share_username);
        RETURN new;
    END;
    $add_content_before_add_book$ LANGUAGE plpgsql;

CREATE TRIGGER add_content_before_add_book
    BEFORE INSERT ON book
    FOR EACH ROW
    EXECUTE PROCEDURE add_content();

CREATE TRIGGER add_content_before_add_handout
    BEFORE INSERT ON handout
    FOR EACH ROW
    EXECUTE PROCEDURE add_content();


-----------request is-a-----------------
CREATE OR REPLACE FUNCTION can_not_change_request()
    RETURNS TRIGGER AS $can_not_change_request$
    BEGIN
        RAISE EXCEPTION 'can not change request';
        RETURN new;
    END;
    $can_not_change_request$ LANGUAGE plpgsql;

CREATE TRIGGER can_not_change_request
    BEFORE UPDATE ON request
    EXECUTE PROCEDURE can_not_change_request();


CREATE OR REPLACE FUNCTION add_request()
    RETURNS TRIGGER AS $add_request_before_add_start_course$
    BEGIN
        INSERT INTO request VALUES (new.request_id, new.submission_time);
        RETURN new;
    END;
    $add_request_before_add_start_course$ LANGUAGE plpgsql;

CREATE TRIGGER add_request_before_add_start_course
    BEFORE INSERT ON start_course
    FOR EACH ROW
    EXECUTE PROCEDURE add_request();

CREATE TRIGGER add_request_before_add_upgrade
    BEFORE INSERT ON upgrade
    FOR EACH ROW
    EXECUTE PROCEDURE add_request();



CREATE OR REPLACE FUNCTION attend_failure()
    RETURNS TRIGGER AS $not_attend_in_own$
        BEGIN
            IF new.non_admin_username IN (SELECT username FROM non_admin, enroll AS S
                WHERE new.non_admin_username = S.non_admin_username AND
                type = 'instructor')
                THEN RAISE EXCEPTION 'you can''t attend in your own class';
            END IF;
            RETURN new;
        END;
        $not_attend_in_own$ LANGUAGE plpgsql;


CREATE TRIGGER not_attend_in_own
    BEFORE INSERT ON enroll
    FOR EACH ROW
    EXECUTE PROCEDURE attend_failure();



CREATE OR REPLACE FUNCTION upgrade_to_instructor()
    RETURNS TRIGGER AS $non_admin_instructor$
        BEGIN
            IF new.submit_non_admin_user IN (SELECT username FROM non_admin
                WHERE type = 'instructor')
                THEN RAISE EXCEPTION 'you are not a normal non-admin user!';
            END IF;

        END;
        $non_admin_instructor$ LANGUAGE plpgsql;


CREATE TRIGGER non_admin_instructor
    BEFORE INSERT ON upgrade
    for EACH ROW
    EXECUTE PROCEDURE upgrade_to_instructor();



CREATE OR REPLACE FUNCTION pseudo_encrypt(VALUE int) returns BIGINT AS $$
    DECLARE
        l1 int;
        l2 int;
        r1 int;
        r2 int;
        i int:=0;
    BEGIN
        l1:= (VALUE >> 16) & 65535;
        r1:= VALUE & 65535;
        WHILE i < 3 LOOP
            l2 := r1;
            r2 := l1 # ((((1366.0 * r1 + 150889) % 714025) / 714025.0) * 32767)::int;
            l1 := l2;
            r1 := r2;
            i := i + 1;
        END LOOP;
    RETURN ((l1::bigint << 16) + r1);
END;
$$ LANGUAGE plpgsql strict immutable;



-- Create a sequence for generating the input to the pseudo_encrypt function
create sequence random_int_seq;

-- A function that increments the sequence above and generates a random integer
create function make_random_id() returns bigint as $$
    select pseudo_encrypt(nextval('random_int_seq')::int)
$$ language sql;

create table f (
  -- the id column now has a random default ID
  id integer primary key default make_random_id()
);

insert into f values (default);
insert into f values (default);

select * from f;