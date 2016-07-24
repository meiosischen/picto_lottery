package com.picto.service.impl;

import com.picto.constants.Constants;
import com.picto.controller.front.LotteryController;
import com.picto.dao.CouponTypeDao;
import com.picto.dao.OperationRecordDao;
import com.picto.entity.CouponType;
import com.picto.entity.OperationRecord;
import com.picto.enums.CouponTypeEnum;
import com.picto.service.LotteryService;
import com.picto.util.ListUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;
import org.apache.log4j.Logger;

/**
 * Created by wujigang on 2016/5/22.
 */
@Service
public class LotteryServiceImpl implements LotteryService {
	private static final Logger logger = Logger.getLogger(LotteryServiceImpl.class);
	
    @Autowired
    private CouponTypeDao couponTypeDao;
    @Autowired
    private OperationRecordDao operationRecordDao;

    @Transactional
    public CouponType lotyCouponType(String openid, Integer merchantId) {
        //查询所有的奖项
        List<CouponType> couponTypes = couponTypeDao.queryAllCouponTypesByMerchantId(merchantId);
        if (ListUtil.isEmptyList(couponTypes)) {
        	logger.error("No coupon exists in merchant id[" + merchantId + "]");
            return null;
        }

        int totalNums = 0;
        for (CouponType couponType : couponTypes) {
            totalNums += couponType.getTotalNum();
        }
        int[] indexArr = new int[totalNums];
        int start = 0;
        for (int i = 0; i < couponTypes.size(); i++) {
            int couponTypeTotalNum = couponTypes.get(i).getTotalNum();
            for (int j = 0; j < couponTypeTotalNum; j++) {
                indexArr[j + start] = i;
            }
            start += couponTypeTotalNum;
        }

        //随机抽取一个奖项id
        Random random = new Random();
        CouponType luckyCouponType = couponTypes.get(indexArr[random.nextInt(totalNums)]);

        //生成抽奖记录
        Date current = new Date();
        OperationRecord operationRecord = new OperationRecord();
        operationRecord.setOpenid(openid);
        operationRecord.setMerchantId(merchantId);
        operationRecord.setType(Constants.OPERATION_TYPE_LOTTERY);
        operationRecord.setOperationTime(current);
        operationRecord.setCreateTime(current);
        operationRecordDao.addOperationRecord(operationRecord);

        if (CouponTypeEnum.THANKS.getCode().equals(luckyCouponType.getType())) {
        	//是谢谢惠顾或
        	logger.debug("Generated coupon type [" + luckyCouponType.getName() + "]");
        	if(luckyCouponType.getRestNum() > 1) {
        		int restNum = luckyCouponType.getRestNum() - 1;        		
        		luckyCouponType.setRestNum(restNum);
                luckyCouponType.setUpdateTime(new Date());
                couponTypeDao.updateCouponTypeRestNum(luckyCouponType);
        		logger.debug("Coupon type [" + luckyCouponType.getName() + "] has remaining number [" + restNum + "]");
        	} else {
        		logger.debug("Coupon type [" + luckyCouponType.getName() + "] has remaining number [1], must have at least one");
        	}
        	
            return luckyCouponType;
            
        } else if(luckyCouponType.getRestNum() <= 0) {
        	//者剩余数量=0
        	logger.debug("Generated coupon type [" + luckyCouponType.getName() + "], but remaining number is [0]");
        	for(CouponType ct : couponTypes) {
        		if(CouponTypeEnum.THANKS.getCode().equals(ct.getType())) {
        			return ct;
        		}
        	}
        	
        	logger.error("Coupon type of thanks is not configured for merchant id [" + merchantId + "]");
        	return null;
        	
        } else {
            //更新奖项剩余数量-1
        	int restNum = luckyCouponType.getRestNum() - 1;
            luckyCouponType.setRestNum(restNum);
            luckyCouponType.setUpdateTime(new Date());
            couponTypeDao.updateCouponTypeRestNum(luckyCouponType);
            
            logger.debug("Generated coupon type [" + luckyCouponType.getName() + "], remaining number is [" + restNum + "]");
            return luckyCouponType;
        }
    }
    
    public String getUnluckyShowIcons(Integer merchantId) {
        //生成不完全相同的3个图标
        //查询所有的奖项
        List<CouponType> couponTypes = couponTypeDao.queryAllCouponTypesByMerchantId(merchantId);
        if (ListUtil.isEmptyList(couponTypes)) {
            return null;
        }

        List<CouponType> newCouponTypes = new ArrayList<CouponType>();
        for (CouponType couponType : couponTypes) {
            if (!CouponTypeEnum.THANKS.getCode().equals(couponType.getType())) {
                newCouponTypes.add(couponType);
            }
        }

        String[] icons = new String[3];
        int size = newCouponTypes.size();
        Random random = new Random();

        icons[0] = newCouponTypes.get(random.nextInt(size)).getIcon();
        icons[1] = newCouponTypes.get(random.nextInt(size)).getIcon();
        if (!icons[0].equals(icons[1])) {
            icons[2] = newCouponTypes.get(random.nextInt(size)).getIcon();
        } else {
            boolean isSameIcon = true;
            while (isSameIcon) {
                String icon = newCouponTypes.get(random.nextInt(size)).getIcon();
                if (!icon.equals(icons[1])) {
                    isSameIcon = false;
                    icons[2] = icon;
                }
            }
        }

        return icons[0] + "," + icons[1] + "," + icons[2];
    }
}
