package com.picto.service;

import com.picto.entity.Coupon;
import com.picto.entity.CouponType;
import com.picto.entity.OperationRecord;

/**
 * Created by wujigang on 2016/5/22.
 */
public interface StartLotteryService {

	/**
     * 判断openid是否已经抽过奖
     * @param openid
     * @param merchantId
     * @return
     */
    boolean judgeHadLottery(String openid, Integer merchantId);
    
    public boolean isOverDailyLimit(String openid, Integer merchantId);
    
    public Coupon latestCouponToday(String openid, Integer merchantId);
    
    public CouponType latestCouponTypeToday(String openid, Integer merchantId);

}
