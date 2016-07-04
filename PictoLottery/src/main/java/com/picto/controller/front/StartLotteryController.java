package com.picto.controller.front;

import com.picto.constants.Constants;
import com.picto.dao.MerchantDao;
import com.picto.entity.Merchant;
import com.picto.service.StartLotteryService;
import com.picto.util.WechatUtil;
import org.apache.commons.logging.Log;
import org.apache.log4j.Logger;
import org.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by wujigang on 2016/5/22.
 */
@Controller
public class StartLotteryController {
    private static final Logger logger = Logger.getLogger(StartLotteryController.class);

    @Autowired
    private MerchantDao mechantDao;

    @RequestMapping(value = "/startLottery", method = RequestMethod.GET)
    public String startLottery(@RequestParam("merchantId") Integer merchantId, @RequestParam("code") String code,
                               Model model, HttpServletRequest request) {
        logger.info("进入买单先生页面merchantId=" + merchantId + ",code=" + code);
        Merchant merchant = mechantDao.queryMerchantById(merchantId);

//      model.addAttribute("merchant", merchant);
        model.addAttribute("merchantId", merchantId);
        request.getSession().setAttribute("merchant", merchant);
        model.addAttribute("code", code);
        return "front/startLottery";
    }

}
