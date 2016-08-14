package com.picto.enums;

import java.util.ArrayList;
import java.util.List;

/**
 * 奖券保存方式
 * Created by wujigang on 2016/5/29.
 */
public enum CouponSaveTypeEnum {
    mrPrize(1, "买单先生公众号"),
    merchantWechat(2, "商户公众号"),
    merchantService(3, "商户服务窗");

    private Integer code;
    private String desc;
    private CouponSaveTypeEnum(Integer code, String desc) {
        this.code = code;
        this.desc = desc;
    }

    public Integer getCode() {
        return this.code;
    }
    public String getDesc() {
        return this.desc;
    }
    public static String getDescByCode(Integer code) {
        for (CouponSaveTypeEnum value : CouponSaveTypeEnum.values()) {
            if (value.getCode().equals(code)) {
                return value.getDesc();
            }
        }
        return null;
    }

    public static List getCodeAndDesc() {
        List list = new ArrayList(2);
        List<Integer> codes = new ArrayList<Integer>();
        List<String> descs = new ArrayList<String>();
        for (CouponSaveTypeEnum value : CouponSaveTypeEnum.values()) {
            codes.add(value.getCode());
            descs.add(value.getDesc());
        }
        list.add(codes);
        list.add(descs);
        return list;
    }
}
