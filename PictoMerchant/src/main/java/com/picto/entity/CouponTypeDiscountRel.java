package com.picto.entity;

/**
 * Created by wujigang on 2016/5/28.
 */
public class CouponTypeDiscountRel {
    private Integer id;
    private Integer couponTypeId;
    private Integer discountProductId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getCouponTypeId() {
        return couponTypeId;
    }

    public void setCouponTypeId(Integer couponTypeId) {
        this.couponTypeId = couponTypeId;
    }

    public Integer getDiscountProductId() {
        return discountProductId;
    }

    public void setDiscountProductId(Integer discountProductId) {
        this.discountProductId = discountProductId;
    }
}
