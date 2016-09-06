package com.picto.enums;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by wujigang on 2016/6/3.
 */
public enum CouponResetTimeEnum {
    ONEDAY(1, "1天"),
    THIRDDAY(3, "3天"),
    SEVENDAY(7, "7天"),
    FIFTEENDAY(15, "15天"),
    THIRTYDAY(30, "30天");

    private Integer day;
    private String name;
    private CouponResetTimeEnum(Integer day, String name) {
        this.day = day;
        this.name = name;
    }
    public Integer getDay() { return this.day; }
    public String getName() { return this.name; }
    public static List getDayAndNames() {
        List result = new ArrayList(2);
        List days = new ArrayList();
        List names = new ArrayList();
        for (CouponResetTimeEnum resetTimeEnum : CouponResetTimeEnum.values()) {
            days.add(resetTimeEnum.getDay());
            names.add(resetTimeEnum.getName());
        }
        result.add(days);
        result.add(names);
        return result;
    }
}
