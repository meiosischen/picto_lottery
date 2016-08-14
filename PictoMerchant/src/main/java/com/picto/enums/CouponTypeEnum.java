package com.picto.enums;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by wujigang on 2016/6/2.
 */
public enum CouponTypeEnum {
    NORMAL(1, "普通奖项"),
    THANKS(2, "谢谢惠顾"),
    NEARBY(3, "周边优惠");

    private Integer code;
    private String name;
    private CouponTypeEnum(Integer code, String name) {
        this.code = code;
        this.name = name;
    }
    public Integer getCode() { return this.code; }
    public String getName() { return this.name; }

    public static String getName(Integer code) {
        for (CouponTypeEnum typeEnum : CouponTypeEnum.values()) {
            if (typeEnum.getCode().equals(code)) {
                return typeEnum.getName();
            }
        }
        return null;
    }
    public static List getCodeAndNames() {
        List result = new ArrayList(2);
        List codes = new ArrayList();
        List names = new ArrayList();
        for (CouponTypeEnum typeEnum : CouponTypeEnum.values()) {
            codes.add(typeEnum.getCode());
            names.add(typeEnum.getName());
        }
        result.add(codes);
        result.add(names);
        return result;
    }
}
