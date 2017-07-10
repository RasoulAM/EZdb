INSERT INTO non_admin(username, password, name, "e-mail", type) VALUES ('hosein', 'qwertyui', 'hosein', 'hos7@gmail.com', 'instructor');
INSERT INTO non_admin(username, password, name, "e-mail", type) VALUES ('reza', 'zaxscdvf', 'reza', 'reza@gmail.com', 'instructor');
INSERT INTO non_admin(username, password, name, "e-mail", type) VALUES ('kambiz', 'asdfghjk', 'kambiz', 'kam@gmail.com', 'normal');
INSERT INTO non_admin(username, password, name, "e-mail", type) VALUES ('mahyar', 'mknjbhvg', 'mahyar', 'mah@gmail.com', 'normal');
INSERT INTO non_admin(username, password, name, "e-mail", type) VALUES ('hamed', 'qwerfatyui', 'hosein', 'hame@gmail.com', 'instructor');
INSERT INTO non_admin(username, password, name, "e-mail", type) VALUES ('rasoul', 'zahgshxscdvf', 'reza', 'raso@gmail.com', 'instructor');
INSERT INTO non_admin(username, password, name, "e-mail", type) VALUES ('peyman', 'asdfgjjdhjk', 'kambiz', 'pey@gmail.com', 'normal');
INSERT INTO non_admin(username, password, name, "e-mail", type) VALUES ('keyvan', 'mknjb43trhvg', 'mahyar', 'key@gmail.com', 'normal');


INSERT INTO admin VALUES ('hamid', 'zxasweqd', 'hamid', 'ham@gmail.com');
INSERT INTO admin VALUES ('mohammad', '14562387', 'mohammad', 'moh@gmail.com');
INSERT INTO admin VALUES ('alireza', 'mvjfuctx', 'alireza', 'ali@gmail.com');
INSERT INTO admin VALUES ('mohsen', 'xvayilkh', 'mohsen', 'mohs@gmail.com');
INSERT INTO admin VALUES ('milad7ink', 'opglkwjilkh', 'milad', 'ink@gmail.com');


INSERT INTO lesson(id, name) VALUES (100001,'math');
INSERT INTO lesson(id, name) VALUES (100002,'jabr');
INSERT INTO lesson(id, name) VALUES (100003,'poetry');
INSERT INTO lesson(id, name) VALUES (100004,'history');
INSERT INTO lesson(id, name) VALUES (100005,'science');
INSERT INTO lesson(id, name) VALUES (100006,'chemistry');


INSERT INTO upgrade(request_id,submit_non_admin_user) VALUES (200001,'kambiz');
INSERT INTO upgrade(request_id,submit_non_admin_user) VALUES (200002,'mahyar');

INSERT INTO start_course(request_id, submit_non_admin_user,submit_lesson_id) VALUES (300001,'hosein', '124940686');
