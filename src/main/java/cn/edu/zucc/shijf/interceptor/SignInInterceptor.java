package cn.edu.zucc.shijf.interceptor;

import cn.edu.zucc.shijf.model.TUser;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Created by steven on 2017/3/28.
 */
public class SignInInterceptor implements HandlerInterceptor {

    /**
     * Handler执行完成之后调用这个方法
     */
    public void afterCompletion(HttpServletRequest request,
                                HttpServletResponse response, Object handler, Exception exc)
            throws Exception {

    }

    /**
     * Handler执行之后，ModelAndView返回之前调用这个方法
     */
    public void postHandle(HttpServletRequest request, HttpServletResponse response,
                           Object handler, ModelAndView modelAndView) throws Exception {
    }

    /**
     * Handler执行之前调用这个方法
     */
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
                             Object handler) throws Exception {
        //获取Session
        HttpSession session = request.getSession();
        TUser currentUser = (TUser) session.getAttribute("currentUser");

        if (currentUser != null) {
            return true;
        }
        //不符合条件的，跳转到登录界面
        request.getRequestDispatcher("sign-in.jsp").forward(request, response);

        return false;
    }

}