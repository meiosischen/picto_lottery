package com.picto.entity;

import com.picto.util.CouponUtil;

import java.util.Date;

/**
 * Created by BF100271 on 2016/5/24.
 */
public class Coupon extends BaseEntity {
    private Integer discountProductId;
    private Integer merchantId;
    private String name;
    private String serialNumber;
    private String icon;
    private String openid;
    private Boolean isImmediate;
    private String discount;
    private Boolean isShared;
    private String useMsg;
    private String limitMsg;
    private Date expiredTime;
    private String storeName;
    private Integer state;

    public Integer getDiscountProductId() {
        return discountProductId;
    }

    public void setDiscountProductId(Integer discountProductId) {
        this.discountProductId = discountProductId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSerialNumber() {
        return serialNumber;
    }

    public void setSerialNumber(String serialNumber) {
        this.serialNumber = serialNumber;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public String getOpenid() {
        return openid;
    }

    public void setOpenid(String openid) {
        this.openid = openid;
    }

    public Boolean getIsImediate() {
        return isImmediate;
    }

    public void setIsImediate(Boolean isImmediate) {
        this.isImmediate = isImmediate;
    }

    public String getDiscount() {
        return discount;
    }

    public void setDiscount(String discount) {
        this.discount = discount;
    }

    public Boolean getIsShared() {
        return isShared;
    }

    public void setIsShared(Boolean isShared) {
        this.isShared = isShared;
    }

    public String getUseMsg() {
        return useMsg;
    }

    public void setUseMsg(String useMsg) {
        this.useMsg = useMsg;
    }

    public String getLimitMsg() {
        return limitMsg;
    }

    public void setLimitMsg(String limitMsg) {
        this.limitMsg = limitMsg;
    }

    public Date getExpiredTime() {
        return expiredTime;
    }

    public void setExpiredTime(Date expiredTime) {
        this.expiredTime = expiredTime;
    }

    public String getStoreName() {
        return storeName;
    }

    public void setStoreName(String storeName) {
        this.storeName = storeName;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public Integer getMerchantId() {
        return merchantId;
    }

    public void setMerchantId(Integer merchantId) {
        this.merchantId = merchantId;
    }

    public String getExpiredStr() {
        return CouponUtil.getExpiredStr(this);
    }
}
