


-- 2.1.3

INSERT INTO `base_version` (`id`, `version`, `ctime`, `utime`) VALUES (null, '2.1.3', NOW(), NOW());
INSERT INTO `base_fun_per` VALUES (NULL, NULL, NULL, NULL, '1153', NULL, '0', '智能勾画', '/home/system/smartSketch', NULL, NULL, NULL, '16', '1', '1', NULL, NULL, NULL, NOW(), NOW());

DELETE FROM base_role_fun WHERE role_id = 1;
INSERT INTO base_role_fun(role_id,fun_id,create_time,update_time)SELECT 1,id,NOW(),NOW()FROM base_fun_per WHERE
parent_id = (SELECT t.id FROM base_fun_per t WHERE t.fun_name = '系统管理' ) OR id = (SELECT t.id FROM base_fun_per t WHERE t.fun_name = '系统管理' );