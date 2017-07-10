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


INSERT INTO lesson(name) VALUES ('math');
INSERT INTO lesson(name) VALUES ('jabr');
INSERT INTO lesson(name) VALUES ('poetry');
INSERT INTO lesson(name) VALUES ('history');
INSERT INTO lesson(name) VALUES ('science');
INSERT INTO lesson(name) VALUES ('chemistry');


INSERT INTO start_course(submit_non_admin_user,submit_lesson_id) VALUES ('hosein', '124940686');


INSERT INTO book(title, isbn, publisher, edition, share_username) VALUES ('jabr1', '132546', 'fatemi', 1, 'hosein');
INSERT INTO book(title, isbn, publisher, edition, share_username) VALUES ('sakhtar', '134526', 'cambridge', 3, 'rasoul');
INSERT INTO book(title, isbn, publisher, edition, share_username) VALUES ('database', '136524', 'rouhani', 2, 'mahyar')

INSERT INTO handout(title, "#of_pages", share_username) VALUES ('database', 116, 'hamed');
INSERT INTO handout(title, "#of_pages", share_username) VALUES ('adabiat', 43, 'keyvan');
INSERT INTO handout(title, "#of_pages", share_username) VALUES ('shimi', 1039, 'peyman');

INSERT INTO sample_test(uni_held, "#_of_questions", lesson_id) VALUES ('sharif', 13, 1241588087);
INSERT INTO sample_test(uni_held, "#_of_questions", lesson_id) VALUES ('beheshti', 6, 124940686);
INSERT INTO sample_test(uni_held, "#_of_questions", lesson_id) VALUES ('shiraz', 5, 1241588087);
INSERT INTO sample_test(uni_held, "#_of_questions", lesson_id) VALUES ('tehran', 11, 2014125264);
