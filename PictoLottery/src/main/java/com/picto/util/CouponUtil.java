package com.picto.util;

import com.picto.constants.Constants;
import com.picto.entity.Coupon;

import java.util.Date;

/**
 * Created by wujigang on 2016/5/27.
 */
public class CouponUtil {
    public static String getExpiredStr(Coupon coupon) {
        if (coupon.getIsImediate()) {
            return "已生效";
        }
        int hours = hoursBetween(new Date(), coupon.getExpiredTime());
        if (hours < 0) {
            return "已过期";
        } else if (hours < 24) {
            return hours + "小时过期";
        } else {
            return hours / 24 + "天过期";
        }
    }

    public static int hoursBetween(Date smdate, Date bdate) {
        long distance = bdate.getTime() - smdate.getTime();
        if (distance > 0) {
            int hourMills = 3600 * 1000;
            return (int)(distance % hourMills == 0 ? distance / hourMills : distance / hourMills + 1);
        }
        return 0;
    }

    public static boolean getBooleanValue(Boolean b){
        return b != null && b;
    }
}
