package com.picto.dao;

import com.picto.entity.CouponTypeDiscountRel;
import com.picto.entity.OperationRecord;
import com.picto.entity.OperationRecordCouponRel;
import com.picto.entity.OperationRecordCouponTypeRel;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

/**
 * Created by wujigang on 2016/5/22.
 */
@Repository
public interface OperationRecordDao {
    List<OperationRecord> queryOperationRecords(@Param("openid") String openId, @Param("type") Integer type);

    List<OperationRecord> queryOperationRecordsToday(@Param("merchantId") Integer merchantId, @Param("openid") String openid,
        @Param("type") Integer type, @Param("today") Date today);

    int addOperationRecord(OperationRecord operationRecord);

    OperationRecord queryLatestOperToday(@Param("openid") String openid, @Param("type") int operationTypeLottery,
                                         @Param("today") Date today);
    
    OperationRecord queryLatestOperTodayByMerchant(@Param("merchantId") Integer merchantId, @Param("openid") String openid, 
    												@Param("type") int operationTypeLottery, @Param("today") Date today);

    void updateSerialNumber(@Param("id") Integer id, @Param("serialNumber") String serialNumber);

    List<OperationRecord> queryAllOpersByTime(@Param("type") Integer type, @Param("merchantId") Integer merchantId,
                                              @Param("startTime") Date startTime, @Param("endTime") Date endTime);
    
    void addOperationRecordCouponTypeRel(OperationRecordCouponTypeRel operationRecordCouponTypeRel);
    
    OperationRecordCouponTypeRel queryOrCtRelByOrId(@Param("orId") Integer orId);
    
    void addOperationRecordCouponRel(OperationRecordCouponRel orcRel);
    
    OperationRecordCouponRel queryOrCRelByOrId(@Param("orId") Integer orId);
}
