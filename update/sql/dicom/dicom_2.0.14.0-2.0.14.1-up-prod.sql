## 增加自动勾靶启用状态(默认启用)
ALTER TABLE viewer_roi_template_item
ADD COLUMN ai_contour_status TINYINT(4) NOT NULL DEFAULT '1' COMMENT '智能勾靶启用状态,1:启用;2:停用' AFTER roi_data_type;

## 增加分类对应表
DROP TABLE IF EXISTS alg_roi_classify;
CREATE TABLE alg_roi_classify (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  series_id bigint(20) NOT NULL COMMENT '影像series的id',
  alg_roi_name varchar(255) NOT NULL COMMENT '算法生成的roi的名称',
  status tinyint(4) NOT NULL DEFAULT '0',
  created bigint(20) NOT NULL,
  updated bigint(20) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY udx_series_id_alg_roi_name (series_id,alg_roi_name)
);


Delete from viewer_shortcuts where user_id = 0;
INSERT INTO viewer_shortcuts (user_id, function_name, scope, shortcuts, function_desc, status, created, updated)
VALUES ('0', 'addROI', '', 'alt+a', 'Add a new ROI', '1',   UNIX_TIMESTAMP(),  UNIX_TIMESTAMP());
INSERT INTO viewer_shortcuts (user_id, function_name, scope, shortcuts, function_desc, status, created, updated)
VALUES ('0', 'deleteROI', '', 'alt+d', 'Delete the selected ROI', '1',   UNIX_TIMESTAMP(),  UNIX_TIMESTAMP());
INSERT INTO viewer_shortcuts (user_id, function_name, scope, shortcuts, function_desc, status, created, updated)
VALUES ('0', 'copyROI', '', 'alt+c', 'Copy ROI', '1',   UNIX_TIMESTAMP(),  UNIX_TIMESTAMP());
INSERT INTO viewer_shortcuts (user_id, function_name, scope, shortcuts, function_desc, status, created, updated)
VALUES ('0', 'copyUpper', '', 'u', 'Copy upper', '1',   UNIX_TIMESTAMP(),  UNIX_TIMESTAMP());
INSERT INTO viewer_shortcuts (user_id, function_name, scope, shortcuts, function_desc, status, created, updated)
VALUES ('0', 'copyLower', '', 'l', 'Copy lower', '1',   UNIX_TIMESTAMP(),  UNIX_TIMESTAMP());
INSERT INTO viewer_shortcuts (user_id, function_name, scope, shortcuts, function_desc, status, created, updated)
VALUES ('0', 'erase', '', 'e', 'Erase Single Slice', '1',   UNIX_TIMESTAMP(),  UNIX_TIMESTAMP());
INSERT INTO viewer_shortcuts (user_id, function_name, scope, shortcuts, function_desc, status, created, updated)
VALUES ('0', 'brush', '', 'b', 'Brush', '1',   UNIX_TIMESTAMP(),  UNIX_TIMESTAMP());
INSERT INTO viewer_shortcuts (user_id, function_name, scope, shortcuts, function_desc, status, created, updated)
VALUES ('0', 'decreaseBrushSize', '', 'arrowleft', 'Decrease brush size', '1',   UNIX_TIMESTAMP(),  UNIX_TIMESTAMP());
INSERT INTO viewer_shortcuts (user_id, function_name, scope, shortcuts, function_desc, status, created, updated)
VALUES ('0', 'increaseBrushSize', '', 'arrowright', 'Increase brush size', '1',   UNIX_TIMESTAMP(),  UNIX_TIMESTAMP());
INSERT INTO viewer_shortcuts (user_id, function_name, scope, shortcuts, function_desc, status, created, updated)
VALUES ('0', 'pencil', '', 'p', 'Pencil', '1',   UNIX_TIMESTAMP(),  UNIX_TIMESTAMP());
INSERT INTO viewer_shortcuts (user_id, function_name, scope, shortcuts, function_desc, status, created, updated)
VALUES ('0', 'undo', '', 'ctrl+z', 'Undo', '1',   UNIX_TIMESTAMP(),  UNIX_TIMESTAMP());
INSERT INTO viewer_shortcuts (user_id, function_name, scope, shortcuts, function_desc, status, created, updated)
VALUES ('0', 'redo', '', 'ctrl+y', 'Redo', '1',   UNIX_TIMESTAMP(),  UNIX_TIMESTAMP());
INSERT INTO viewer_shortcuts (user_id, function_name, scope, shortcuts, function_desc, status, created, updated)
VALUES ('0', 'default', '', 'q', 'Default Mode', '1',   UNIX_TIMESTAMP(),  UNIX_TIMESTAMP());
INSERT INTO viewer_shortcuts (user_id, function_name, scope, shortcuts, function_desc, status, created, updated)
VALUES ('0', 'move', '', 'm', 'Move Mode', '1',   UNIX_TIMESTAMP(),  UNIX_TIMESTAMP());
INSERT INTO viewer_shortcuts (user_id, function_name, scope, shortcuts, function_desc, status, created, updated)
VALUES ('0', 'zoom', '', 'z', 'Zoom Mode', '1',   UNIX_TIMESTAMP(),  UNIX_TIMESTAMP());
INSERT INTO viewer_shortcuts (user_id, function_name, scope, shortcuts, function_desc, status, created, updated)
VALUES ('0', 'wW/WL', '', 'w', 'WW/WL Mode', '1',   UNIX_TIMESTAMP(),  UNIX_TIMESTAMP());
INSERT INTO viewer_shortcuts (user_id, function_name, scope, shortcuts, function_desc, status, created, updated)
VALUES ('0', 'reset', '', 'r', 'Reset Mode', '1',   UNIX_TIMESTAMP(),  UNIX_TIMESTAMP());
INSERT INTO viewer_shortcuts (user_id, function_name, scope, shortcuts, function_desc, status, created, updated)
VALUES ('0', 'information', '', 'i', 'Show/Hide Information Mode', '1',   UNIX_TIMESTAMP(),  UNIX_TIMESTAMP());
INSERT INTO viewer_shortcuts (user_id, function_name, scope, shortcuts, function_desc, status, created, updated)
VALUES ('0', 'crosshairs', '', 'c', 'Show/Hide Crosshairs', '1',   UNIX_TIMESTAMP(),  UNIX_TIMESTAMP());
INSERT INTO viewer_shortcuts (user_id, function_name, scope, shortcuts, function_desc, status, created, updated)
VALUES ('0', 'clockwise', '', 'alt+1', 'Clockwise Rotation', '1',   UNIX_TIMESTAMP(),  UNIX_TIMESTAMP());
INSERT INTO viewer_shortcuts (user_id, function_name, scope, shortcuts, function_desc, status, created, updated)
VALUES ('0', 'anticlockwise', '', 'alt+2', 'Anticlockwise Rotation', '1',   UNIX_TIMESTAMP(),  UNIX_TIMESTAMP());
INSERT INTO viewer_shortcuts (user_id, function_name, scope, shortcuts, function_desc, status, created, updated)
VALUES ('0', 'hFlip', '', 'alt+3', 'Flip Horizontally', '1',   UNIX_TIMESTAMP(),  UNIX_TIMESTAMP());
INSERT INTO viewer_shortcuts (user_id, function_name, scope, shortcuts, function_desc, status, created, updated)
VALUES ('0', 'vFlip', '', 'alt+4', 'Flip Vertically', '1',   UNIX_TIMESTAMP(),  UNIX_TIMESTAMP());
INSERT INTO viewer_shortcuts (user_id, function_name, scope, shortcuts, function_desc, status, created, updated)
VALUES ('0', 'zoom1', '', '1', 'Zoom1', '1',   UNIX_TIMESTAMP(),  UNIX_TIMESTAMP());
INSERT INTO viewer_shortcuts (user_id, function_name, scope, shortcuts, function_desc, status, created, updated)
VALUES ('0', 'zoom2', '', '2', 'Zoom2', '1',   UNIX_TIMESTAMP(),  UNIX_TIMESTAMP());
INSERT INTO viewer_shortcuts (user_id, function_name, scope, shortcuts, function_desc, status, created, updated)
VALUES ('0', 'zoom3', '', '3', 'Zoom3', '1',   UNIX_TIMESTAMP(),  UNIX_TIMESTAMP());
INSERT INTO viewer_shortcuts (user_id, function_name, scope, shortcuts, function_desc, status, created, updated)
VALUES ('0', 'zoom4', '', '4', 'Zoom4', '1',   UNIX_TIMESTAMP(),  UNIX_TIMESTAMP());
INSERT INTO viewer_shortcuts (user_id, function_name, scope, shortcuts, function_desc, status, created, updated)
VALUES ('0', 'zoom5', '', '5', 'Zoom5', '1',   UNIX_TIMESTAMP(),  UNIX_TIMESTAMP());
INSERT INTO viewer_shortcuts (user_id, function_name, scope, shortcuts, function_desc, status, created, updated)
VALUES ('0', 'zoom6', '', '6', 'Zoom6', '1',   UNIX_TIMESTAMP(),  UNIX_TIMESTAMP());
INSERT INTO viewer_shortcuts (user_id, function_name, scope, shortcuts, function_desc, status, created, updated)
VALUES ('0', 'zoom7', '', '7', 'Zoom7', '1',   UNIX_TIMESTAMP(),  UNIX_TIMESTAMP());
INSERT INTO viewer_shortcuts (user_id, function_name, scope, shortcuts, function_desc, status, created, updated)
VALUES ('0', 'zoom8', '', '8', 'Zoom8', '1',   UNIX_TIMESTAMP(),  UNIX_TIMESTAMP());
INSERT INTO viewer_shortcuts (user_id, function_name, scope, shortcuts, function_desc, status, created, updated)
VALUES ('0', 'zoom9', '', '9', 'Zoom9', '1',   UNIX_TIMESTAMP(),  UNIX_TIMESTAMP());
INSERT INTO viewer_shortcuts (user_id, function_name, scope, shortcuts, function_desc, status, created, updated)
VALUES ('0', 'zoom10', '', '0', 'Zoom10', '1',   UNIX_TIMESTAMP(),  UNIX_TIMESTAMP());

##批量对比字段更新
ALTER TABLE viewer_batch_compared MODIFY `dice_coefficient` decimal(10,2) DEFAULT NULL COMMENT 'dice系数';
ALTER TABLE viewer_batch_compared MODIFY `hausdorff_distance` decimal(10,2) DEFAULT NULL COMMENT 'Hausdorff距离(用于表示某一集合中离另一集合最近点的所有距离的最大值）';
ALTER TABLE viewer_batch_compared MODIFY `inclusive_index` decimal(10,2) DEFAULT NULL COMMENT '包容性指数';
ALTER TABLE viewer_batch_compared MODIFY `sensitivity_index` decimal(10,2) DEFAULT NULL COMMENT '敏感性指数';
ALTER TABLE viewer_batch_compared MODIFY `false_negative_error` decimal(10,2) DEFAULT NULL COMMENT '假阴性率';
ALTER TABLE viewer_batch_compared MODIFY `false_positive_error` decimal(10,2) DEFAULT NULL COMMENT '假阳性率';
ALTER TABLE viewer_batch_compared MODIFY `center_of_mass_deviation` decimal(10,2) DEFAULT NULL COMMENT '质心偏差';
ALTER TABLE viewer_batch_compared MODIFY `jaccard_coefficient` decimal(10,2) DEFAULT NULL COMMENT 'jaccard系数，用于比较有限样本之间的相似性与差异性，jaccard系数值越大，样本相似度越高';

##屏蔽没有算法的模板
##update viewer_roi_template_item set `status`=2 where alg_alias ="" and roi_data_type =1;
 
 
 ## 增加ROI填充样式默认值修改,有1更改为0
ALTER TABLE viewer_rs_roiplane
MODIFY COLUMN fill_style TINYINT(4) NOT NULL DEFAULT 0 COMMENT 'ROI填充样式' AFTER roi_hard_boundary;

##添加笔刷默认值
INSERT INTO `viewer_config` (`user_id`, `conf_name`, `conf_desc`, `conf_value`, `status`, `created`, `updated`) VALUES ('0', 'DefaultBrushSize', '取值范围为1~48的整数', '12', '0', UNIX_TIMESTAMP(),UNIX_TIMESTAMP());