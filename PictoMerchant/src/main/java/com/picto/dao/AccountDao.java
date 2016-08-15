package com.picto.dao;

import com.picto.entity.Account;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface AccountDao {
    Account queryAccountById(@Param("id") Integer id);
    
    Account queryAccountByAccountName(@Param("accountName") String accountName);

    void addAccount(Account account);
    
    Account queryAccountByNamePwd(@Param("accountName")String accountName, @Param("accountPwd")String accountPwd);
    
    void updateAccount(Account account);
}
