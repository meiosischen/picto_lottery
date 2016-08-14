package com.picto.vo;

import java.util.Date;

/**
 * Created by wujigang on 2016/5/22.
 */
public class TestVo {
    private Integer id;
    private String name;
    private String remark;
    private Date date;

    public TestVo() {}
    public TestVo(Integer id, String name) {
        this.id = id;
        this.name = name;
    }
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Integer getId() {

        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    @Override
    public String toString() {
        return "TestVo{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", date=" + date +
                '}';
    }
}
