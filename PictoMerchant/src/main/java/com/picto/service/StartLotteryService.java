package com.picto.service;

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
}
