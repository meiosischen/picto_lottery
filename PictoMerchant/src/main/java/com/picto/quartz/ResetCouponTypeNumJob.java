package com.picto.quartz;

import com.picto.dao.CouponTypeDao;
import com.picto.entity.CouponType;
import com.picto.util.DateUtil;
import com.picto.util.ListUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;

/**
 * Created by BF100271 on 2016/6/22.
 */
@Component
public class ResetCouponTypeNumJob {
    @Autowired
    private CouponTypeDao couponTypeDao;

    public void execute() {
        System.out.println("========重置奖项剩余数量任务开始=========");

        Date current = new Date();

        List<CouponType> couponTypes = couponTypeDao.queryAllCouponTypes();
        if (!ListUtil.isEmptyList(couponTypes)) {
            for (CouponType couponType : couponTypes) {
                Integer resetInterval = couponType.getResetInterval();
                if (couponType.getLastResetTime() == null
                        || current.compareTo(DateUtil.addDays(couponType.getLastResetTime(), resetInterval)) > 0) {
                    couponType.setRestNum(couponType.getTotalNum());
                    couponType.setLastResetTime(current);
                    couponType.setUpdateTime(current);
                    couponTypeDao.updateCouponTypeRestNum(couponType);
                }
            }
        }

        System.out.println("========重置奖项剩余数量任务结束=========");
    }
}
