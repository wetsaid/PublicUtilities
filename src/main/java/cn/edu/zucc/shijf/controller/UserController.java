package cn.edu.zucc.shijf.controller;

import cn.edu.zucc.shijf.constant.UserType;
import cn.edu.zucc.shijf.exception.BizException;
import cn.edu.zucc.shijf.model.TUser;
import cn.edu.zucc.shijf.service.UserService;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
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
    public Map<String, Object> login(HttpSession session, TUser reqUser) {
        Map<String, Object> data = new HashMap<String, Object>();

        try {
            TUser user = userService.getUser(reqUser);
            if (!reqUser.getUserPwd().equals(user.getUserPwd())) {
                log.error("密码错误");
                data.put("success", false);
                data.put("reason", "密码错误");
            } else {
                String lastSignIn = new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss").format(new Date(user.getLoginDate()));
                session.setAttribute("lastSignIn", lastSignIn);
                user.setLoginDate(System.currentTimeMillis());
                userService.updateUser(user);

                session.setAttribute("currentUser", user);
                data.put("success", true);
            }
        } catch (BizException e) {
            log.error(e.getMessage());
            data.put("success", false);
            data.put("reason", e.getMessage());
            return data;
        }

        return data;
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> register(HttpSession session, String userCode, String userPwd, String cfmPwd) {
        Map<String, Object> data = new HashMap<String, Object>();

        if (!userPwd.equals(cfmPwd)) {
            data.put("success", false);
            data.put("reason", "两次密码不一致");
            return data;
        }

        TUser user = new TUser();
        user.setUserCode(userCode);
        user.setUserName("用户" + userCode);
        user.setUserPwd(userPwd);
        user.setUserType(UserType.USER.getValue());
        user.setLoginDate(System.currentTimeMillis());
        user.setCreateDate(System.currentTimeMillis());
        try {
            userService.registerUser(user);
        } catch (BizException e) {
            e.printStackTrace();
            log.error(e.getMessage());

            data.put("success", false);
            data.put("reason", e.getMessage());
            return data;
        }

        String lastSignIn = new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss").format(new Date(user.getLoginDate()));
        session.setAttribute("lastSignIn", lastSignIn);
        session.setAttribute("currentUser", user);
        data.put("success", true);
        return data;
    }

    @RequestMapping(value = "/updateProfile", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> updateProfile(HttpSession session, TUser newUser) {
        Map<String, Object> data = new HashMap<String, Object>();

        TUser currentUser = (TUser) session.getAttribute("currentUser");


        userService.updateProfile(currentUser, newUser);


        // 查看 currentUser
        return data;
    }

}
