package com.picto.service;

/**
 * Created by wujigang on 2016/6/4.
 */
public interface CouponSettingService {
    /**
     * 删除奖项，将会删除奖项与优惠的关联关系
     * @param couponTypeId
     */
    void deleteCouponType(Integer couponTypeId);

    /**
     * 删除优惠产品,将会删除优惠与奖项的关联关系
     * @param discountProductId
     */
    void deleteDiscountProduct(Integer discountProductId);
}
