package com.picto.service.impl;

import com.picto.dao.CouponTypeDao;
import com.picto.dao.DiscountProductDao;
import com.picto.entity.CouponTypeDiscountRel;
import com.picto.entity.DiscountProduct;
import com.picto.service.CouponSettingService;
import com.picto.util.ListUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by wujigang on 2016/6/4.
 */
@Service
public class CouponSettingServiceImpl implements CouponSettingService {
    @Autowired
    private CouponTypeDao couponTypeDao;
    @Autowired
    private DiscountProductDao discountProductDao;

    @Transactional
    public void deleteCouponType(Integer couponTypeId) {
        couponTypeDao.deleteRelByCouponTypeId(couponTypeId);

        couponTypeDao.deleteById(couponTypeId);
    }

    public void deleteDiscountProduct(Integer discountProductId) {
        discountProductDao.deleteRelByDiscountId(discountProductId);
        discountProductDao.deleteById(discountProductId);
    }
}
