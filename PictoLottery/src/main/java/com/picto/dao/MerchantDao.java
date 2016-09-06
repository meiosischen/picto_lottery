package com.picto.dao;

import com.picto.entity.Merchant;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by wujigang on 2016/5/22.
 */
@Repository
public interface MerchantDao {
    Merchant queryMerchantById(@Param("id") Integer id);

    List<Merchant> queryAllMerchants();

    void updateMerchant(Merchant merchant);

    void addMerchant(Merchant merchant);
}
