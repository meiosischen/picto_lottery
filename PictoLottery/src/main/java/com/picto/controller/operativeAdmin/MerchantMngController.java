package com.picto.controller.operativeAdmin;

import com.picto.dao.MerchantDao;
import com.picto.entity.Merchant;
import com.picto.enums.CouponSaveTypeEnum;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by BF100271 on 2016/5/24.
 */
@Controller
@RequestMapping("/admin")
public class MerchantMngController {
    @Autowired
    private MerchantDao merchantDao;

    @RequestMapping("getAllMerchant")
    public String getAllMerchant(@RequestParam(value = "merchantId", required = false) Integer merchantId, Model model) {
        List<Merchant> allMerchants = merchantDao.queryAllMerchants();
        //TODO 查询账户

        List<Merchant> merchants = null;
        if (null != merchantId && 0 != merchantId.intValue()) {
            Merchant merchant = merchantDao.queryMerchantById(merchantId);
            merchants = new ArrayList<Merchant>(1);
            merchants.add(merchant);
            model.addAttribute("selectedMerchantId", merchant.getId());
        } else {
            merchants = allMerchants;
            model.addAttribute("selectedMerchantId", null);
        }
        model.addAttribute("allMerchants", allMerchants);
        model.addAttribute("merchants", merchants);
        return "operativeAdmin/merchantMng";
    }
    
    @RequestMapping("editMerchant")
    public String editMerchant(@RequestParam("merchantId") Integer merchantId, Model model) {
        model.addAttribute("merchant", merchantDao.queryMerchantById(merchantId));
        List list = CouponSaveTypeEnum.getCodeAndDesc();
        model.addAttribute("saveTypeCodes", (List<Integer>) list.get(0));
        model.addAttribute("saveTypeDescs", (List<String>) list.get(1));

        return "operativeAdmin/editMerchant";
    }

    @RequestMapping("updateMerchant")
    public String updateMerchant(Merchant merchant) {
        merchant.setUpdateTime(new Date());
        merchantDao.updateMerchant(merchant);
        return "redirect:/admin/getAllMerchant.do";
    }
}

