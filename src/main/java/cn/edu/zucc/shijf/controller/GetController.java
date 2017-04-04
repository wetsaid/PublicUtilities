package cn.edu.zucc.shijf.controller;

import cn.edu.zucc.shijf.exception.BizException;
import cn.edu.zucc.shijf.model.NewsItem;
import cn.edu.zucc.shijf.model.TUser;
import cn.edu.zucc.shijf.service.PublicNewsService;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.List;

/**
 * 用于GET方法的Controller
 *
 * Created by steven on 2017/3/28.
 */

@Controller
public class GetController {

    private Logger log = Logger.getLogger(GetController.class);

    @Resource
    private PublicNewsService publicNewsService;

    @RequestMapping("/index")
    public String index() {
        return "index";
    }

    /**
     * 我的爆料
     *
     * @param session
     * @return
     */
    @RequestMapping("/myNews")
    public ModelAndView getMyNews(HttpSession session) {
        ModelAndView modelAndView = new ModelAndView("my-news");

        try {
            TUser currentUser = (TUser) session.getAttribute("currentUser");
            List<NewsItem> myNews = publicNewsService.getNewsByUser(currentUser);

            modelAndView.addObject("myNews", myNews);
        } catch (BizException e) {
            e.printStackTrace();
            log.error(e.getMessage());
            modelAndView.addObject("errMsg", e.getMessage());
            return modelAndView;
        }

        return modelAndView;
    }


    @RequestMapping("/downloadTemplate")
    public String download(String fileName, HttpServletResponse response) {
        response.setCharacterEncoding("utf-8");
        response.setContentType("multipart/form-data");
        response.setHeader("Content-Disposition", "attachment;fileName=" + fileName);
        try {
            String path = Thread.currentThread().getContextClassLoader()
                    .getResource("").getPath();//这个download目录为啥建立在classes下的
            InputStream inputStream = new FileInputStream(new File(path
                     + fileName));

            OutputStream os = response.getOutputStream();
            byte[] b = new byte[2048];
            int length;
            while ((length = inputStream.read(b)) > 0) {
                os.write(b, 0, length);
            }

            // 这里主要关闭。
            os.close();

            inputStream.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        //  返回值要注意，要不然就出现下面这句错误！
        //java+getOutputStream() has already been called for this response
        return null;
    }

    @RequestMapping("/signOut")
    public String signOut(HttpSession session) {
        session.invalidate();
        return "sign-in";
    }

}
