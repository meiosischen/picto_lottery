package com.picto.service;

import com.picto.entity.Coupon;
import com.picto.entity.DiscountProduct;
import com.picto.entity.Merchant;

import java.util.Date;
import java.util.List;

/**
 * Created by BF100271 on 2016/5/24.
 */
public interface CouponService {
    /**
     * 生成优惠券
     * @param couponTypeId
     * @param discountProduct
     * @param openid
     * @return
     */
    Coupon genCoupon(Integer couponTypeId, DiscountProduct discountProduct, String openid, Merchant merchant);

    /**
     * 查询openid下的所有优惠券，并按失效时间倒序排序
     * @param openId
     * @return
     */
    List<Coupon> queryAllCouponsByOpenid(String openId, Date date);

    /**
     * 查询优惠券
     * @param selectedCouponId
     * @return
     */
    Coupon queryCouponById(Integer selectedCouponId);

    /**
     * 兑换优惠券
     * @param integer
     * @return 兑换失败返回错误信息
     */
    String exchange(Integer integer);

    /**
     * 查询openid在店铺merchantId下的所有优惠券，并按失效时间倒序排序
     * @param merchantId
     * @param openId
     * @param date
     * @return
     */
    List<Coupon> queryAllCouponsByOpenidAndMerId(Integer merchantId, String openId, Date date);
}
