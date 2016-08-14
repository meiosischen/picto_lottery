package com.picto.service.impl;

import com.picto.constants.Constants;
import com.picto.dao.OperationRecordDao;
import com.picto.entity.OperationRecord;
import com.picto.service.StartLotteryService;
import com.picto.util.DateUtil;
import com.picto.util.ListUtil;
import org.apache.commons.collections.ListUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by wujigang on 2016/5/22.
 */
@Service
public class StartLotteryServiceImpl implements StartLotteryService {
    @Autowired
    private OperationRecordDao operationRecordDao;

    public boolean judgeHadLottery(String openid, Integer merchantId) {
        List<OperationRecord> operationRecords = operationRecordDao.queryOperationRecordsToday(merchantId,
                openid, Constants.OPERATION_TYPE_LOTTERY, DateUtil.getToday());
        if (ListUtil.isEmptyList(operationRecords)) {
            return false;
        }
        return true;
    }
}
