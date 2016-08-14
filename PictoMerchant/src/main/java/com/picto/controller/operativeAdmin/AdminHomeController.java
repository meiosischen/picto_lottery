package com.picto.controller.operativeAdmin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by wujigang on 2016/5/29.
 */
@Controller
public class AdminHomeController {
    @RequestMapping("adminHome")
    public String toAdminHome() {
        return "operativeAdmin/adminHome";
    }
}
