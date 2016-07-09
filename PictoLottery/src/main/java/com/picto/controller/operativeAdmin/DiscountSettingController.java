package com.picto.controller.operativeAdmin;

import com.picto.dao.CouponTypeDao;
import com.picto.dao.DiscountProductDao;
import com.picto.dao.MerchantDao;
import com.picto.entity.CouponType;
import com.picto.entity.CouponTypeDiscountRel;
import com.picto.entity.DiscountProduct;
import com.picto.entity.Merchant;
import com.picto.service.CouponSettingService;
import com.picto.util.CouponUtil;
import com.picto.util.ListUtil;
import com.picto.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.*;

/**
 * Created by wujigang on 2016/6/4.
 */
@Controller
@RequestMapping("/admin")
public class DiscountSettingController {
    @Autowired
    private MerchantDao merchantDao;
    @Autowired
    private DiscountProductDao discountProductDao;
    @Autowired
    private CouponSettingService couponSettingService;
    @Autowired
    private CouponTypeDao couponTypeDao;

    @RequestMapping("getAllDiscounts")
    public String getAllDiscounts(@RequestParam(value = "merchantId", required = false) Integer merchantId, Model model) {
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

        List<DiscountProduct> discountProducts = new ArrayList<DiscountProduct>();
        if (merchant != null) {
            discountProducts = discountProductDao.queryDiscountByMerchantId(merchant.getId());
        } else {
            discountProducts = discountProductDao.queryAllDiscounts();
        }

        model.addAttribute("discountProducts", discountProducts);

        return "operativeAdmin/discountProductList";
    }

    @RequestMapping("toAddDiscountProduct")
    public String toAddDiscountProduct(@RequestParam("merchantId") Integer merchantId, Model model){
        Merchant merchant = merchantDao.queryMerchantById(merchantId);
        model.addAttribute("merchant", merchant);

        return "operativeAdmin/addDiscountProduct";
    }

    @RequestMapping("addDiscountProduct")
    public String addDiscountProduct(DiscountProduct discountProduct) {
        discountProduct.setState(1);
        discountProduct.setCreateTime(new Date());
        
        //设置店铺名称
        if(StringUtil.isBlank(discountProduct.getStoreName())) {
        	String storeName = merchantDao.queryMerchantById(discountProduct.getMerchantId())
        								  .getMerchantName();
        	discountProduct.setStoreName(storeName);
        }
        
        discountProductDao.add(discountProduct);
        return "redirect:/admin/getAllDiscounts.do?merchantId=" + discountProduct.getMerchantId();
    }

    @RequestMapping("deleteDiscount")
    public String deleteDiscount(@RequestParam("discountProductId") Integer discountProductId,
                                 @RequestParam(value = "merchantId",required = false) Integer merchantId) {
        couponSettingService.deleteDiscountProduct(discountProductId);

        if (null != merchantId) {
            return "redirect:/admin/getAllDiscounts.do?merchantId=" + merchantId;
        } else {
            return "redirect:/admin/getAllDiscounts.do";
        }
    }

    @RequestMapping("editDiscountProduct")
    public String editDiscountProduct(@RequestParam("discountProductId") Integer discountProductId, Model model) {
        DiscountProduct discountProduct = discountProductDao.queryDiscountById(discountProductId);
        model.addAttribute("discountProduct", discountProduct);

        return "operativeAdmin/editDiscountProduct";
    }


    @RequestMapping("updateDiscountProduct")
    public String updateDiscountProduct(DiscountProduct discountProduct){
        DiscountProduct newDiscount = discountProductDao.queryDiscountById(discountProduct.getId());
        newDiscount.setName(discountProduct.getName());
        newDiscount.setDiscount(discountProduct.getDiscount());
        newDiscount.setIcon(discountProduct.getIcon());
        newDiscount.setUseMsg(discountProduct.getUseMsg());
        newDiscount.setLimitMsg(discountProduct.getLimitMsg());
        newDiscount.setValidity(discountProduct.getValidity());
        newDiscount.setIsShared(CouponUtil.getBooleanValue(discountProduct.getIsShared()));
        newDiscount.setIsSendout(CouponUtil.getBooleanValue(discountProduct.getIsSendout()));
        newDiscount.setUpdateTime(new Date());
        discountProductDao.updateDiscount(newDiscount);

        return "redirect:/admin/getAllDiscounts.do?merchantId=" + newDiscount.getMerchantId();
    }

    @RequestMapping("toBindDiscount")
    public String toBindDiscount(@RequestParam("couponTypeId") Integer couponTypeId, @RequestParam("isSelfMerchant") Boolean isSelfMerchant,
                                 Model model) {
        CouponType couponType = couponTypeDao.queryCouponTypeById(couponTypeId);
        Integer merchantId = couponType.getMerchantId();
        Merchant selfMerchant = merchantDao.queryMerchantById(merchantId);

        model.addAttribute("couponType", couponType);
        model.addAttribute("isSelfMerchant", isSelfMerchant);
        model.addAttribute("selfMerchantName", selfMerchant.getMerchantName());

        List<DiscountProduct> hadDiscounts = discountProductDao.queryDiscountByCouponTypeId(couponTypeId);
        model.addAttribute("hadDiscounts", hadDiscounts);

        List<DiscountProduct> choiceDiscounts = new ArrayList<DiscountProduct>();
        if (isSelfMerchant) {
            choiceDiscounts.addAll(discountProductDao.queryDiscountByMerchantId(merchantId));
        } else {
            List<DiscountProduct> otherMerDiscounts = discountProductDao.querySendoutDisOtherMerchant(merchantId);
            if (!ListUtil.isEmptyList(hadDiscounts) && !ListUtil.isEmptyList(otherMerDiscounts)) {
                for (DiscountProduct dis : hadDiscounts) {
                    if (otherMerDiscounts.contains(dis)) {
                        otherMerDiscounts.remove(dis);
                    }
                }
            }
            choiceDiscounts.addAll(otherMerDiscounts);

            //设置店铺名称
            Map<Integer, Merchant> merchantMap = new HashMap<Integer, Merchant>();
            if (!ListUtil.isEmptyList(otherMerDiscounts)) {
                List<String> merchantNames = new ArrayList<String>();
                for (DiscountProduct dis : otherMerDiscounts) {
                    Merchant merchant = merchantMap.get(dis.getMerchantId());
                    if (null == merchant) {
                        merchant = merchantDao.queryMerchantById(dis.getMerchantId());
                        merchantMap.put(dis.getMerchantId(), merchant);
                    }
                    merchantNames.add(merchant.getMerchantName());
                }
                model.addAttribute("merchantNames", merchantNames);
            }
        }
        model.addAttribute("choiceDiscounts", choiceDiscounts);
        return "operativeAdmin/bindDiscount";
    }

    @RequestMapping("bindDiscount")
    public String bindDiscount(@RequestParam("discountProductId") Integer discountProductId, @RequestParam("couponTypeId") Integer couponTypeId) {
        CouponType couponType = couponTypeDao.queryCouponTypeById(couponTypeId);
        CouponTypeDiscountRel rel = new CouponTypeDiscountRel();
        rel.setCouponTypeId(couponTypeId);
        rel.setDiscountProductId(discountProductId);
        discountProductDao.addCouponTypeDiscountRel(rel);

        return "redirect:/admin/getAllCouponTypes.do?merchantId=" + couponType.getMerchantId();
    }

    @RequestMapping("deleteRel")
    public String deleteRel(@RequestParam("relId") Integer relId, @RequestParam("isSelfMerchant") Boolean isSelfMerchant) {
        CouponTypeDiscountRel rel = discountProductDao.queryRelByRelId(relId);
        discountProductDao.deleteRel(relId);

        return "redirect:/admin/toBindDiscount.do?couponTypeId=" + rel.getCouponTypeId() + "&isSelfMerchant=" + isSelfMerchant;
    }
}
