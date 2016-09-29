package com.picto.service.impl;

import com.picto.constants.Constants;
import com.picto.dao.CouponDao;
import com.picto.dao.CouponTypeDao;
import com.picto.dao.OperationRecordDao;
import com.picto.entity.Coupon;
import com.picto.entity.CouponType;
import com.picto.entity.OperationRecord;
import com.picto.entity.OperationRecordCouponRel;
import com.picto.entity.OperationRecordCouponTypeRel;
import com.picto.service.StartLotteryService;
import com.picto.util.DateUtil;
import com.picto.util.ListUtil;

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

    @Autowired
    private CouponDao couponDao;

    @Autowired
    private CouponTypeDao couponTypeDao;    
    
    public boolean judgeHadLottery(String openid, Integer merchantId) {
        List<OperationRecord> operationRecords = operationRecordDao.queryOperationRecordsToday(merchantId,
                openid, Constants.OPERATION_TYPE_LOTTERY, DateUtil.getToday());
        
        if (ListUtil.isEmptyList(operationRecords)) {
            return false;
        }
        
        return true;
    }
    
    public boolean isOverDailyLimit(String openid, Integer merchantId) {
    	List<OperationRecord> operationRecords = operationRecordDao.queryOperationRecordsToday(merchantId,
                openid, Constants.OPERATION_TYPE_LOTTERY, DateUtil.getToday());
        
        if(operationRecords.size() >= Constants.OPERATION_LOTTERY_LIMIT) {
        	return true;
        }
        
        return false;
    }
    
    public Coupon latestCouponToday(String openid, Integer merchantId) {
    	OperationRecord or =  operationRecordDao.queryLatestOperTodayByMerchant(merchantId, openid, 
    			Constants.OPERATION_TYPE_LOTTERY, DateUtil.getToday());
    	
    	if(or == null) {
    		return null;
    	}
    	
    	OperationRecordCouponRel orc = operationRecordDao.queryOrCRelByOrId(or.getId());
    	
    	return couponDao.queryCouponById(orc.getCouponId());
    }
    
    public CouponType latestCouponTypeToday(String openid, Integer merchantId) {
    	OperationRecord or =  operationRecordDao.queryLatestOperTodayByMerchant(merchantId, openid, 
    			Constants.OPERATION_TYPE_LOTTERY, DateUtil.getToday());
    	
    	if(or == null) {
    		return null;
    	}
    	
    	OperationRecordCouponTypeRel orct = operationRecordDao.queryOrCtRelByOrId(or.getId());
    	if(orct == null) {
    		return null;
    	}
    	
    	Integer coutponTypeId = orct.getCouponTypeId();
    	return couponTypeDao.queryCouponTypeById(coutponTypeId);
    }
}
