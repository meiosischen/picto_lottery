package com.picto.service;

import com.picto.entity.CouponType;

/**
 * Created by wujigang on 2016/5/22.
 */
public interface LotteryService {
    /**
     * 生成中奖的奖项
     * @param openid
     * @param merchantId
     * @return
     */
    CouponType lotyCouponType(String openid, Integer merchantId);

    /**
     * 生成未中奖显示的奖项图标
     * @param id
     * @return
     */
    String getUnluckyShowIcons(Integer id);
}
