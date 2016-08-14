/*
 Navicat MySQL Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50713
 Source Host           : localhost
 Source Database       : test

 Target Server Type    : MySQL
 Target Server Version : 50713
 File Encoding         : utf-8

 Date: 06/11/2016 22:54:28 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `account`
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `merchant_id` int(11) NOT NULL,
  `account_name` varchar(64) DEFAULT NULL,
  `account_pwd` varchar(255) DEFAULT NULL,
  `last_login_time` datetime DEFAULT NULL,
  `state` tinyint(4) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='账户';

-- ----------------------------
--  Table structure for `account_role`
-- ----------------------------
DROP TABLE IF EXISTS `account_role`;
CREATE TABLE `account_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='账户角色表';

-- ----------------------------
--  Table structure for `coupon`
-- ----------------------------
DROP TABLE IF EXISTS `coupon`;
CREATE TABLE `coupon` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `discount_product_id` int(11) NOT NULL,
  `merchant_id` int(11) NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  `serial_number` varchar(16) NOT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `openid` varchar(64) DEFAULT NULL,
  `is_immediate` tinyint(4) DEFAULT NULL,
  `discount` varchar(255) DEFAULT NULL,
  `is_shared` tinyint(4) DEFAULT NULL,
  `use_msg` varchar(255) DEFAULT NULL,
  `limit_msg` varchar(255) DEFAULT NULL,
  `expired_time` datetime NOT NULL,
  `store_name` varchar(64) DEFAULT NULL,
  `state` tinyint(4) NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8 COMMENT='优惠券表';

-- ----------------------------
--  Records of `coupon`
-- ----------------------------
BEGIN;
INSERT INTO `coupon` VALUES ('24', '6', '1', 'sign2', '16j0pxfq', '/images/sign.png', 'TEST555511118888', '0', 'discount5', '1', 'useMsg', 'limitMsg1,limitMsg2,limitMsg3', '2016-05-27 22:39:39', 'store6', '1', '2016-05-27 21:39:39', null), ('25', '4', '1', 'sign1', '1mw1m30p', '/images/sign.png', 'TEST555511118888', '0', 'discount4', '1', 'useMsg', 'limitMsg1,limitMsg2,limitMsg3', '2016-05-27 22:44:13', 'store4', '1', '2016-05-27 21:44:13', null), ('26', '4', '1', 'sign1', '1pmm8byo', '/images/sign.png', 'TEST555511118888', '0', 'discount4', '1', 'useMsg', 'limitMsg1,limitMsg2,limitMsg3', '2016-05-27 22:46:07', 'store4', '1', '2016-05-27 21:46:07', null), ('27', '3', '1', 'newproduct', '1pxlziu8', '/images/newProduct.png', 'TEST555511118888', '0', 'discount3', '1', 'useMsg', 'limitMsg1,limitMsg2,limitMsg3', '2016-05-27 22:46:50', 'store3', '1', '2016-05-27 21:46:50', null), ('28', '3', '1', 'newproduct', '1ajx4u5f', '/images/newProduct.png', 'TEST555511118888', '0', 'discount3', '1', 'useMsg', 'limitMsg1,limitMsg2,limitMsg3', '2016-05-27 22:47:17', 'store3', '1', '2016-05-27 21:47:17', null), ('29', '4', '1', 'sign1', '130x3a16', '/images/sign.png', 'TEST555511118888', '0', 'discount4', '1', 'useMsg', 'limitMsg1,limitMsg2,limitMsg3', '2016-05-27 23:39:29', 'store4', '1', '2016-05-27 22:39:29', null), ('30', '6', '1', 'sign2', '1p3pp5ug', '/images/sign.png', 'TEST555511118888', '0', 'discount5', '1', 'useMsg', 'limitMsg1,limitMsg2,limitMsg3', '2016-05-28 10:34:25', 'store6', '1', '2016-05-28 09:34:25', null), ('31', '4', '1', 'sign1', '1e7ztl5k', '/images/sign.png', 'TEST555511118888', '0', 'discount4', '1', 'useMsg', 'limitMsg1,limitMsg2,limitMsg3', '2016-05-28 10:34:54', 'store4', '1', '2016-05-28 09:34:54', null), ('32', '6', '1', 'sign2', '1rychfz8', '/images/sign.png', 'TEST555511118888', '0', 'discount5', '1', 'useMsg', 'limitMsg1,limitMsg2,limitMsg3', '2016-05-28 10:36:25', 'store6', '2', '2016-05-28 09:36:25', '2016-05-28 10:24:12'), ('33', '2', '1', 'cashdeduct', '158c2b3w', '/images/cashDeduction.png', 'TEST555511118888', '1', 'discount2', '1', 'useMsg', 'limitMsg1,limitMsg2,limitMsg3', '2016-05-28 10:48:11', 'store2', '2', '2016-05-28 09:48:11', '2016-05-28 10:19:39'), ('34', '3', '1', 'newproduct', '1s3rm9ph', '/images/newProduct.png', 'TEST555511118888', '0', 'discount3', '1', 'useMsg', 'limitMsg1,limitMsg2,limitMsg3', '2016-05-28 10:59:50', 'store3', '1', '2016-05-28 09:59:50', null), ('35', '2', '1', 'cashdeduct', '1l36yrsc', '/images/cashDeduction.png', 'TEST555511118888', '1', 'discount2', '1', 'useMsg', 'limitMsg1,limitMsg2,limitMsg3', '2016-05-28 11:00:19', 'store2', '1', '2016-05-28 10:00:19', null), ('36', '3', '1', 'newproduct', '11c8f9s0', '/images/newProduct.png', 'TEST555511118888', '0', 'discount3', '1', 'useMsg', 'limitMsg1,limitMsg2,limitMsg3', '2016-05-28 11:00:43', 'store3', '1', '2016-05-28 10:00:43', null), ('37', '3', '1', 'newproduct', '11bqpsau', '/images/newProduct.png', 'TEST555511118888', '0', 'discount3', '1', 'useMsg', 'limitMsg1,limitMsg2,limitMsg3', '2016-05-30 10:27:08', 'store3', '1', '2016-05-28 10:27:08', null), ('38', '3', '1', 'newproduct', '1rlaoigy', '/images/newProduct.png', 'TEST555511118888', '0', 'discount3', '1', 'useMsg', 'limitMsg1,limitMsg2,limitMsg3', '2016-05-30 10:28:08', 'store3', '1', '2016-05-28 10:28:08', null), ('39', '2', '1', 'cashdeduct', '1wpkiax3', '/images/cashDeduction.png', 'TEST555511118888', '1', 'discount2', '1', 'useMsg', 'limitMsg1,limitMsg2,limitMsg3', '2016-05-28 12:28:31', 'store2', '1', '2016-05-28 10:28:31', null), ('40', '2', '1', 'cashdeduct', '1didhkh3', '/images/cashDeduction.png', 'TEST555511118888', '1', 'discount2', '1', 'useMsg', 'limitMsg1,limitMsg2,limitMsg3', '2016-05-28 12:28:55', 'store2', '1', '2016-05-28 10:28:55', null), ('41', '2', '1', 'cashdeduct', '1jcuzyda', '/images/cashDeduction.png', 'TEST555511118888', '1', 'discount2', '1', 'useMsg', 'limitMsg1,limitMsg2,limitMsg3', '2016-05-28 12:29:17', 'store2', '1', '2016-05-28 10:29:17', null), ('42', '6', '1', 'sign2', '1ii9z0bv', '/images/sign.png', 'TEST555511118888', '0', 'discount5', '1', 'useMsg', 'limitMsg1,limitMsg2,limitMsg3', '2016-06-02 10:30:05', 'store6', '1', '2016-05-28 10:30:05', null), ('43', '6', '1', 'sign2', '1rw0plnf', '/images/sign.png', 'TEST555511118888', '0', 'discount5', '1', 'useMsg', 'limitMsg1,limitMsg2,limitMsg3', '2016-06-02 11:01:01', 'store6', '1', '2016-05-28 11:01:01', null), ('44', '6', '1', 'sign2', '1o6vsg1m', '/images/sign.png', 'TEST555511118888', '0', 'discount5', '1', 'useMsg', 'limitMsg1,limitMsg2,limitMsg3', '2016-06-02 11:06:21', 'store6', '1', '2016-05-28 11:06:21', null), ('45', '3', '1', 'newproduct', '1ts2t8th', '/images/newProduct.png', 'TEST555511118888', '0', 'discount3', '1', 'useMsg', 'limitMsg1,limitMsg2,limitMsg3', '2016-05-30 11:29:10', 'store3', '2', '2016-05-28 11:29:10', '2016-05-28 11:29:16'), ('46', '3', '1', '????', '1wf1etea', '/images/newProduct.png', 'TEST555511118888', '0', 'discount3', '1', 'useMsg', 'limitMsg1,limitMsg2,limitMsg3', '2016-05-30 16:37:02', 'store3', '1', '2016-05-28 16:37:02', null), ('47', '6', '1', '?????', '1f8qfrax', '/images/sign.png', 'TEST555511118888', '0', 'discount5', '1', 'useMsg', 'limitMsg1,limitMsg2,limitMsg3', '2016-06-02 17:22:23', 'store6', '1', '2016-05-28 17:22:23', null);
COMMIT;

-- ----------------------------
--  Table structure for `coupon_type`
-- ----------------------------
DROP TABLE IF EXISTS `coupon_type`;
CREATE TABLE `coupon_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `merchant_id` int(11) NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `total_num` int(11) DEFAULT NULL,
  `rest_num` int(11) DEFAULT NULL,
  `is_immediate` tinyint(4) DEFAULT NULL,
  `reset_interval` smallint(6) DEFAULT NULL,
  `last_reset_time` datetime DEFAULT NULL,
  `version` tinyint(4) NOT NULL,
  `state` tinyint(4) NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='奖项';

-- ----------------------------
--  Records of `coupon_type`
-- ----------------------------
BEGIN;
INSERT INTO `coupon_type` VALUES ('1', '1', '全单5折', '/images/50off.png', '2', '2', '1', '1', null, '1', '1', '2016-05-23 23:43:00', null, '1'), ('2', '1', '现金折扣', '/images/cashDeduction.png', '111', '82', '1', '1', null, '19', '1', '2016-05-23 23:43:00', '2016-05-28 10:29:04', '1'), ('3', '1', '新品赠送', '/images/newProduct.png', '111', '123', '0', '1', null, '28', '1', '2016-05-23 23:43:00', '2016-05-28 17:06:02', '1'), ('4', '1', 'sign', '/images/sign.png', '111', '174', '0', '1', null, '27', '1', '2016-05-23 23:43:00', '2016-05-28 17:21:56', '1'), ('5', '1', '谢谢惠顾', null, '1', '100', '0', '1', null, '1', '1', '2016-05-23 23:43:00', null, '2'), ('7', '2', 'cd', '\\uploads\\1\\cashDeduction_20160604172208.png', '100', '100', '1', '1', null, '4', '1', '2016-06-03 01:07:29', '2016-06-04 17:22:25', '1'), ('8', '2', 'sign', '\\uploads\\1\\sign_20160603010945.png', '100', '100', '0', '1', null, '1', '1', '2016-06-03 01:10:22', null, '1'), ('9', '2', '????', '\\uploads\\1\\newProduct_20160603194010.png', '100', '100', '1', '3', null, '1', '1', '2016-06-03 19:40:23', null, '1');
COMMIT;

-- ----------------------------
--  Table structure for `coupon_type_discount_rel`
-- ----------------------------
DROP TABLE IF EXISTS `coupon_type_discount_rel`;
CREATE TABLE `coupon_type_discount_rel` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `COUPON_TYPE_ID` int(11) NOT NULL,
  `DISCOUNT_PRODUCT_ID` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `coupon_type_discount_rel`
-- ----------------------------
BEGIN;
INSERT INTO `coupon_type_discount_rel` VALUES ('1', '1', '1'), ('2', '2', '2'), ('3', '3', '3'), ('4', '4', '4'), ('5', '0', '5'), ('6', '4', '6'), ('7', '9', '9'), ('8', '9', '7');
COMMIT;

-- ----------------------------
--  Table structure for `discount_product`
-- ----------------------------
DROP TABLE IF EXISTS `discount_product`;
CREATE TABLE `discount_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mechant_id` int(11) NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `discount` varchar(255) DEFAULT NULL,
  `is_shared` tinyint(4) DEFAULT '0',
  `use_msg` varchar(255) DEFAULT NULL,
  `limit_msg` varchar(255) DEFAULT NULL,
  `validity` int(11) DEFAULT NULL,
  `store_name` varchar(64) DEFAULT NULL,
  `state` tinyint(4) NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_sendout` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='优惠产品表';

-- ----------------------------
--  Records of `discount_product`
-- ----------------------------
BEGIN;
INSERT INTO `discount_product` VALUES ('1', '1', '全单5折', '/images/50off.png', 'discount1', '1', 'useMsg', 'limitMsg1,limitMsg2,limitMsg3', '1', 'store1', '1', '2016-05-24 22:27:00', '2016-05-24 22:27:00', '0'), ('2', '1', '现金折扣', '/images/cashDeduction.png', 'discount2', '1', 'useMsg', 'limitMsg1,limitMsg2,limitMsg3', '2', 'store2', '1', '2016-05-24 22:27:00', null, '0'), ('3', '1', '新品赠送', '/images/newProduct.png', 'discount3', '1', 'useMsg', 'limitMsg1,limitMsg2,limitMsg3', '48', 'store3', '1', '2016-05-24 22:27:00', null, '0'), ('4', '1', '这是什么', '/images/sign.png', 'discount4', '1', 'useMsg', 'limitMsg1,limitMsg2,limitMsg3', '120', 'store4', '1', '2016-05-24 22:27:00', null, '0'), ('5', '0', null, null, null, null, 'useMsg', 'limitMsg1,limitMsg2,limitMsg3', null, 'store5', '0', '0000-00-00 00:00:00', null, '0'), ('6', '1', '这又是什么', '/images/sign.png', 'discount5', '1', 'useMsg', 'limitMsg1,limitMsg2,limitMsg3', '120', 'store6', '1', '2016-05-24 22:27:00', null, '0'), ('7', '2', 'sign', '\\uploads\\1\\sign_20160604222449.png', '5', '1', 'aaa', 'bb,123456789012,aaa23', '1', null, '1', '2016-06-04 22:28:20', '2016-06-04 23:28:05', '1'), ('9', '2', 'new', '\\uploads\\1\\newProduct_20160604223705.png', '4', '1', 'asd', 'abcdefghijkl,adsf,123456789012', '2', null, '1', '2016-06-04 22:38:17', null, '1');
COMMIT;

-- ----------------------------
--  Table structure for `menu`
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_name` varchar(64) DEFAULT NULL,
  `menu_url` varchar(255) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `need_check` tinyint(4) DEFAULT NULL,
  `state` tinyint(4) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='菜单';

-- ----------------------------
--  Table structure for `merchant`
-- ----------------------------
DROP TABLE IF EXISTS `merchant`;
CREATE TABLE `merchant` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `merchant_name` varchar(64) DEFAULT NULL,
  `brand` varchar(255) DEFAULT NULL,
  `industry_type` smallint(6) DEFAULT NULL,
  `phone` varchar(64) DEFAULT NULL,
  `mobile` varchar(64) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `volumn` int(11) DEFAULT NULL,
  `main_business` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `lottery_link` varchar(255) DEFAULT NULL,
  `lottery_qrcode` varchar(255) DEFAULT NULL,
  `query_link` varchar(255) DEFAULT NULL,
  `main_advert` varchar(255) DEFAULT NULL,
  `banner_advert` varchar(255) DEFAULT NULL,
  `query_advert` varchar(255) DEFAULT NULL,
  `lottery_channel` tinyint(4) DEFAULT NULL,
  `mechant_qrcode` varchar(255) DEFAULT NULL,
  `state` tinyint(4) NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime DEFAULT NULL,
  `save_type` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='商户信息表';

-- ----------------------------
--  Records of `merchant`
-- ----------------------------
BEGIN;
INSERT INTO `merchant` VALUES ('1', 'picto', 'picto', null, '021-12345678', null, 'I\'m in the earth!', '500', '', 'efd', null, null, null, '/images/advert_top.jpg', '/images/advert_bottom.jpg', '/images/advert_bottom.jpg', null, '\\uploads\\1\\mr-prize_qrcode_20160601224505.png', '1', '2016-05-22 16:24:00', '2016-06-01 22:45:15', '1'), ('2', 'mr-prize', 'mr-prize', null, '021-87654321', null, 'here44', '4001', '', 'abc14', null, null, null, '/images/advert_top.jpg', '/images/advert_bottom.jpg', '/images/advert_bottom.jpg', null, '\\uploads\\1\\import_20160601224905.png', '1', '2016-05-22 16:24:00', '2016-06-01 22:49:57', '2');
COMMIT;

-- ----------------------------
--  Table structure for `operation_record`
-- ----------------------------
DROP TABLE IF EXISTS `operation_record`;
CREATE TABLE `operation_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `openid` varchar(64) NOT NULL,
  `merchant_id` int(11) NOT NULL,
  `serial_number` varchar(16) DEFAULT NULL,
  `type` tinyint(4) NOT NULL,
  `operation_time` datetime NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8 COMMENT='抽奖兑换记录表';

-- ----------------------------
--  Records of `operation_record`
-- ----------------------------
BEGIN;
INSERT INTO `operation_record` VALUES ('1', 'TEST555511118888', '1', '', '1', '2016-05-21 22:54:00', '2016-05-22 22:54:00'), ('2', 'TEST555511118888', '1', null, '1', '2016-05-24 00:10:21', '2016-05-24 00:10:21'), ('3', 'TEST555511118888', '1', null, '1', '2016-05-24 00:11:33', '2016-05-24 00:11:33'), ('4', 'TEST555511118888', '1', null, '1', '2016-05-24 00:15:17', '2016-05-24 00:15:17'), ('5', 'TEST555511118888', '1', null, '1', '2016-05-24 22:10:57', '2016-05-24 22:10:57'), ('6', 'TEST555511118888', '1', null, '1', '2016-05-24 22:24:38', '2016-05-24 22:24:38'), ('7', 'TEST555511118888', '1', null, '1', '2016-05-24 22:24:38', '2016-05-24 22:24:38'), ('8', 'TEST555511118888', '1', null, '1', '2016-05-24 22:28:31', '2016-05-24 22:28:31'), ('9', 'TEST555511118888', '1', null, '1', '2016-05-24 22:31:30', '2016-05-24 22:31:30'), ('10', 'TEST555511118888', '1', null, '1', '2016-05-24 22:43:06', '2016-05-24 22:43:06'), ('11', 'TEST555511118888', '1', null, '1', '2016-05-24 22:44:22', '2016-05-24 22:44:22'), ('12', 'TEST555511118888', '1', null, '1', '2016-05-24 23:00:01', '2016-05-24 23:00:01'), ('13', 'TEST555511118888', '1', null, '1', '2016-05-24 23:00:40', '2016-05-24 23:00:40'), ('14', 'TEST555511118888', '1', null, '1', '2016-05-24 23:07:54', '2016-05-24 23:07:54'), ('15', 'TEST555511118888', '1', null, '1', '2016-05-24 23:19:33', '2016-05-24 23:19:33'), ('16', 'TEST555511118888', '1', null, '1', '2016-05-24 23:21:45', '2016-05-24 23:21:45'), ('17', 'TEST555511118888', '1', null, '1', '2016-05-25 00:02:33', '2016-05-25 00:02:33'), ('18', 'TEST555511118888', '1', null, '1', '2016-05-25 00:10:58', '2016-05-25 00:10:58'), ('19', 'TEST555511118888', '1', null, '1', '2016-05-25 00:13:45', '2016-05-25 00:13:45'), ('20', 'TEST555511118888', '1', null, '1', '2016-05-25 00:18:29', '2016-05-25 00:18:29'), ('21', 'TEST555511118888', '1', null, '1', '2016-05-25 00:21:46', '2016-05-25 00:21:46'), ('22', 'TEST555511118888', '1', null, '1', '2016-05-25 00:23:21', '2016-05-25 00:23:21'), ('23', 'TEST555511118888', '1', null, '1', '2016-05-25 00:26:09', '2016-05-25 00:26:09'), ('24', 'TEST555511118888', '1', null, '1', '2016-05-25 00:28:29', '2016-05-25 00:28:29'), ('25', 'TEST555511118888', '1', null, '1', '2016-05-25 00:30:28', '2016-05-25 00:30:28'), ('26', 'TEST555511118888', '1', null, '1', '2016-05-25 22:24:33', '2016-05-25 22:24:33'), ('27', 'TEST555511118888', '1', null, '1', '2016-05-25 22:40:43', '2016-05-25 22:40:43'), ('28', 'TEST555511118888', '1', null, '1', '2016-05-25 22:42:41', '2016-05-25 22:42:41'), ('29', 'TEST555511118888', '1', null, '1', '2016-05-25 22:47:04', '2016-05-25 22:47:04'), ('30', 'TEST555511118888', '1', null, '1', '2016-05-25 22:48:14', '2016-05-25 22:48:14'), ('31', 'TEST555511118888', '1', null, '1', '2016-05-25 22:50:53', '2016-05-25 22:50:53'), ('32', 'TEST555511118888', '1', null, '1', '2016-05-25 22:51:28', '2016-05-25 22:51:28'), ('33', 'TEST555511118888', '1', null, '1', '2016-05-25 22:54:39', '2016-05-25 22:54:39'), ('34', 'TEST555511118888', '1', null, '1', '2016-05-25 22:55:23', '2016-05-25 22:55:23'), ('35', 'TEST555511118888', '1', null, '1', '2016-05-25 23:36:38', '2016-05-25 23:36:38'), ('36', 'TEST555511118888', '1', null, '1', '2016-05-25 23:42:45', '2016-05-25 23:42:45'), ('37', 'TEST555511118888', '1', null, '1', '2016-05-25 23:44:35', '2016-05-25 23:44:35'), ('38', 'TEST555511118888', '1', null, '1', '2016-05-25 23:55:27', '2016-05-25 23:55:27'), ('39', 'TEST555511118888', '1', null, '1', '2016-05-26 00:31:23', '2016-05-26 00:31:23'), ('40', 'TEST555511118888', '1', null, '1', '2016-05-26 00:37:47', '2016-05-26 00:37:47'), ('41', 'TEST555511118888', '1', null, '1', '2016-05-26 20:55:00', '2016-05-26 20:55:00'), ('42', 'TEST555511118888', '1', null, '1', '2016-05-26 21:57:34', '2016-05-26 21:57:34'), ('43', 'TEST555511118888', '1', null, '1', '2016-05-26 21:58:24', '2016-05-26 21:58:24'), ('44', 'TEST555511118888', '1', null, '1', '2016-05-26 22:00:05', '2016-05-26 22:00:05'), ('45', 'TEST555511118888', '1', null, '1', '2016-05-26 22:05:39', '2016-05-26 22:05:39'), ('46', 'TEST555511118888', '1', null, '1', '2016-05-26 22:08:11', '2016-05-26 22:08:11'), ('47', 'TEST555511118888', '1', null, '1', '2016-05-26 22:11:34', '2016-05-26 22:11:34'), ('48', 'TEST555511118888', '1', null, '1', '2016-05-26 22:26:39', '2016-05-26 22:26:39'), ('49', 'TEST555511118888', '1', null, '1', '2016-05-26 23:05:22', '2016-05-26 23:05:22'), ('50', 'TEST555511118888', '1', null, '1', '2016-05-26 23:08:15', '2016-05-26 23:08:15'), ('51', 'TEST555511118888', '1', '1shq4r9r', '1', '2016-05-26 23:11:43', '2016-05-26 23:11:43'), ('52', 'TEST555511118888', '1', '1huqhg2j', '1', '2016-05-26 23:13:23', '2016-05-26 23:13:23'), ('53', 'TEST555511118888', '1', '15l40aqq', '1', '2016-05-26 23:16:35', '2016-05-26 23:16:35'), ('54', 'TEST555511118888', '1', '18makf0k', '1', '2016-05-26 23:19:04', '2016-05-26 23:19:04'), ('55', 'TEST555511118888', '1', '18makf0k', '2', '2016-05-26 23:19:55', '2016-05-26 23:19:55'), ('56', 'TEST555511118888', '1', null, '1', '2016-05-27 00:23:29', '2016-05-27 00:23:29'), ('57', 'TEST555511118888', '1', null, '1', '2016-05-27 00:57:48', '2016-05-27 00:57:48'), ('58', 'TEST555511118888', '1', null, '1', '2016-05-27 00:58:38', '2016-05-27 00:58:38'), ('59', 'TEST555511118888', '1', null, '1', '2016-05-27 01:03:15', '2016-05-27 01:03:15'), ('60', 'TEST555511118888', '1', null, '1', '2016-05-27 01:04:44', '2016-05-27 01:04:44'), ('61', 'TEST555511118888', '1', '1kj91qir', '1', '2016-05-27 20:38:01', '2016-05-27 20:38:01'), ('62', 'TEST555511118888', '1', '1kj91qir', '2', '2016-05-27 20:43:18', '2016-05-27 20:43:18'), ('63', 'TEST555511118888', '1', '16j0pxfq', '1', '2016-05-27 21:39:19', '2016-05-27 21:39:19'), ('64', 'TEST555511118888', '1', '1mw1m30p', '1', '2016-05-27 21:43:58', '2016-05-27 21:43:58'), ('65', 'TEST555511118888', '1', '1pmm8byo', '1', '2016-05-27 21:45:49', '2016-05-27 21:45:49'), ('66', 'TEST555511118888', '1', '1pxlziu8', '1', '2016-05-27 21:46:37', '2016-05-27 21:46:37'), ('67', 'TEST555511118888', '1', '1ajx4u5f', '1', '2016-05-27 21:47:04', '2016-05-27 21:47:04'), ('68', 'TEST555511118888', '1', '130x3a16', '1', '2016-05-27 22:38:58', '2016-05-27 22:38:58'), ('69', 'TEST555511118888', '1', null, '1', '2016-05-27 23:22:55', '2016-05-27 23:22:55'), ('70', 'TEST555511118888', '1', null, '1', '2016-05-27 23:37:03', '2016-05-27 23:37:03'), ('71', 'TEST555511118888', '1', '1rychfz8', '1', '2016-05-28 09:31:33', '2016-05-28 09:31:33'), ('72', 'TEST555511118888', '1', null, '1', '2016-05-28 09:47:25', '2016-05-28 09:47:25'), ('73', 'TEST555511118888', '1', '158c2b3w', '1', '2016-05-28 09:47:58', '2016-05-28 09:47:58'), ('74', 'TEST555511118888', '1', '1s3rm9ph', '1', '2016-05-28 09:59:36', '2016-05-28 09:59:36'), ('75', 'TEST555511118888', '1', '1l36yrsc', '1', '2016-05-28 10:00:06', '2016-05-28 10:00:06'), ('76', 'TEST555511118888', '1', '11c8f9s0', '1', '2016-05-28 10:00:30', '2016-05-28 10:00:30'), ('77', 'TEST555511118888', '1', '158c2b3w', '2', '2016-05-28 10:19:39', '2016-05-28 10:19:39'), ('78', 'TEST555511118888', '1', '1rychfz8', '2', '2016-05-28 10:24:12', '2016-05-28 10:24:12'), ('79', 'TEST555511118888', '1', '11bqpsau', '1', '2016-05-28 10:26:54', '2016-05-28 10:26:54'), ('80', 'TEST555511118888', '1', '1rlaoigy', '1', '2016-05-28 10:27:55', '2016-05-28 10:27:55'), ('81', 'TEST555511118888', '1', '1wpkiax3', '1', '2016-05-28 10:28:18', '2016-05-28 10:28:18'), ('82', 'TEST555511118888', '1', '1didhkh3', '1', '2016-05-28 10:28:42', '2016-05-28 10:28:42'), ('83', 'TEST555511118888', '1', '1jcuzyda', '1', '2016-05-28 10:29:04', '2016-05-28 10:29:04'), ('84', 'TEST555511118888', '1', '1o6vsg1m', '1', '2016-05-28 10:29:48', '2016-05-28 10:29:48'), ('85', 'TEST555511118888', '1', '1ts2t8th', '1', '2016-05-28 11:28:56', '2016-05-28 11:28:56'), ('86', 'TEST555511118888', '1', '1ts2t8th', '2', '2016-05-28 11:29:16', '2016-05-28 11:29:16'), ('87', 'TEST555511118888', '1', '1wf1etea', '1', '2016-05-28 16:36:48', '2016-05-28 16:36:48'), ('88', 'TEST555511118888', '1', null, '1', '2016-05-28 17:06:02', '2016-05-28 17:06:02'), ('89', 'TEST555511118888', '1', null, '1', '2016-05-28 17:08:42', '2016-05-28 17:08:42'), ('90', 'TEST555511118888', '1', null, '1', '2016-05-28 17:10:33', '2016-05-28 17:10:33'), ('91', 'TEST555511118888', '1', '1f8qfrax', '1', '2016-05-28 17:21:56', '2016-05-28 17:21:56');
COMMIT;

-- ----------------------------
--  Table structure for `role`
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(64) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `state` tinyint(4) NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色';

-- ----------------------------
--  Table structure for `role_menu`
-- ----------------------------
DROP TABLE IF EXISTS `role_menu`;
CREATE TABLE `role_menu` (
  `id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色菜单表';

-- ----------------------------
--  Table structure for `test`
-- ----------------------------
DROP TABLE IF EXISTS `test`;
CREATE TABLE `test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `test`
-- ----------------------------
BEGIN;
INSERT INTO `test` VALUES ('1', 'huozhanbai'), ('2', 'wendy'), ('3', 'asdf'), ('4', 'gasd'), ('5', ''), ('6', ''), ('7', '');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
