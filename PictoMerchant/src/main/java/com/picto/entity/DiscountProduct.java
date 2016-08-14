package com.picto.entity;

/**
 * Created by BF100271 on 2016/5/24.
 */
public class DiscountProduct extends BaseEntity {
    private Integer merchantId;
    private String name;
    private String icon;
    private String discount;
    private Boolean isShared;
    private String useMsg;
    private String limitMsg;
    private Integer validity;
    private String storeName;
    private Boolean isSendout;//是否可外发
    private Integer state;
    private Integer relId;//优惠奖项关联id

    public Integer getMerchantId() {
        return merchantId;
    }

    public void setMerchantId(Integer merchantId) {
        this.merchantId = merchantId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
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

    public Integer getValidity() {
        return validity;
    }

    public void setValidity(Integer validity) {
        this.validity = validity;
    }

    public String getStoreName() {
        return storeName;
    }

    public void setStoreName(String storeName) {
        this.storeName = storeName;
    }

    public Boolean getIsSendout() {
        return isSendout;
    }

    public void setIsSendout(Boolean isSendout) {
        this.isSendout = isSendout;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }
    public Integer getRelId() { return relId; }
    public void setRelId(Integer relId) { this.relId = relId; }
}
