package cn.edu.zucc.shijf.controller;

import cn.edu.zucc.shijf.exception.BizException;
import cn.edu.zucc.shijf.model.TUser;
import cn.edu.zucc.shijf.service.UserService;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by steven on 2017/3/11.
 */

@Controller
@RequestMapping("/user")
public class UserController {

    private Logger log = Logger.getLogger(UserController.class);

    @Resource
    private UserService userService;

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> login(TUser reqUser) {
        Map<String, Object> data = new HashMap<String, Object>();

        TUser user;
        try {
            user = userService.getUser(reqUser);
        } catch (BizException e) {
            log.error(e.getMessage());
            data.put("success", false);
            data.put("reason", e.getMessage());
            return data;
        }
        if (!reqUser.getUserPwd().equals(user.getUserPwd())) {
            log.error("密码错误");
            data.put("success", false);
            data.put("reason", "密码错误");
        } else {
            data.put("success", true);
        }

        return data;
    }

    @RequestMapping("/show")
    public String showUsers(Model model) {
        log.info("查询所有用户");
        List<TUser> users = userService.getAllUsers();
        model.addAttribute("userList", users);
        return "showUser";
    }
}
