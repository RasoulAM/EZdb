INSERT INTO non_admin VALUES ('hosein', 'qwertyui', 'hosein', 'hos7@gmail.com', 'instructor', '1/1/97', '30/10/98');
INSERT INTO non_admin VALUES ('reza', 'zaxscdvf', 'reza', 'reza@gmail.com', 'instructor', '1/10/97', '3/9/98');
INSERT INTO non_admin VALUES ('kambiz', 'asdfghjk', 'kambiz', 'kam@gmail.com', 'normal', '10/7/97', '3/11/98');
INSERT INTO non_admin VALUES ('mahyar', 'mknjbhvg', 'mahyar', 'mah@gmail.com', 'normal', '1/12/98', '13/1/99');




INSERT INTO admin VALUES ('hamid', 'zxasweqd', 'hamid', 'ham@gmail.com');
INSERT INTO admin VALUES ('mohammad', '14562387', 'mohammad', 'moh@gmail.com');
INSERT INTO admin VALUES ('alireza', 'mvjfuctx', 'alireza', 'ali@gmail.com');
INSERT INTO admin VALUES ('mohsen', 'xvayilkh', 'mohsen', 'mohs@gmail.com');


INSERT INTO lesson VALUES ('40110', 'amar');
INSERT INTO start_course VALUES ('123456', '14:32', 'hosein', '40110');
SELECT * from "check";
INSERT INTO "check" VALUES ('hamid', '123456', '17/10/96', '14:31', FALSE);
SELECT * FROM request;
SELECT * FROM course;
SELECT * FROM "check";
UPDATE "check" SET result = TRUE;


select submit_lesson_id from start_course, lesson WHERE start_course.submit_lesson_id = lesson.id;
select name from non_admin, start_course where start_course.submit_non_admin_user = non_admin.username;
SELECT submit_non_admin_user FROM start_course;