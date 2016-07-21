package com.picto.controller.operativeAdmin;

import com.picto.dao.CouponTypeDao;
import com.picto.dao.MerchantDao;
import com.picto.entity.Coupon;
import com.picto.entity.CouponType;
import com.picto.entity.DiscountProduct;
import com.picto.entity.Merchant;
import com.picto.enums.CouponResetTimeEnum;
import com.picto.enums.CouponTypeEnum;
import com.picto.service.CouponSettingService;
import com.picto.util.CouponUtil;
import com.picto.util.DateUtil;
import com.picto.util.ListUtil;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.*;

/**
 * Created by BF100271 on 2016/5/24.
 */
@Controller
@RequestMapping("/admin")
public class CouponSettingController {
    private static final Logger logger = Logger.getLogger(CouponSettingController.class);

    @Autowired
    private CouponTypeDao couponTypeDao;
    @Autowired
    private MerchantDao merchantDao;
    @Autowired
    private CouponSettingService couponSettingService;

    @RequestMapping("getAllCouponTypes")
    public String getAllCouponTypes(@RequestParam(value = "merchantId", required = false) Integer merchantId, Model model) {
        List<Merchant> allMerchants = merchantDao.queryAllMerchants();
        //TODO 查询账户
        List<Merchant> merchants = null;
        Merchant merchant = null;
        if (null != merchantId && 0 != merchantId.intValue()) {
            merchant = merchantDao.queryMerchantById(merchantId);
            merchants = new ArrayList<Merchant>(1);
            merchants.add(merchant);
            model.addAttribute("selectedMerchantId", merchant.getId());
        } else {
            merchants = allMerchants;
            model.addAttribute("selectedMerchantId", null);
        }
        model.addAttribute("allMerchants", allMerchants);
        model.addAttribute("merchants", merchants);

        List<CouponType> couponTypes = new ArrayList<CouponType>();
        if (null != merchant) {
            couponTypes = couponTypeDao.queryCouponTypeByMerchantId(merchant.getId());
            if (!ListUtil.isEmptyList(couponTypes)) {
                int total = 0;
                for (CouponType couponType : couponTypes) {
                    total += couponType.getTotalNum();
                }
                double percent = 0.0;
                for (int i = 0; i < couponTypes.size(); i++) {
                    CouponType couponType = couponTypes.get(i);
                    if (i == couponTypes.size() - 1) {
                        couponType.setPercent(Math.round((100 - percent) * 10) / 10.0);
                    } else {
                        double p = Math.round(couponType.getTotalNum() * 1000.0 / total) / 10.0;
                        couponType.setPercent(p);
                        percent += p;
                    }
                }
            }
        } else {
            couponTypes = couponTypeDao.queryAllCouponTypes();
        }
        model.addAttribute("couponTypes", couponTypes);
        return "operativeAdmin/couponTypeList";
    }

    @RequestMapping("toAddCouponType")
    public String toAddCouponType(@RequestParam("merchantId") Integer merchantId, Model model) {
        Merchant merchant = merchantDao.queryMerchantById(merchantId);
        model.addAttribute("merchant", merchant);

        List resetTimes = CouponResetTimeEnum.getDayAndNames();
        model.addAttribute("resetTimeDays", resetTimes.get(0));
        model.addAttribute("resetTimeNames", resetTimes.get(1));

        List types = CouponTypeEnum.getCodeAndNames();
        model.addAttribute("typeCodes", types.get(0));
        model.addAttribute("typeNames", types.get(1));

        return "operativeAdmin/addCouponType";
    }

    @RequestMapping("addCouponType")
    public String addCouponType(CouponType couponType) {
        if (couponType.getIsImmediate() == null) {
            couponType.setIsImmediate(false);
        }
        couponType.setRestNum(couponType.getTotalNum());
        couponType.setCreateTime(new Date());
        couponType.setState(1);
        couponType.setVersion(1);
        couponTypeDao.addCouponType(couponType);
        return "redirect:/admin/getAllCouponTypes.do?merchantId=" + couponType.getMerchantId();
    }

    @RequestMapping("deleteCouponType")
    public String deleteCouponType(@RequestParam("couponTypeId") Integer couponTypeId, @RequestParam("merchantId") Integer merchantId) {
        couponSettingService.deleteCouponType(couponTypeId);
        if (null != merchantId) {
            return "redirect:/admin/getAllCouponTypes.do?merchantId=" + merchantId;
        } else {
            return "redirect:/admin/getAllCouponTypes.do";
        }
    }

    @RequestMapping("editCouponType")
    public String editCouponType(@RequestParam("couponTypeId") Integer couponTypeId, Model model){
        CouponType couponType = couponTypeDao.queryCouponTypeById(couponTypeId);
        model.addAttribute("couponType", couponType);

        Merchant merchant = merchantDao.queryMerchantById(couponType.getMerchantId());
        model.addAttribute("merchant", merchant);

        List resetTimes = CouponResetTimeEnum.getDayAndNames();
        model.addAttribute("resetTimeDays", resetTimes.get(0));
        model.addAttribute("resetTimeNames", resetTimes.get(1));

        List types = CouponTypeEnum.getCodeAndNames();
        model.addAttribute("typeCodes", types.get(0));
        model.addAttribute("typeNames", types.get(1));

        return "operativeAdmin/editCouponType";
    }

    @RequestMapping("updateCouponType")
    public String updateCouponType(CouponType cType) {
        CouponType couponType = couponTypeDao.queryCouponTypeById(cType.getId());
        couponType.setName(cType.getName());
        couponType.setTotalNum(cType.getTotalNum());
        couponType.setRestNum(cType.getTotalNum());
        couponType.setIcon(cType.getIcon());
        couponType.setType(cType.getType());
        couponType.setIsImmediate(CouponUtil.getBooleanValue(cType.getIsImmediate()));
        couponType.setUpdateTime(new Date());
        
        couponType.setResetInterval(cType.getResetInterval());
        if(couponType.getResetInterval() != cType.getResetInterval()) {
        	logger.info("Reset last reset time");
        	
        	//reset time is set at five oclock in the morning (see cron task)
        	Date fiveOclock = DateUtil.addHours(DateUtil.getToday(), 5);
        	Date now = DateUtil.getTodayTime();
        	Date resetTime = now.before(fiveOclock) ? fiveOclock : DateUtil.addHours(DateUtil.addDays(DateUtil.getToday(), 1), 5);
        	couponType.setLastResetTime(resetTime);
        }
        
        couponTypeDao.updateCouponType(couponType);
        return "redirect:/admin/getAllCouponTypes.do?merchantId=" + couponType.getMerchantId();
    }

}
