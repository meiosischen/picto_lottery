package com.picto.dao;

import com.picto.entity.Coupon;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

/**
 * Created by wujigang on 2016/5/24.
 */
@Repository
public interface CouponDao {
    Coupon queryCouponById(@Param("id") Integer id);

    List<Coupon> queryAllCouponsByOpenid(@Param("openid") String openId, @Param("date")Date date);

    Coupon queryCouponBySerialNumber(@Param("serialNumber") String serialNumber);

    void addCoupon(Coupon coupon);

    void updateCouponExchanged(Coupon coupon);

    List<Coupon> queryAllCouponsByOpenidAndMerId(@Param("merchantId") Integer merchantId, @Param("openId") String openId,
                                                 @Param("date") Date date);
    List<Coupon> queryExchangedCouponsByDiscountProductIdAndTime(@Param("merchantId") Integer merchantId, @Param("discountProductId") Integer discountProductId,
			@Param("state") Integer state, @Param("startTime") Date startTime, @Param("endTime") Date endTime);
}
