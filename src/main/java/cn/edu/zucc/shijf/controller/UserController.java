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
import javax.servlet.http.HttpServletRequest;
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

    @RequestMapping("/show")
    public String showUsers(Model model) {
        log.info("查询所有用户");
        List<TUser> users = userService.getAllUsers();
        model.addAttribute("userList", users);
        return "showUser";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> login(HttpServletRequest request, TUser reqUser) {
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
            request.getSession().setAttribute("currentUser", user);
            data.put("success", true);
        }

        return data;
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> register(HttpServletRequest request, String userName, String userPwd, String cfmPwd) {
        Map<String, Object> data = new HashMap<String, Object>();

        if (!userPwd.equals(cfmPwd)) {
            data.put("success", false);
            data.put("reason", "两次密码不一致");
            return data;
        }

        TUser user = new TUser();
        user.setUserName(userName);
        user.setUserPwd(userPwd);
        try {
            userService.registerUser(user);
        } catch (BizException e) {
            log.error(e.getMessage());
            data.put("success", false);
            data.put("reason", e.getMessage());
            return data;
        }

        request.getSession().setAttribute("currentUser", user);
        data.put("success", true);
        return data;
    }
}
