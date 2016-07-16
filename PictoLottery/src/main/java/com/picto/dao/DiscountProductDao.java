package com.picto.dao;

import com.picto.entity.CouponTypeDiscountRel;
import com.picto.entity.DiscountProduct;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by BF100271 on 2016/5/24.
 */
@Repository
public interface DiscountProductDao {
    List<DiscountProduct> queryDiscountByCouponTypeId(@Param("couponTypeId") Integer couponTypeId);

    DiscountProduct queryDiscountById(@Param("id") Integer id);

    void deleteById(@Param("id") Integer id);

    List<DiscountProduct> queryDiscountByMerchantId(@Param("merchantId") Integer merchantId);

    List<DiscountProduct> queryAllDiscounts();

    void add(DiscountProduct discountProduct);

    void deleteRelByDiscountId(@Param("discountProductId") Integer discountProductId);

    void updateDiscount(DiscountProduct discountProduct);

    List<DiscountProduct> querySendoutDisOtherMerchant(@Param("merchantId") Integer merchantId);

    void addCouponTypeDiscountRel(CouponTypeDiscountRel couponTypeDiscountRel);

    void deleteRel(@Param("relId") Integer relId);

    CouponTypeDiscountRel queryRelByRelId(@Param("relId") Integer relId);
    
    CouponTypeDiscountRel queryRelByCouponTypeAndDiscount(@Param("ctId") Integer ctId, @Param("dpId") Integer dpId);
}
