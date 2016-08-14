package com.picto.service.impl;

import com.picto.dao.TestDao;
import com.picto.entity.TestEntity;
import com.picto.service.TestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by wujigang on 2016/5/22.
 */
@Service
public class TestServiceImpl implements TestService {
    @Autowired
    private TestDao testDao;

    @Transactional
    public void addTestEntity(TestEntity entity) {
        testDao.addTestEntity(entity);
    }
}
