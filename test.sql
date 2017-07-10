INSERT INTO non_admin VALUES ('hosein', 'qwertyui', 'hosein', 'hos7@gmail.com', 'instructor', '1/1/97', '30/10/98');
INSERT INTO non_admin VALUES ('reza', 'zaxscdvf', 'reza', 'reza@gmail.com', 'instructor', '1/10/97', '3/9/98');
INSERT INTO non_admin VALUES ('kambiz', 'asdfghjk', 'kambiz', 'kam@gmail.com', 'normal', '10/7/97', '3/11/98');
INSERT INTO non_admin VALUES ('mahyar', 'mknjbhvg', 'mahyar', 'mah@gmail.com', 'normal', '1/12/98', '13/1/99');
INSERT INTO non_admin VALUES ('hamed', 'qwerfatyui', 'hosein', 'hame@gmail.com', 'instructor', '1/1/97', '30/10/98');
INSERT INTO non_admin VALUES ('rasoul', 'zahgshxscdvf', 'reza', 'raso@gmail.com', 'instructor', '1/10/97', '3/9/98');
INSERT INTO non_admin VALUES ('peyman', 'asdfgjjdhjk', 'kambiz', 'pey@gmail.com', 'normal', '10/7/97', '3/11/98');
INSERT INTO non_admin VALUES ('keyvan', 'mknjb43trhvg', 'mahyar', 'key@gmail.com', 'normal', '1/12/98', '13/1/99');


INSERT INTO admin VALUES ('hamid', 'zxasweqd', 'hamid', 'ham@gmail.com');
INSERT INTO admin VALUES ('mohammad', '14562387', 'mohammad', 'moh@gmail.com');
INSERT INTO admin VALUES ('alireza', 'mvjfuctx', 'alireza', 'ali@gmail.com');
INSERT INTO admin VALUES ('mohsen', 'xvayilkh', 'mohsen', 'mohs@gmail.com');
INSERT INTO admin VALUES ('milad7ink', 'opglkwjilkh', 'milad', 'ink@gmail.com');


INSERT INTO lesson VALUES (DEFAULT , 'amar');
INSERT INTO lesson VALUES (DEFAULT , 'jabr');

INSERT INTO start_course VALUES ('123456', '14:32', 'hosein', '40110');
INSERT INTO start_course VALUES ('154326', '14:31', 'mahyar', '20216');
INSERT INTO upgrade VALUES ('254136', '2:33', 'reza');
INSERT INTO upgrade VALUES ('16853', '00:16', 'kambiz');

INSERT INTO topic VALUES ('40110', 'omid riazi', NULL , NULL );
INSERT INTO question VALUES ('14323', 'seale 16 konkoor chi mishe?', '14/10/75', '3:13', '10/10/75', 'kambiz', '40110', 'jabr', 'konkoor', DEFAULT );
INSERT INTO answer VALUES ('14333', 'mishe 1', '14/8/91', '14:12', '14/10/60', 'mahyar', '40110', 'jabr', '14323');
INSERT INTO answer VALUES ('14334', 'na mishe 2', '14/8/91', '14:18', '14/8/91', 'kambiz', '40110', 'jabr', '14323');


SELECT * from "check";
INSERT INTO "check" VALUES ('mohsen', '16853', '17/10/96', '13:31', FALSE);
SELECT * FROM request;
SELECT * FROM course;
SELECT * FROM "check";
UPDATE "check" SET result = TRUE;
SELECT * FROM lesson;

select submit_lesson_id from start_course, lesson WHERE start_course.submit_lesson_id = lesson.id;
select name from non_admin, start_course where start_course.submit_non_admin_user = non_admin.username;
SELECT submit_non_admin_user FROM start_course;
INSERT INTO post VALUES ('12345', 'salam khoobi', '14/5/96', '15:42', '14/5/96', )

INSERT INTO course VALUES ('1234', DEFAULT , DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, '40110', 'hosein');

SELECT * FROM instructor_view;
INSERT INTO instructor_view VALUES ('41215', 'riazi', DEFAULT , 50, 40, DEFAULT , DEFAULT , '40110', mahyar, '40110', DEFAULT , DEFAULT , DEFAULT )