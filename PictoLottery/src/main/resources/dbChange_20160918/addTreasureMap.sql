ALTER TABLE `test`.`merchant` ADD COLUMN `treasure_map` VARCHAR(255) NOT NULL COMMENT '寻宝地图' AFTER `is_validate_openid`,
 ADD COLUMN `treasure_text1` VARCHAR(100) NOT NULL COMMENT '寻宝描述1' AFTER `treasure_map`,
 ADD COLUMN `treasure_text2` VARCHAR(100) NOT NULL COMMENT '寻宝描述2' AFTER `treasure_text1`;
