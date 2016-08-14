package com.picto.controller;

import com.picto.Test;
import com.picto.dao.TestDao;
import com.picto.entity.TestEntity;
import com.picto.service.TestService;
import com.picto.vo.TestVo;
import com.picto.vo.TestVo1;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by wujigang on 2016/5/22.
 */
@Controller
public class TestController {
    @Autowired
    private TestDao testDao;
    @Autowired
    private TestService testService;

    @RequestMapping("/test")
    public String test(TestVo testVo, TestVo1 testVo1, Model model, HttpServletRequest request) {
        System.out.println(testVo);
        TestEntity t1 = new TestEntity();
        t1.setName(testVo.getName());
        testService.addTestEntity(t1);

        testVo.setName("huozhanbai");
        testVo.setDate(new Date());
        model.addAttribute("testVo", testVo);
        model.addAttribute("testVo1", testVo1);
        List<TestVo> list = new ArrayList<TestVo>();
        list.add(new TestVo(1, "huozhanbai"));
        list.add(new TestVo(2, "abc"));
        list.add(new TestVo(3, "efd"));
        model.addAttribute("list", list);

        List<TestEntity> entities = testDao.queryTest();
        if (null != entities) {
            for (TestEntity entity : entities) {
                list.add(new TestVo(entity.getId(), entity.getName()));
            }
        }

        return "test";
    }

    @RequestMapping(value = "/dealAjax", method = RequestMethod.POST, consumes = "application/json")
    @ResponseBody
    public TestVo dealAjax(@RequestBody TestVo testVo) {
        System.out.println(testVo);
        return new TestVo(5, "huozhanbai");
    }

    @RequestMapping("/toUpload")
    public String toUpload() {
        return "testUpload";
    }

    @RequestMapping("testGif")
    public String testGif() {
        return "testGif";
    }
    @RequestMapping("testGif1")
    public String testGif1() {
        return "testGif1";
    }
}
