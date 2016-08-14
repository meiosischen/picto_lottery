package com.picto.entity;

import com.picto.enums.CouponTypeEnum;

import java.util.Date;

/**
 * Created by wujigang on 2016/5/22.
 */
public class CouponType extends BaseEntity {
    private Integer merchantId;
    private String name;
    private String icon;
    private Integer totalNum;
    private Integer restNum;
    private Boolean isImmediate;
    private Integer resetInterval;
    private Date lastResetTime;
    private Integer version;
    private Integer state;
    private Double percent;
    private Integer type;//奖项类型： 普通奖项 谢谢惠顾 周边优惠
    private String remark;

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

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

    public Integer getTotalNum() {
        return totalNum;
    }

    public void setTotalNum(Integer totalNum) {
        this.totalNum = totalNum;
    }

    public Integer getRestNum() {
        return restNum;
    }

    public void setRestNum(Integer restNum) {
        this.restNum = restNum;
    }

    public Boolean getIsImmediate() {
        return isImmediate;
    }

    public void setIsImmediate(Boolean isImmediate) {
        this.isImmediate = isImmediate;
    }

    public Integer getResetInterval() {
        return resetInterval;
    }

    public void setResetInterval(Integer resetInterval) {
        this.resetInterval = resetInterval;
    }

    public Date getLastResetTime() {
        return lastResetTime;
    }

    public void setLastResetTime(Date lastResetTime) {
        this.lastResetTime = lastResetTime;
    }

    public Integer getVersion() {
        return version;
    }

    public void setVersion(Integer version) {
        this.version = version;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public Double getPercent() {
        return percent;
    }

    public void setPercent(Double percent) {
        this.percent = percent;
    }

    public String getTypeName() {
        return CouponTypeEnum.getName(this.type);
    }

    @Override
    public String toString() {
        return "CouponType{" +
                "merchantId=" + merchantId +
                ", name='" + name + '\'' +
                ", icon='" + icon + '\'' +
                ", totalNum=" + totalNum +
                ", restNum=" + restNum +
                ", isImmediate=" + isImmediate +
                ", resetInterval=" + resetInterval +
                ", lastResetTime=" + lastResetTime +
                ", version=" + version +
                ", state=" + state +
                ", percent=" + percent +
                ", type=" + type +
                ", remark='" + remark + '\'' +
                '}';
    }
}
