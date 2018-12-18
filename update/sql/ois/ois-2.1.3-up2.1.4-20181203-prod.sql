

-- 2.1.4

INSERT INTO `base_version` (`id`, `version`, `ctime`, `utime`) VALUES (null, '2.1.4', NOW(), NOW());

DELETE FROM base_dict WHERE bd_type = 'manufacturer';
INSERT INTO `base_dict`  VALUES (NULL, NULL, 'manufacturer', '4', '医科达', 'yikeda', '1', '厂家', 'changjia', NULL, '2', '1', NULL, NOW(), NULL, NOW());
INSERT INTO `base_dict`  VALUES (NULL, NULL, 'manufacturer', '3', 'MIM', 'MIM', '2', '厂家', 'changjia', NULL, '2', '1', NULL,NOW(), NULL, NOW());
INSERT INTO `base_dict`  VALUES (NULL, NULL, 'manufacturer', '2', '瓦里安', 'walian', '3', '厂家', 'changjia', NULL, '2', '1', NULL, NOW(), NULL, NOW());
INSERT INTO `base_dict`  VALUES (NULL, NULL, 'manufacturer', '1', '飞利浦', 'feilipu', '4', '厂家', 'changjia', NULL, '2', '1', NULL, NOW(), NULL, NOW());

INSERT INTO `base_fun_per`  VALUES (NULL, NULL, NULL, NULL, '1153', NULL, '0', '配置管理', '/home/system/configManage', NULL, NULL, NULL, '17', '1', '1', NULL, NULL, NULL, '2018-11-29 10:04:32', '2018-11-29 10:04:55');


DELETE FROM base_role_fun WHERE role_id = 1;
INSERT INTO base_role_fun(role_id,fun_id,create_time,update_time)SELECT 1,id,NOW(),NOW()FROM base_fun_per WHERE
parent_id = (SELECT t.id FROM base_fun_per t WHERE t.fun_name = '系统管理' ) OR id = (SELECT t.id FROM base_fun_per t WHERE t.fun_name = '系统管理' );
