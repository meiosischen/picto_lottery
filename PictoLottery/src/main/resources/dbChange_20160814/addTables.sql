
DROP TABLE IF EXISTS `test`.`operation_record_coupon_type_rel`;
CREATE TABLE  `test`.`operation_record_coupon_type_rel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operation_record_id` int(11) NULL COMMENT 'Operation ID',
  `coupon_type_id` int(11) NULL COMMENT 'Coupon type ID',
  PRIMARY KEY (`ID`),
  constraint `FK_OR_CT_ORID` foreign key (`operation_record_id`) references `operation_record` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  constraint `FK_OR_CT_CTID` foreign key (`coupon_type_id`) references `coupon_type` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `test`.`operation_record_coupon_rel`;
CREATE TABLE  `test`.`operation_record_coupon_rel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operation_record_id` int(11) NULL COMMENT 'Operation ID',
  `coupon_id` int(11) NULL COMMENT 'Coupon ID',
  PRIMARY KEY (`ID`),
  constraint `FK_OR_C_ORID` foreign key (`operation_record_id`)references `operation_record` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  constraint `FK_OR_C_CID` foreign key (`coupon_id`)references `coupon` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
