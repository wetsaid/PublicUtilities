package cn.edu.zucc.shijf.controller;

import cn.edu.zucc.shijf.constant.WeatherIcon;
import cn.edu.zucc.shijf.exception.BizException;
import cn.edu.zucc.shijf.model.NewsItem;
import cn.edu.zucc.shijf.model.TPublicNews;
import cn.edu.zucc.shijf.model.TUser;
import cn.edu.zucc.shijf.service.PublicNewsService;
import cn.edu.zucc.shijf.util.HttpRequest;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.Calendar;
import java.util.List;
import java.util.Random;

/**
 * 用于GET方法的Controller
 * <p>
 * Created by steven on 2017/3/28.
 */

@Controller
public class GetController {

    private Logger log = Logger.getLogger(GetController.class);

    @Resource
    private PublicNewsService publicNewsService;

    /**
     * 生成测试数据
     */
    @RequestMapping("/data")
    public String genData() {
        Random random = new Random();
        Calendar cal = Calendar.getInstance();

        TPublicNews news = new TPublicNews();
        news.setUserId(919);
        news.setNewsStatus(1);

        for (int i = 0; i < 1; i++) {
            news.setNewsType(random.nextInt(6) + 1);
            news.setReportTime(System.currentTimeMillis());
            publicNewsService.generateNews(news);
        }

        // 上个月
        cal.add(Calendar.MONTH, -1);
        for (int i = 0; i < 1; i++) {
            news.setNewsType(random.nextInt(6) + 1);
            news.setReportTime(cal.getTime().getTime());
            publicNewsService.generateNews(news);
        }

        // 上两个月
        cal.add(Calendar.MONTH, -1);
        for (int i = 0; i < 1; i++) {
            news.setNewsType(random.nextInt(6) + 1);
            news.setReportTime(cal.getTime().getTime());
            publicNewsService.generateNews(news);
        }

        return "500";
    }

    /**
     * 首页
     *
     * @param session
     * @return
     */
    @RequestMapping("/index")
    public String index(HttpSession session) {

        String weatherData = HttpRequest.getWeather("hangzhou");
        JSONObject jsonObject = JSON.parseObject(weatherData);
        JSONObject weather = jsonObject.getJSONArray("results").getJSONObject(0);

        JSONObject now = weather.getJSONObject("now");
        String temperature = now.getString("temperature");
        session.setAttribute("temperature", temperature);

        int code = now.getIntValue("code");
        String icon = WeatherIcon.getIcon(code);
        session.setAttribute("weatherIcon", icon);

        // 判断用户权限
        TUser currentUser = (TUser) session.getAttribute("currentUser");
        if (currentUser.getUserType() == 1) {
            return "index";
        } else if (currentUser.getUserType() == 2) {
            return "index-user";
        } else {
            session.invalidate();
            return "404";
        }

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

    /**
     * 下载服务站点数据模板
     *
     * @param fileName
     * @param response
     * @return
     */
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
        return null;
    }

    /**
     * 登出
     *
     * @param session
     * @return
     */
    @RequestMapping("/signOut")
    public String signOut(HttpSession session) {
        session.invalidate();
        return "sign-in";
    }

}
