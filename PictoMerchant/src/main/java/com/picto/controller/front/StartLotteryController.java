package com.picto.controller.front;


import com.picto.dao.MerchantDao;
import com.picto.entity.Merchant;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;


import javax.servlet.http.HttpServletRequest;


/**
 * Created by wujigang on 2016/5/22.
 */
@Controller
public class StartLotteryController {
    private static final Logger logger = Logger.getLogger(StartLotteryController.class);

    @Autowired
    private MerchantDao merchantDao;

    @RequestMapping(value = "/startLottery", method = RequestMethod.GET)
    public String startLottery(@RequestParam("merchantId") Integer merchantId, @RequestParam("code") String code,
                               Model model, HttpServletRequest request) {
        logger.info("Enter into MR.Prize merchantId=" + merchantId + ",code=" + code);
        Merchant merchant = merchantDao.queryMerchantById(merchantId);

//      model.addAttribute("merchant", merchant);
        model.addAttribute("merchantId", merchantId);
        request.getSession().setAttribute("merchant", merchant);
        model.addAttribute("code", code);
        return "front/startLottery";
    }

}
