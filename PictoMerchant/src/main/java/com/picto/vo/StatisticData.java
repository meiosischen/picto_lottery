package com.picto.vo;

/**
 * Created by wendy on 16/6/8.
 */
public class StatisticData {
    private Integer merchantId;
    private String merchantName;
    private String brand;
    private Integer lotteryCnt;
    private Integer lastMonthCnt;
    private Integer volumn;
    private String phone;
    private String mainAdvert;
    private String bannerAdvert;
    private String remark;

    public Integer getMerchantId() {
        return merchantId;
    }

    public void setMerchantId(Integer merchantId) {
        this.merchantId = merchantId;
    }

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

    public Integer getLotteryCnt() {
        return lotteryCnt;
    }

    public void setLotteryCnt(Integer lotteryCnt) {
        this.lotteryCnt = lotteryCnt;
    }

    public Integer getLastMonthCnt() {
        return lastMonthCnt;
    }

    public void setLastMonthCnt(Integer lastMonthCnt) {
        this.lastMonthCnt = lastMonthCnt;
    }

    public Integer getVolumn() {
        return volumn;
    }

    public void setVolumn(Integer volumn) {
        this.volumn = volumn;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
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

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
