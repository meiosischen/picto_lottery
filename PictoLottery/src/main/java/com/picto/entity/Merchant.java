package com.picto.entity;

import com.picto.enums.CouponSaveTypeEnum;

/**
 * Created by wujigang on 2016/5/22.
 */
public class Merchant extends BaseEntity {
    private String merchantName;
    private String brand;
    private Integer industryType;
    private String phone;
    private String mobile;
    private String address;
    private Integer volumn;
    private String mainBusiness;
    private String remark;
    private String lotteryLink;
    private String lotteryQrcode;
    private String queryLink;
    private String mainAdvert;
    private String bannerAdvert;
    private String queryAdvert;
    private Integer lotteryChannel;
    private String merchantQrcode;
    private Integer state;
    private Integer saveType;
    private Boolean isValidateOpenid;

    public String getMerchantName() {
        return merchantName;
    }

    public void setMerchantName(String merchantName) {
        this.merchantName = merchantName;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public Integer getIndustryType() {
        return industryType;
    }

    public void setIndustryType(Integer industryType) {
        this.industryType = industryType;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Integer getVolumn() {
        return volumn;
    }

    public void setVolumn(Integer volumn) {
        this.volumn = volumn;
    }

    public String getMainBusiness() {
        return mainBusiness;
    }

    public void setMainBusiness(String mainBusiness) {
        this.mainBusiness = mainBusiness;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getLotteryLink() {
        return lotteryLink;
    }

    public void setLotteryLink(String lotteryLink) {
        this.lotteryLink = lotteryLink;
    }

    public String getLotteryQrcode() {
        return lotteryQrcode;
    }

    public void setLotteryQrcode(String lotteryQrcode) {
        this.lotteryQrcode = lotteryQrcode;
    }

    public String getQueryLink() {
        return queryLink;
    }

    public void setQueryLink(String queryLink) {
        this.queryLink = queryLink;
    }

    public String getMainAdvert() {
        return mainAdvert;
    }

    public void setMainAdvert(String mainAdvert) {
        this.mainAdvert = mainAdvert;
    }

    public String getBannerAdvert() {
        return bannerAdvert;
    }

    public void setBannerAdvert(String bannerAdvert) {
        this.bannerAdvert = bannerAdvert;
    }

    public Integer getLotteryChannel() {
        return lotteryChannel;
    }

    public void setLotteryChannel(Integer lotteryChannel) {
        this.lotteryChannel = lotteryChannel;
    }

    public String getMerchantQrcode() {
        return merchantQrcode;
    }

    public void setMerchantQrcode(String merchantQrcode) {
        this.merchantQrcode = merchantQrcode;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public String getQueryAdvert() {
        return queryAdvert;
    }

    public void setQueryAdvert(String queryAdvert) {
        this.queryAdvert = queryAdvert;
    }

    public Integer getSaveType() {
        return saveType;
    }

    public void setSaveType(Integer saveType) {
        this.saveType = saveType;
    }

    public String getCouponSaveTypeDesc() {
        return CouponSaveTypeEnum.getDescByCode(this.getSaveType());
    }

    public Boolean getIsValidateOpenid() {
        return isValidateOpenid;
    }

    public void setIsValidateOpenid(Boolean validateOpenid) {
        isValidateOpenid = validateOpenid;
    }

    @Override
    public String toString() {
        return "Merchant{" +
                "merchantName='" + merchantName + '\'' +
                ", brand='" + brand + '\'' +
                ", industryType=" + industryType +
                ", phone='" + phone + '\'' +
                ", mobile='" + mobile + '\'' +
                ", address='" + address + '\'' +
                ", volumn=" + volumn +
                ", mainBusiness='" + mainBusiness + '\'' +
                ", remark='" + remark + '\'' +
                ", lotteryLink='" + lotteryLink + '\'' +
                ", lotteryQrcode='" + lotteryQrcode + '\'' +
                ", queryLink='" + queryLink + '\'' +
                ", mainAdvert='" + mainAdvert + '\'' +
                ", bannerAdvert='" + bannerAdvert + '\'' +
                ", queryAdvert='" + queryAdvert + '\'' +
                ", lotteryChannel=" + lotteryChannel +
                ", merchantQrcode='" + merchantQrcode + '\'' +
                ", state=" + state +
                ", saveType=" + saveType +
                ", isValidateOpenid=" + isValidateOpenid +
                '}';
    }
}
