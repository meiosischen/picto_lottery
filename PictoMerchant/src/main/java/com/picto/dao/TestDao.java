package com.picto.dao;

import com.picto.entity.TestEntity;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by wujigang on 2016/5/22.
 */
@Repository
public interface TestDao {
    List<TestEntity> queryTest();

    void addTestEntity(TestEntity entity);
}
