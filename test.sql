INSERT INTO start_course(submit_non_admin_user,submit_lesson_id) VALUES ('hosein', '124940686');
INSERT INTO upgrade VALUES (DEFAULT , '2:33','1/10/97', 'hosein');
INSERT INTO upgrade VALUES (DEFAULT , '00:16','1/10/97', 'kambiz');

INSERT INTO topic VALUES ('40110', 'omid riazi', NULL , NULL );
INSERT INTO question VALUES ('14323', 'seale 16 konkoor chi mishe?', '14/10/75', '3:13', '10/10/75', 'kambiz', '40110', 'jabr', 'konkoor', DEFAULT );
INSERT INTO answer VALUES ('14333', 'mishe 1', '14/8/91', '14:12', '14/10/60', 'mahyar', '40110', 'jabr', '14323');
INSERT INTO answer VALUES ('14334', 'na mishe 2', '14/8/91', '14:18', '14/8/91', 'kambiz', '40110', 'jabr', '14323');


SELECT * from "check";
INSERT INTO "check" VALUES ('hamid', '379599332', '1/10/96', '13:31', FALSE);
SELECT * FROM request;
SELECT * FROM course;
SELECT * FROM "check";
UPDATE "check" SET result = TRUE WHERE request_id='379599332';
SELECT * FROM lesson;

select submit_lesson_id from start_course, lesson WHERE start_course.submit_lesson_id = lesson.id;
select name from non_admin, start_course where start_course.submit_non_admin_user = non_admin.username;
SELECT submit_non_admin_user FROM start_course;
INSERT INTO post VALUES ('12345', 'salam khoobi', '14/5/96', '15:42', '14/5/96', )

INSERT INTO course VALUES ('1234', DEFAULT , DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, '40110', 'hosein');

INSERT INTO enroll VALUES (638874329,'keyvan', '01/01/01', '01:01');
INSERT INTO enroll VALUES (638874329,'peyman', '01/01/01', '01:01');

SELECT * FROM instructor_view;
INSERT INTO instructor_view VALUES ('41215', 'riazi', DEFAULT , 50, 40, DEFAULT , DEFAULT , '40110', mahyar, '40110', DEFAULT , DEFAULT , DEFAULT )





