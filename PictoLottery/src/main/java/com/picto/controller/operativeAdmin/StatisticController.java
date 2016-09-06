package com.picto.controller.operativeAdmin;

import com.picto.constants.Constants;
import com.picto.dao.MerchantDao;
import com.picto.dao.OperationRecordDao;
import com.picto.entity.Merchant;
import com.picto.entity.OperationRecord;
import com.picto.util.DateUtil;
import com.picto.util.ListUtil;
import com.picto.vo.StatisticData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by wendy on 16/6/8.
 */
@Controller
@RequestMapping("/admin")
public class StatisticController {
    @Autowired
    private MerchantDao merchantDao;
    @Autowired
    private OperationRecordDao operationRecordDao;

    @RequestMapping("getReportData")
    public String getReportData(@RequestParam(value = "merchantId", required = false) Integer selectMerchantId, Model model) {
        List<Merchant> allMerchants = merchantDao.queryAllMerchants();
        model.addAttribute("allMerchants", allMerchants);

        List<Merchant> merchants = new ArrayList<Merchant>();
        if (null != selectMerchantId && selectMerchantId > 0) {
            Merchant merchant = merchantDao.queryMerchantById(selectMerchantId);
            model.addAttribute("selectedMerchantId", selectMerchantId);
            merchants.add(merchant);
        } else {
            merchants.addAll(allMerchants);
        }

        List<StatisticData> statisticDatas = new ArrayList<StatisticData>();
        if (!ListUtil.isEmptyList(merchants)) {
            for (Merchant merchant : merchants) {
                StatisticData data = new StatisticData();
                data.setMerchantId(merchant.getId());
                data.setMerchantName(merchant.getMerchantName());
                data.setBrand(merchant.getBrand());
                data.setVolumn(merchant.getVolumn());
                data.setPhone(merchant.getPhone());
                data.setMainAdvert(merchant.getMainAdvert());
                data.setBannerAdvert(merchant.getBannerAdvert());
                data.setRemark(merchant.getRemark());

                //设置本月抽奖数量和上月抽奖数量
                Date current = new Date();
                Date currMonthFirstTime = DateUtil.getMonthFirstTime(current, 0);
                Date currMonthEndTime = DateUtil.getMonthLastTime(current, 0);
                List<OperationRecord> operationRecords = operationRecordDao.queryAllOpersByTime(
                        Constants.OPERATION_TYPE_LOTTERY, merchant.getId(), currMonthFirstTime, currMonthEndTime);
                data.setLotteryCnt(ListUtil.isEmptyList(operationRecords) ? 0 : operationRecords.size());

                List<OperationRecord> lastMonOperations = operationRecordDao.queryAllOpersByTime(Constants.OPERATION_TYPE_LOTTERY,
                        merchant.getId(), DateUtil.getMonthFirstTime(current, -1), DateUtil.getMonthLastTime(current, -1));
                data.setLastMonthCnt(ListUtil.isEmptyList(lastMonOperations) ? 0 : lastMonOperations.size());

                statisticDatas.add(data);
            }
        }

        model.addAttribute("statisticDatas", statisticDatas);
        return "operativeAdmin/getReportData";
    }
}
