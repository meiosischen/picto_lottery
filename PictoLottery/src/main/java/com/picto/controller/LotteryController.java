package com.picto.controller;

import com.picto.dao.CouponTypeDao;
import com.picto.dao.DiscountProductDao;
import com.picto.entity.Coupon;
import com.picto.entity.CouponType;
import com.picto.entity.DiscountProduct;
import com.picto.entity.Merchant;
import com.picto.service.CouponService;
import com.picto.service.LotteryService;
import com.picto.util.DateUtil;
import com.picto.util.ListUtil;
import com.picto.util.StringUtil;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by wujigang on 2016/5/22.
 */
@Controller
public class LotteryController {
    private static final Logger logger = Logger.getLogger(LotteryController.class);

    @Autowired
    private LotteryService lotteryService;
    @Autowired
    private DiscountProductDao discountProductDao;
    @Autowired
    private CouponService couponService;
    @Autowired
    private CouponTypeDao couponTypeDao;

    @RequestMapping("/lottery")
    public String lottery(@RequestParam("openid") String openid, Model model, HttpServletRequest request) {
        Merchant merchant = (Merchant)request.getSession().getAttribute("merchant");
        //生成中奖的奖项
        CouponType couponType = lotteryService.lotyCouponType(openid, merchant.getId());

        if (null == couponType) {
            //谢谢惠顾生成显示的奖项图标
            model.addAttribute("showIcons", lotteryService.getUnluckyShowIcons(merchant.getId()));
        } else if (!couponType.getIsThanks()) {
            String luckyIcon = couponType.getIcon();
            model.addAttribute("luckyCouponIcon", luckyIcon);
            model.addAttribute("showIcons", luckyIcon + "," + luckyIcon + "," + luckyIcon);
            model.addAttribute("luckyCouponTypeId", couponType.getId());
            model.addAttribute("openid",openid);
        } else {
            //谢谢惠顾生成显示的奖项图标
            model.addAttribute("showIcons", lotteryService.getUnluckyShowIcons(merchant.getId()));
        }

        return "front/lottery";
    }

    @RequestMapping("lotteryFinish")
    public String lotteryFinish(@RequestParam("luckyCouponTypeId") String luckyCouponTypeId, @RequestParam("openid") String openid,
        Model model, HttpServletRequest request) {
        if (StringUtil.isBlank(luckyCouponTypeId)) {
            return "front/thanks";
        } else {
            Merchant merchant = (Merchant) request.getSession().getAttribute("merchant");

            List<DiscountProduct> discountProducts = discountProductDao.queryDiscountByCouponTypeId(Integer.valueOf(luckyCouponTypeId), merchant.getId());
            CouponType couponType = couponTypeDao.queryCouponTypeById(Integer.valueOf(luckyCouponTypeId));
            //奖项下有多个优惠，提供优惠选择
            if (ListUtil.isEmptyList(discountProducts)) {
                logger.info("奖项下[id=" + luckyCouponTypeId + "]没有优惠产品");
                return "front/thanks";
            } else if (discountProducts.size() == 1) {
                //生成优惠券并跳转到优惠券信息页
                DiscountProduct discountProduct = discountProducts.get(0);
                Coupon coupon = couponService.genCoupon(discountProduct, openid);
                model.addAttribute("coupon", coupon);
                String expireDateStr = coupon.getIsImediate() ? DateUtil.formatDate(coupon.getExpiredTime(), "yyyy/MM/dd")
                        : DateUtil.formatDate(coupon.getCreateTime(), "MM/dd") + "-" + DateUtil.formatDate(coupon.getExpiredTime(), "MM/dd");
                model.addAttribute("expireDateStr", expireDateStr);
                return "front/couponInfo";
            } else {
                //奖项下有多个优惠产品，提供选择页面
                model.addAttribute("disproducts", discountProducts);
                model.addAttribute("couponTypeName", couponType.getName());
                model.addAttribute("openid", openid);
                return "front/toChoiceDiscount";
            }
        }
    }

    @RequestMapping("/exchangeCoupon")
    @ResponseBody
    public Map<String, Object> exchangeCoupon(HttpServletRequest request) {
        Map<String, Object> retMap = new HashMap<String, Object>();
        String couponIdStr = request.getParameter("couponId");
        String msg = couponService.exchange(Integer.valueOf(couponIdStr));
        if (!StringUtil.isBlank(msg)) {
            retMap.put("errorMsg", msg);
        }
        return retMap;
    }
}
