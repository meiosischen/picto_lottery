
alter table `coupon` add `coupon_type_id` int(11) null;

alter table `coupon`
add constraint `FK_C_CTID` foreign key (`coupon_type_id`)
references `coupon_type` (`id`)
ON DELETE SET NULL
ON UPDATE CASCADE;
