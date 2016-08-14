package com.picto.dao;

import com.picto.entity.CouponType;
import com.picto.entity.CouponTypeDiscountRel;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by wujigang on 2016/5/23.
 */
@Repository
public interface CouponTypeDao {
    List<CouponType> queryAllCouponTypes();
    List<CouponType> queryAllCouponTypesByMerchantId(@Param("merchantId") Integer merchantId);
    Integer updateCouponTypeRestNum(CouponType luckyCouponType);
    Integer updateCouponType(CouponType couponType);
    CouponType queryCouponTypeById(@Param("id") Integer id);

    List<CouponType> queryCouponTypeByMerchantId(@Param("merchantId") Integer merchantId);

    void addCouponType(CouponType couponType);

    List<CouponTypeDiscountRel> queryRels(@Param("couponTypeId") Integer couponTypeId);

    void deleteRelByCouponTypeId(@Param("couponTypeId") Integer couponTypeId);

    void deleteById(@Param("id") Integer id);
}
