##2.0.14.2
ALTER TABLE `viewer_rs_roiplane`
ADD COLUMN `exist_scanline`  tinyint(4) NOT NULL DEFAULT 0 COMMENT 'contour文件中是否包含scanlinedata数据' AFTER `exist_mpr`;


DROP TABLE IF EXISTS `service_setting`;
CREATE TABLE `service_setting` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project` varchar(16) NOT NULL,
  `category` varchar(64) NOT NULL DEFAULT '',
  `setting_key` varchar(128) NOT NULL,
  `setting_value` varchar(128) NOT NULL,
  `effect_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0：默认生效，1：重启生效',
  `setting_desc` varchar(255) DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `created` bigint(20) NOT NULL DEFAULT '0',
  `updated` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `udx_project_category_key` (`project`,`category`,`setting_key`) USING BTREE
);

-- ----------------------------
-- Records of service_setting
-- ----------------------------
INSERT INTO `service_setting` VALUES ('1', 'api', 'mpr', 'enable', 'true', '0', 'mpr开关', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('2', 'api', 'mpr', 'mpr.cron', '600', '0', 'mpr等待时间（秒）', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('3', 'api', 'mpr', 'query.limit', '100', '0', 'mpr限制数量', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('4', 'api', 'aicontour', 'enable', 'true', '0', '智能勾靶的开关', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('5', 'api', 'aicontour', 'query.limit', '5', '0', '智能勾靶查询限制数量', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('6', 'api', 'aicontour', 'delay.time', '300', '0', '智能勾靶延时时间（秒）', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('7', 'api', 'aicontour', 'wait.time', '300', '0', '智能勾靶等待时间（秒）', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('8', 'api', 'compress', 'task.runflag', 'false', '0', '压缩开关', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('9', 'api', 'compress', 'once.max', '100', '0', '压缩一次instance最大数量', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('10', 'api', 'compress', 'delay.time', '600', '0', '压缩延时时间（秒）', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('11', 'api', 'compress', 'period.time', '600', '0', '压缩周期扫描时间（秒）', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('12', 'api', 'scanlinetask', 'enable', 'true', '0', '定时计算扫描线开关', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('13', 'api', 'aicontourscanline', 'enable', 'true', '0', 'aicontour是否启用计算scanlinedata的功能', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('14', 'archive', 'rscontourscanline', 'enable', 'true', '0', '归档时是否对rs对应的contour计算scanlinedata', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('15', 'core', 'scanline', 'scale', '10', '0', '计算扫描线时所需的放大倍数', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('17', 'api', 'aicontour', 'instance.count', '50', '0', '智能勾靶扫描的最小instance数量', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('18', 'api', 'scanlinetask', 'query.limit', '20', '0', '计算扫描线定时任务查询条数限制', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('19', 'api', 'scanlinetask', 'delay.time', '300', '0', '计算扫描线定时任务间隔时长（秒）', '0', '0', '0');
##2.0.14.3

DELETE FROM `service_setting` WHERE project='core';
INSERT INTO `service_setting`(`project`,`category`,`setting_key`,`setting_value`,`effect_type`,`setting_desc`,`status`,`created`,`updated`) VALUES ('api', 'scanlinetask', 'scanline.scale', '10', '0', '计算扫描线定时任务中放大倍数', '0', '0', '0');
INSERT INTO `service_setting`(`project`,`category`,`setting_key`,`setting_value`,`effect_type`,`setting_desc`,`status`,`created`,`updated`) VALUES ('api', 'aicontourscanline', 'scanline.scale', '10', '0', '智能勾靶中扫描线算法的放大倍数', '0', '0', '0');
INSERT INTO `service_setting`(`project`,`category`,`setting_key`,`setting_value`,`effect_type`,`setting_desc`,`status`,`created`,`updated`) VALUES ('archive', 'rscontourscanline', 'scanline.scale', '10', '0', '归档rs计算扫描线时的放大倍数', '0', '0', '0');

##2.0.15.2

ALTER TABLE viewer_roi_template_item ADD COLUMN interpreted_type TINYINT(4) NOT NULL DEFAULT '0' AFTER roi_type;

## 将系统模版interpreted_type修改为器官
UPDATE viewer_roi_template_item SET interpreted_type=8 WHERE roi_data_type=1;
## 将系统模版interpreted_type修改
UPDATE viewer_roi_template_item SET interpreted_type=1 WHERE roi_data_type=1 AND roi_english_name='Body';


##2.0.15.5

DROP TABLE IF EXISTS `service_setting`;
CREATE TABLE `service_setting` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project` varchar(16) NOT NULL,
  `category` varchar(64) NOT NULL DEFAULT '',
  `setting_key` varchar(128) NOT NULL,
  `setting_value` varchar(128) NOT NULL,
  `effect_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0：默认生效，1：重启生效',
  `setting_desc` varchar(255) DEFAULT NULL,
  `data_type` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `created` bigint(20) NOT NULL DEFAULT '0',
  `updated` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `udx_project_category_key` (`project`,`category`,`setting_key`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of service_setting
-- ----------------------------
INSERT INTO `service_setting` VALUES ('1', 'api', 'mpr', 'enable', 'true', '1', 'mpr开关', '0', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('2', 'api', 'mpr', 'mpr.cron', '600', '1', 'mpr等待时间（秒）', '1', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('3', 'api', 'mpr', 'query.limit', '100', '1', 'mpr限制数量', '1', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('4', 'api', 'aicontour', 'enable', 'true', '1', '智能勾靶的开关', '0', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('5', 'api', 'aicontour', 'query.limit', '50', '1', '智能勾靶查询限制数量', '1', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('6', 'api', 'aicontour', 'delay.time', '300', '1', '智能勾靶延时时间（秒）', '1', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('7', 'api', 'aicontour', 'wait.time', '300', '1', '智能勾靶等待时间（秒）', '1', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('8', 'api', 'compress', 'task.runflag', 'false', '1', '压缩开关', '0', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('9', 'api', 'compress', 'once.max', '100', '1', '压缩一次instance最大数量', '1', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('10', 'api', 'compress', 'delay.time', '600', '1', '压缩延时时间（秒）', '1', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('11', 'api', 'compress', 'period.time', '600', '1', '压缩周期扫描时间（秒）', '1', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('12', 'api', 'scanlinetask', 'enable', 'true', '1', '定时计算扫描线开关', '0', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('13', 'api', 'aicontourscanline', 'enable', 'true', '1', 'aicontour是否启用计算scanlinedata的功能', '0', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('14', 'archive', 'rscontourscanline', 'enable', 'true', '1', '归档时是否对rs对应的contour计算scanlinedata', '0', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('15', 'api', 'aicontour', 'instance.count', '50', '1', '智能勾靶扫描的最小instance数量', '1', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('16', 'api', 'scanlinetask', 'query.limit', '20', '1', '计算扫描线定时任务查询条数限制', '1', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('17', 'api', 'scanlinetask', 'delay.time', '300', '1', '计算扫描线定时任务间隔时长（秒）', '1', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('18', 'api', 'scanlinetask', 'scanline.scale', '10', '1', '计算扫描线定时任务中放大倍数', '1', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('19', 'api', 'aicontourscanline', 'scanline.scale', '10', '1', '智能勾靶中扫描线算法的放大倍数', '1', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('20', 'archive', 'rscontourscanline', 'scanline.scale', '10', '1', '归档rs计算扫描线时的放大倍数', '1', '0', '0', '0');

## 模板更新
## 更新器官
## 大脑
UPDATE viewer_roi_template_item SET roi_english_name='Cerebrum',alg_alias='head_segment_get_cerebrum_contours',alg_roi_name='Cerebrum' WHERE roi_data_type=1 and roi_chinese_name='大脑';
## 左颌下腺
UPDATE viewer_roi_template_item SET alg_alias='head_get_smg_contours',alg_roi_name='SMG_L' WHERE roi_data_type=1 and roi_english_name='SMG_L';
## 右颌下腺
UPDATE viewer_roi_template_item SET alg_alias='head_get_smg_contours',alg_roi_name='SMG_R' WHERE roi_data_type=1 and roi_english_name='SMG_R';
## 口腔
UPDATE viewer_roi_template_item SET alg_alias='head_get_oral_contours',alg_roi_name='OralCavity' WHERE roi_data_type=1 and roi_english_name='OralCavity';
## 左锁骨下动脉
UPDATE viewer_roi_template_item SET alg_alias='chest_get_subclavian_contours',alg_roi_name='Subclavian.A_L' WHERE roi_data_type=1 and roi_english_name='Subclavian.A_L';
## 右锁骨下动脉
UPDATE viewer_roi_template_item SET alg_alias='chest_get_subclavian_contours',alg_roi_name='Subclavian.A_R' WHERE roi_data_type=1 and roi_english_name='Subclavian.A_R';
## 左椎动脉
UPDATE viewer_roi_template_item SET alg_alias='up_body_get_vertebral_contours',alg_roi_name='Vertebral.A_L' WHERE roi_data_type=1 and roi_english_name='Vertebral.A_L';
## 右椎动脉
UPDATE viewer_roi_template_item SET alg_alias='up_body_get_vertebral_contours',alg_roi_name='Vertebral.A_R' WHERE roi_data_type=1 and roi_english_name='Vertebral.A_R';
## 左内乳动脉
UPDATE viewer_roi_template_item SET alg_alias='chest_get_ima_contours',alg_roi_name='IMA_L' WHERE roi_data_type=1 and roi_english_name='IMA_L';
## 右内乳动脉
UPDATE viewer_roi_template_item SET alg_alias='chest_get_ima_contours',alg_roi_name='IMA_R' WHERE roi_data_type=1 and roi_english_name='IMA_R';
## 下腔静脉
UPDATE viewer_roi_template_item SET alg_alias='chest_get_ivc_contours',alg_roi_name='IVC' WHERE roi_data_type=1 and roi_english_name='IVC';

## 关闭器官
## 升主动脉
UPDATE viewer_roi_template_item SET `status`='2' WHERE roi_data_type=1 and roi_english_name='Ascendens.A';
## 降主动脉
UPDATE viewer_roi_template_item SET `status`='2' WHERE roi_data_type=1 and roi_english_name='Descendens.A';
## 主动脉弓
UPDATE viewer_roi_template_item SET `status`='2' WHERE roi_data_type=1 and roi_english_name='Arch.A';


## 增加器官
## 主动脉
INSERT INTO `viewer_roi_template_item` (`tenant_id`, `agency_id`, `platform_id`, `user_id`, `roi_chinese_name`, `roi_chinese_pinyin_name`, `roi_english_name`, `alg_alias`, `alg_roi_name`, `roi_display_color`, `roi_display_color_name`, `roi_type`, `interpreted_type`, `match_roi`, `roi_data_type`, `ai_contour_status`, `status`, `created`, `updated`) VALUES ('0', '0', '0', '0', '主动脉', 'zhudongmai', 'Aorta', 'chest_segment_get_adescendens_contours', 'Aorta', '255,0,0', 'Red', '1', '8', '', '1', '1', '1', '4102415399', '4102415399');
## 内耳
INSERT INTO `viewer_roi_template_item` (`tenant_id`, `agency_id`, `platform_id`, `user_id`, `roi_chinese_name`, `roi_chinese_pinyin_name`, `roi_english_name`, `alg_alias`, `alg_roi_name`, `roi_display_color`, `roi_display_color_name`, `roi_type`, `interpreted_type`, `match_roi`, `roi_data_type`, `ai_contour_status`, `status`, `created`, `updated`) VALUES ('0', '0', '0', '0', '内耳', 'neier', 'Ear_Internals', '', '', '218,165,32', 'Goldenrod', '1', '8', '', '1', '1', '1', '4102415398', '4102415398');
## 左内耳
INSERT INTO `viewer_roi_template_item` (`tenant_id`, `agency_id`, `platform_id`, `user_id`, `roi_chinese_name`, `roi_chinese_pinyin_name`, `roi_english_name`, `alg_alias`, `alg_roi_name`, `roi_display_color`, `roi_display_color_name`, `roi_type`, `interpreted_type`, `match_roi`, `roi_data_type`, `ai_contour_status`, `status`, `created`, `updated`) VALUES ('0', '0', '0', '0', '左内耳', 'zuoneier', 'Ear_Internal_L', '', '', '65,105,225', 'Royalblue', '1', '8', '', '1', '1', '1', '4102415397', '4102415397');
## 右内耳
INSERT INTO `viewer_roi_template_item` (`tenant_id`, `agency_id`, `platform_id`, `user_id`, `roi_chinese_name`, `roi_chinese_pinyin_name`, `roi_english_name`, `alg_alias`, `alg_roi_name`, `roi_display_color`, `roi_display_color_name`, `roi_type`, `interpreted_type`, `match_roi`, `roi_data_type`, `ai_contour_status`, `status`, `created`, `updated`) VALUES ('0', '0', '0', '0', '右内耳', 'youneier', 'Ear_Internal_R', '', '', '255,140,0', 'Darkorange', '1', '8', '', '1', '1', '1', '4102415396', '4102415396');
## 全脑
INSERT INTO `viewer_roi_template_item` (`tenant_id`, `agency_id`, `platform_id`, `user_id`, `roi_chinese_name`, `roi_chinese_pinyin_name`, `roi_english_name`, `alg_alias`, `alg_roi_name`, `roi_display_color`, `roi_display_color_name`, `roi_type`, `interpreted_type`, `match_roi`, `roi_data_type`, `ai_contour_status`, `status`, `created`, `updated`) VALUES ('0', '0', '0', '0', '全脑', 'quannao', 'Brain', 'head_get_brain_contours', 'Brain', '255,0,255', 'Fuchsia', '1', '8', '', '1', '1', '1', '4102415395', '4102415395');


## 增减关联
## 头颈部
## 内耳
INSERT INTO viewer_roi_template_related (`template_id`, `template_roi_id`, `dose_sign`, `dose`, `volume_sign`, `volume`, `status`, `created`, `updated`) SELECT (SELECT id FROM viewer_roi_template WHERE template_name='头颈部' AND template_data_type=1), (SELECT id FROM viewer_roi_template_item WHERE roi_english_name='Ear_Internals' AND roi_data_type=1), NULL, NULL, NULL, NULL, '0', '4102413599', '4102413599';
## 左内耳
INSERT INTO viewer_roi_template_related (`template_id`, `template_roi_id`, `dose_sign`, `dose`, `volume_sign`, `volume`, `status`, `created`, `updated`) SELECT (SELECT id FROM viewer_roi_template WHERE template_name='头颈部' AND template_data_type=1), (SELECT id FROM viewer_roi_template_item WHERE roi_english_name='Ear_Internal_L' AND roi_data_type=1), NULL, NULL, NULL, NULL, '0', '4102413598', '4102413598';
## 右内耳
INSERT INTO viewer_roi_template_related (`template_id`, `template_roi_id`, `dose_sign`, `dose`, `volume_sign`, `volume`, `status`, `created`, `updated`) SELECT (SELECT id FROM viewer_roi_template WHERE template_name='头颈部' AND template_data_type=1), (SELECT id FROM viewer_roi_template_item WHERE roi_english_name='Ear_Internal_R' AND roi_data_type=1), NULL, NULL, NULL, NULL, '0', '4102413597', '4102413597';
## 全脑
INSERT INTO viewer_roi_template_related (`template_id`, `template_roi_id`, `dose_sign`, `dose`, `volume_sign`, `volume`, `status`, `created`, `updated`) SELECT (SELECT id FROM viewer_roi_template WHERE template_name='头颈部' AND template_data_type=1), (SELECT id FROM viewer_roi_template_item WHERE roi_english_name='Brain' AND roi_data_type=1), NULL, NULL, NULL, NULL, '0', '4102413596', '4102413596';

## 胸腹部
## 主动脉
INSERT INTO viewer_roi_template_related (`template_id`, `template_roi_id`, `dose_sign`, `dose`, `volume_sign`, `volume`, `status`, `created`, `updated`) SELECT (SELECT id FROM viewer_roi_template WHERE template_name='胸腹部' AND template_data_type=1), (SELECT id FROM viewer_roi_template_item WHERE roi_english_name='Aorta' AND roi_data_type=1), NULL, NULL, NULL, NULL, '0', '4102413595', '4102413595';

UPDATE viewer_roi_template_item SET `status`='1' WHERE roi_data_type=1 and roi_english_name='Vertebral.A_L';
UPDATE viewer_roi_template_item SET `status`='1' WHERE roi_data_type=1 and roi_english_name='Vertebral.A_R';
UPDATE viewer_roi_template_item SET `status`='1' WHERE roi_data_type=1 and roi_english_name='Subclavian.A_L';
UPDATE viewer_roi_template_item SET `status`='1' WHERE roi_data_type=1 and roi_english_name='Subclavian.A_R';
UPDATE viewer_roi_template_item SET `status`='1' WHERE roi_data_type=1 and roi_english_name='IMA_L';
UPDATE viewer_roi_template_item SET `status`='1' WHERE roi_data_type=1 and roi_english_name='IMA_R';
UPDATE viewer_roi_template_item SET `status`='1' WHERE roi_data_type=1 and roi_english_name='IVC';
UPDATE viewer_roi_template_item SET `status`='1' WHERE roi_data_type=1 and roi_english_name='SMG_L';
UPDATE viewer_roi_template_item SET `status`='1' WHERE roi_data_type=1 and roi_english_name='SMG_R';
UPDATE viewer_roi_template_item SET `status`='1' WHERE roi_data_type=1 and roi_english_name='OralCavity';

UPDATE viewer_roi_template_item SET `status`='2' WHERE roi_data_type=1 and roi_english_name='Mandible_L';
UPDATE viewer_roi_template_item SET `status`='2' WHERE roi_data_type=1 and roi_english_name='Mandible_R';
UPDATE viewer_roi_template_item SET `status`='2' WHERE roi_data_type=1 and roi_english_name='Ear_Internals';
UPDATE viewer_roi_template_item SET `status`='2' WHERE roi_data_type=1 and roi_english_name='Ear_Internal_L';
UPDATE viewer_roi_template_item SET `status`='2' WHERE roi_data_type=1 and roi_english_name='Ear_Internal_R';

##2.0.15.6
Delete from `viewer_shortcuts`  where `user_id` = 0;
INSERT INTO `viewer_shortcuts` (`user_id`, `function_name`, `scope`, `shortcuts`, `function_desc`, `status`, `created`, `updated`) VALUES ('0', 'addROI', '', 'alt+a', 'Add a new ROI', '1', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_shortcuts` (`user_id`, `function_name`, `scope`, `shortcuts`, `function_desc`, `status`, `created`, `updated`) VALUES ('0', 'deleteROI', '', 'alt+d', 'Delete the selected ROI', '1', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_shortcuts` (`user_id`, `function_name`, `scope`, `shortcuts`, `function_desc`, `status`, `created`, `updated`) VALUES ('0', 'copyROI', '', 'alt+c', 'Copy ROI', '1', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_shortcuts` (`user_id`, `function_name`, `scope`, `shortcuts`, `function_desc`, `status`, `created`, `updated`) VALUES ('0', 'copyUpper', '', 'u', 'Copy upper', '1', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_shortcuts` (`user_id`, `function_name`, `scope`, `shortcuts`, `function_desc`, `status`, `created`, `updated`) VALUES ('0', 'copyLower', '', 'l', 'Copy lower', '1', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_shortcuts` (`user_id`, `function_name`, `scope`, `shortcuts`, `function_desc`, `status`, `created`, `updated`) VALUES ('0', 'erase', '', 'e', 'Erase Single Slice', '1', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_shortcuts` (`user_id`, `function_name`, `scope`, `shortcuts`, `function_desc`, `status`, `created`, `updated`) VALUES ('0', 'brush', '', 'b', 'Brush', '1', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_shortcuts` (`user_id`, `function_name`, `scope`, `shortcuts`, `function_desc`, `status`, `created`, `updated`) VALUES ('0', 'decreaseBrushSize', '', 'arrowleft', 'Decrease brush size', '1', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_shortcuts` (`user_id`, `function_name`, `scope`, `shortcuts`, `function_desc`, `status`, `created`, `updated`) VALUES ('0', 'increaseBrushSize', '', 'arrowright', 'Increase brush size', '1', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_shortcuts` (`user_id`, `function_name`, `scope`, `shortcuts`, `function_desc`, `status`, `created`, `updated`) VALUES ('0', 'pencil', '', 'p', 'Pencil', '1', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_shortcuts` (`user_id`, `function_name`, `scope`, `shortcuts`, `function_desc`, `status`, `created`, `updated`) VALUES ('0', 'undo', '', 'ctrl+z', 'Undo', '1', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_shortcuts` (`user_id`, `function_name`, `scope`, `shortcuts`, `function_desc`, `status`, `created`, `updated`) VALUES ('0', 'redo', '', 'ctrl+y', 'Redo', '1', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_shortcuts` (`user_id`, `function_name`, `scope`, `shortcuts`, `function_desc`, `status`, `created`, `updated`) VALUES ('0', 'default', '', 'q', 'Default Mode', '1', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_shortcuts` (`user_id`, `function_name`, `scope`, `shortcuts`, `function_desc`, `status`, `created`, `updated`) VALUES ('0', 'move', '', 'm', 'Move Mode', '1', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_shortcuts` (`user_id`, `function_name`, `scope`, `shortcuts`, `function_desc`, `status`, `created`, `updated`) VALUES ('0', 'zoom', '', 'z', 'Zoom Mode', '1', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_shortcuts` (`user_id`, `function_name`, `scope`, `shortcuts`, `function_desc`, `status`, `created`, `updated`) VALUES ('0', 'wW/WL', '', 'w', 'WW/WL Mode', '1', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_shortcuts` (`user_id`, `function_name`, `scope`, `shortcuts`, `function_desc`, `status`, `created`, `updated`) VALUES ('0', 'reset', '', 'r', 'Reset Mode', '1', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_shortcuts` (`user_id`, `function_name`, `scope`, `shortcuts`, `function_desc`, `status`, `created`, `updated`) VALUES ('0', 'information', '', 'i', 'Show/Hide Information Mode', '1', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_shortcuts` (`user_id`, `function_name`, `scope`, `shortcuts`, `function_desc`, `status`, `created`, `updated`) VALUES ('0', 'crosshairs', '', 'c', 'Show/Hide Crosshairs', '1', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_shortcuts` (`user_id`, `function_name`, `scope`, `shortcuts`, `function_desc`, `status`, `created`, `updated`) VALUES ('0', 'clockwise', '', 'alt+1', 'Clockwise Rotation', '1', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_shortcuts` (`user_id`, `function_name`, `scope`, `shortcuts`, `function_desc`, `status`, `created`, `updated`) VALUES ('0', 'anticlockwise', '', 'alt+2', 'Anticlockwise Rotation', '1', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_shortcuts` (`user_id`, `function_name`, `scope`, `shortcuts`, `function_desc`, `status`, `created`, `updated`) VALUES ('0', 'hFlip', '', 'alt+3', 'Flip Horizontally', '1', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_shortcuts` (`user_id`, `function_name`, `scope`, `shortcuts`, `function_desc`, `status`, `created`, `updated`) VALUES ('0', 'vFlip', '', 'alt+4', 'Flip Vertically', '1', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_shortcuts` (`user_id`, `function_name`, `scope`, `shortcuts`, `function_desc`, `status`, `created`, `updated`) VALUES ('0', 'zoom1', '', '1', 'Zoom1', '1', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_shortcuts` (`user_id`, `function_name`, `scope`, `shortcuts`, `function_desc`, `status`, `created`, `updated`) VALUES ('0', 'zoom2', '', '2', 'Zoom2', '1', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_shortcuts` (`user_id`, `function_name`, `scope`, `shortcuts`, `function_desc`, `status`, `created`, `updated`) VALUES ('0', 'zoom3', '', '3', 'Zoom3', '1', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_shortcuts` (`user_id`, `function_name`, `scope`, `shortcuts`, `function_desc`, `status`, `created`, `updated`) VALUES ('0', 'zoom4', '', '4', 'Zoom4', '1', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_shortcuts` (`user_id`, `function_name`, `scope`, `shortcuts`, `function_desc`, `status`, `created`, `updated`) VALUES ('0', 'zoom5', '', '5', 'Zoom5', '1', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_shortcuts` (`user_id`, `function_name`, `scope`, `shortcuts`, `function_desc`, `status`, `created`, `updated`) VALUES ('0', 'zoom6', '', '6', 'Zoom6', '1', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_shortcuts` (`user_id`, `function_name`, `scope`, `shortcuts`, `function_desc`, `status`, `created`, `updated`) VALUES ('0', 'zoom7', '', '7', 'Zoom7', '1', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_shortcuts` (`user_id`, `function_name`, `scope`, `shortcuts`, `function_desc`, `status`, `created`, `updated`) VALUES ('0', 'zoom8', '', '8', 'Zoom8', '1', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_shortcuts` (`user_id`, `function_name`, `scope`, `shortcuts`, `function_desc`, `status`, `created`, `updated`) VALUES ('0', 'zoom9', '', '9', 'Zoom9', '1', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_shortcuts` (`user_id`, `function_name`, `scope`, `shortcuts`, `function_desc`, `status`, `created`, `updated`) VALUES ('0', 'zoom10', '', '0', 'Zoom10', '1', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());


Delete from `viewer_config` where `user_id` = 0;
INSERT INTO `viewer_config` ( `user_id`, `conf_name`, `conf_desc`, `conf_value`, `status`, `created`, `updated`) VALUES ('0', 'ContourResolution', '取值范围为1~10的整数', '10', '0', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_config` ( `user_id`, `conf_name`, `conf_desc`, `conf_value`, `status`, `created`, `updated`) VALUES ('0', 'EnableColorBrush', '取值范围为0~1的整数, 如果取值为1,则配置使用ROI的颜色做笔刷的颜色', '1', '0', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_config` ( `user_id`, `conf_name`, `conf_desc`, `conf_value`, `status`, `created`, `updated`) VALUES ('0', 'AutoSaveDelay', '取值范围为1000~60000的整数, 单位为毫秒', '1000', '0', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_config` ( `user_id`, `conf_name`, `conf_desc`, `conf_value`, `status`, `created`, `updated`) VALUES ('0', 'ShowMPRContour', '取值范围为0~1的整数,1表示在MPR界面显示contour线', '1', '0', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_config` ( `user_id`, `conf_name`, `conf_desc`, `conf_value`, `status`, `created`, `updated`) VALUES ('0', 'EnableROITip', '取值范围为0~1的整数,1表示显示ROI Tip', '1', '0', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_config` ( `user_id`, `conf_name`, `conf_desc`, `conf_value`, `status`, `created`, `updated`) VALUES ('0', 'DefaultBrushSize', '取值范围为1~48的整数', '12', '0', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_config` ( `user_id`, `conf_name`, `conf_desc`, `conf_value`, `status`, `created`, `updated`) VALUES ('0', 'Pencil', '', '1', '1', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_config` ( `user_id`, `conf_name`, `conf_desc`, `conf_value`, `status`, `created`, `updated`) VALUES ('0', 'Brush', '', '1', '1', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_config` ( `user_id`, `conf_name`, `conf_desc`, `conf_value`, `status`, `created`, `updated`) VALUES ('0', 'Derived', '', '1', '1', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_config` ( `user_id`, `conf_name`, `conf_desc`, `conf_value`, `status`, `created`, `updated`) VALUES ('0', 'Margin', '', '1', '1', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_config` ( `user_id`, `conf_name`, `conf_desc`, `conf_value`, `status`, `created`, `updated`) VALUES ('0', 'AutoROIS', '', '1', '1', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_config` ( `user_id`, `conf_name`, `conf_desc`, `conf_value`, `status`, `created`, `updated`) VALUES ('0', 'Template', '', '1', '1', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());
INSERT INTO `viewer_config` ( `user_id`, `conf_name`, `conf_desc`, `conf_value`, `status`, `created`, `updated`) VALUES ('0', 'Interpolate', '', '1', '1', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());

DROP TABLE IF EXISTS `service_setting`;
CREATE TABLE `service_setting` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project` varchar(16) NOT NULL,
  `category` varchar(64) NOT NULL DEFAULT '',
  `setting_key` varchar(128) NOT NULL,
  `setting_value` varchar(128) NOT NULL,
  `effect_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0：默认生效，1：重启生效',
  `setting_desc` varchar(255) DEFAULT NULL,
  `data_type` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `created` bigint(20) NOT NULL DEFAULT '0',
  `updated` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `udx_project_category_key` (`project`,`category`,`setting_key`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of service_setting
-- ----------------------------
INSERT INTO `service_setting` VALUES ('1', 'api', 'mpr', 'enable', 'true', '1', 'mpr开关', '0', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('2', 'api', 'mpr', 'mpr.cron', '600', '1', 'mpr等待时间（秒）', '1', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('3', 'api', 'mpr', 'query.limit', '100', '1', 'mpr限制数量', '1', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('4', 'api', 'aicontour', 'enable', 'true', '1', '智能勾靶的开关', '0', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('5', 'api', 'aicontour', 'query.limit', '50', '1', '智能勾靶查询限制数量', '1', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('6', 'api', 'aicontour', 'delay.time', '300', '1', '智能勾靶延时时间（秒）', '1', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('7', 'api', 'aicontour', 'wait.time', '300', '1', '智能勾靶等待时间（秒）', '1', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('8', 'api', 'compress', 'task.runflag', 'false', '1', '压缩开关', '0', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('9', 'api', 'compress', 'once.max', '100', '1', '压缩一次instance最大数量', '1', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('10', 'api', 'compress', 'delay.time', '600', '1', '压缩延时时间（秒）', '1', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('11', 'api', 'compress', 'period.time', '600', '1', '压缩周期扫描时间（秒）', '1', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('12', 'api', 'scanlinetask', 'enable', 'true', '1', '定时计算扫描线开关', '0', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('13', 'api', 'aicontourscanline', 'enable', 'true', '1', 'aicontour是否启用计算scanlinedata的功能', '0', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('14', 'archive', 'rscontourscanline', 'enable', 'true', '1', '归档时是否对rs对应的contour计算scanlinedata', '0', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('15', 'api', 'aicontour', 'instance.count', '50', '1', '智能勾靶扫描的最小instance数量', '1', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('16', 'api', 'scanlinetask', 'query.limit', '20', '1', '计算扫描线定时任务查询条数限制', '1', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('17', 'api', 'scanlinetask', 'delay.time', '300', '1', '计算扫描线定时任务间隔时长（秒）', '1', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('18', 'api', 'scanlinetask', 'scanline.scale', '10', '1', '计算扫描线定时任务中放大倍数', '1', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('19', 'api', 'aicontourscanline', 'scanline.scale', '10', '1', '智能勾靶中扫描线算法的放大倍数', '1', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('20', 'archive', 'rscontourscanline', 'scanline.scale', '10', '1', '归档rs计算扫描线时的放大倍数', '1', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('21', 'dcmsender', 'send', 'maxRetryPeriod', '120', '1', '自动发送检查周期（秒）', '1', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('22', 'dcmsender', 'send', 'maxRetryTimes', '50', '1', '自动发送重试次数（次）', '1', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('23', 'dcmsender', 'send', 'maxRetryNumPerTime', '500', '1', '自动发送重试时间（秒）', '1', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('24', 'dcmsender', 'send', 'maxSendConcurrent', '50', '1', '最大发送次数（次）', '1', '0', '0', '0');
INSERT INTO `service_setting` VALUES ('25', 'dcmsender', 'schedule', 'retryDelay', '120', '1', '自动发送重试延迟时间（秒）', '1', '0', '0', '0');

## 增加算法
## 腰椎4
UPDATE viewer_roi_template_item SET alg_alias='chest_segment_get_vertebra_body_contours',alg_roi_name='L4',`status`=1 WHERE roi_data_type=1 and roi_english_name='L4';
## 腰椎5
UPDATE viewer_roi_template_item SET alg_alias='chest_segment_get_vertebra_body_contours',alg_roi_name='L5',`status`=1 WHERE roi_data_type=1 and roi_english_name='L5';

## 删除错误器官
## FullBrain
DELETE  FROM viewer_roi_template_item WHERE roi_english_name='FullBrain' AND roi_data_type=1;

## 肠袋
INSERT INTO `viewer_roi_template_item` (`tenant_id`, `agency_id`, `platform_id`, `user_id`, `roi_chinese_name`, `roi_chinese_pinyin_name`, `roi_english_name`, `alg_alias`, `alg_roi_name`, `roi_display_color`, `roi_display_color_name`, `roi_type`, `interpreted_type`, `match_roi`, `roi_data_type`, `ai_contour_status`, `status`, `created`, `updated`) VALUES ('0', '0', '0', '0', '肠袋', 'changdai', 'BowelBag', 'abdomen_get_bowelbag_contours', 'BowelBag', '255,99,71', 'Tomato', '1', '8', '', '1', '1', '1', '4102415789', '4102415789');

INSERT INTO `service_setting`(project,category,setting_key,setting_value,effect_type,setting_desc,data_type,status,created,updated) VALUES ('api', 'aicontour', 'condition', '^((?!(_A|_D|_V|_a|_d|_v|1.5|\+A|\+D|\+V|\+a|\+d|\+v)).)*$', '2', '满足条件的影像序列才智能勾靶
（正则）', '2', '0', '0', '0');
INSERT INTO `service_setting`(project,category,setting_key,setting_value,effect_type,setting_desc,data_type,status,created,updated) VALUES ('api', 'aicontour', 'condition.enable', 'false', '2', '满足条件的影像序列才智能勾靶开关', '0', '0', '0', '0');
INSERT INTO `service_setting`(project,category,setting_key,setting_value,effect_type,setting_desc,data_type,status,created,updated) VALUES ('api', 'aiSend', 'policy', 'series', '2', '自动回传策略study或者series', '2', '0', '0', '0');

