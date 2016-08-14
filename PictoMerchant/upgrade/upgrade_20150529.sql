--奖项与优惠产品关联
CREATE TABLE `test`.`coupon_type_discount_rel` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `COUPON_TYPE_ID` INT NOT NULL,
  `DISCOUNT_PRODUCT_ID` INT NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `coupon_type_discount_rel` VALUES (1,1,1),(2,2,2),(3,3,3),(4,4,4),(5,0,5),(6,4,6);

--删掉优惠产品的奖项id字段
ALTER TABLE `test`.`discount_product` DROP COLUMN `coupon_type_id`;

--商户信息增加查询广告位,奖券保存方式字段
ALTER TABLE `test`.`merchant`
ADD COLUMN `query_advert` VARCHAR(255) NULL AFTER `banner_advert`,
ADD COLUMN `save_type` TINYINT(4) NULL AFTER `update_time`;

ALTER TABLE `test`.`account`
CHANGE COLUMN `mechant_id` `merchant_id` INT(11) NOT NULL ;

ALTER TABLE `test`.`coupon_type`
CHANGE COLUMN `is_thanks` `type` TINYINT(4) NULL DEFAULT NULL ;
UPDATE `test`.`coupon_type` SET `type`='1' WHERE `id`='1';
UPDATE `test`.`coupon_type` SET `type`='1' WHERE `id`='2';
UPDATE `test`.`coupon_type` SET `type`='1' WHERE `id`='3';
UPDATE `test`.`coupon_type` SET `type`='1' WHERE `id`='4';
UPDATE `test`.`coupon_type` SET `type`='2' WHERE `id`='5';

ALTER TABLE `test`.`discount_product`
ADD COLUMN `is_sendout` TINYINT(4) NULL DEFAULT 0 AFTER `update_time`;





