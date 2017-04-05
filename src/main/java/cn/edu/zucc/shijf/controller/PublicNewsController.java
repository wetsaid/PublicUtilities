package cn.edu.zucc.shijf.controller;

import cn.edu.zucc.shijf.constant.NewsStatus;
import cn.edu.zucc.shijf.constant.NewsType;
import cn.edu.zucc.shijf.exception.BizException;
import cn.edu.zucc.shijf.model.TPublicNews;
import cn.edu.zucc.shijf.model.TUser;
import cn.edu.zucc.shijf.service.PublicNewsService;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by steven on 2017/3/24.
 */

@Controller
@RequestMapping("/publicNews")
public class PublicNewsController {

    private Logger log = Logger.getLogger(PublicNewsController.class);

    @Resource
    private PublicNewsService publicNewsService;

    /**
     * 我要爆料
     *
     * @param request
     * @param newsImg
     * @param newsDescription
     * @param newsType
     * @return
     */
    @RequestMapping(value = "/breakTheNews", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> generateNews(HttpServletRequest request, MultipartFile newsImg,
                                            String newsDescription, int newsType) {
        Map<String, Object> data = new HashMap<String, Object>();
        TUser currentUser = (TUser) request.getSession().getAttribute("currentUser");

        TPublicNews publicNews = new TPublicNews();

        // 图片不为空
        if (newsImg != null && !newsImg.isEmpty()) {
            try {
                String rootPath = request.getServletContext().getRealPath("/"); // 获取项目根目录
                File dir = new File(rootPath + "\\publicImg\\");
                if (!dir.exists()) { // 目录不存在则创建
                    dir.mkdir();
                }
                String imgName = "publicImg\\" + currentUser.getUserId() + "_" + newsImg.getOriginalFilename();
                File fileServer = new File(rootPath + "\\publicImg\\" +
                        currentUser.getUserId() + "_" + newsImg.getOriginalFilename());

                // 复制到服务器
                newsImg.transferTo(fileServer);

                publicNews.setImgName(imgName);

            } catch (IOException e) {
                e.printStackTrace();
                log.error(e.getMessage());

                data.put("success", false);
                data.put("reason", e.getMessage());
                return data;
            }
        }

        publicNews.setUserId(currentUser.getUserId());
        publicNews.setReportTime(System.currentTimeMillis());
        publicNews.setNewsDescription(newsDescription);
        publicNews.setNewsType(newsType);
        publicNews.setNewsStatus(NewsStatus.PENDING.getValue());
        publicNewsService.generateNews(publicNews);

        data.put("success", true);

        return data;
    }

    /**
     * 待审核爆料
     *
     * @param session
     * @param page    小于0表示取前一条，大于0表示取下一条，等于0表示取当前
     * @return
     */
    @RequestMapping(value = "/pendingList", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getPendingList(HttpSession session, int page) {
        Map<String, Object> data = new HashMap<String, Object>();

        Integer number;

        number = (Integer) session.getAttribute("page");
        if (number == null) {
            number = 1;
        }
        if (page > 0) {
            ++number;
        } else if (page < 0) {
            --number;
        }

        int size = 0;
        try {
            size = publicNewsService.getPendingNewsSize();
            TPublicNews news = publicNewsService.getNewsByNumber(number);
            session.setAttribute("page", number);
            session.setAttribute("currentNews", news);
            data.put("success", true);
            data.put("news", news);
            data.put("newsType", NewsType.getName(news.getNewsType()));
        } catch (BizException e) {
            log.error(e.getMessage());
            data.put("success", false);
            data.put("reason", e.getMessage());
            data.put("size", size);
            return data;
        }

        return data;
    }

    /**
     * 审核
     *
     * @param session
     * @param isPass
     * @param failReason
     * @return
     */
    @RequestMapping(value = "/reviewANews", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> reviewANews(HttpSession session, boolean isPass, String failReason) {
        Map<String, Object> data = new HashMap<String, Object>();

        TPublicNews publicNews = (TPublicNews) session.getAttribute("currentNews");
        TUser currentUser = (TUser) session.getAttribute("currentUser");

        if (isPass) {
            publicNews.setNewsStatus(NewsStatus.PASSED.getValue());
        } else {
            if ("".equals(failReason) || failReason == null) {
                data.put("success", false);
                data.put("reason", "不通过请说明原因");
                return data;
            }
            publicNews.setNewsStatus(NewsStatus.FAILED.getValue());
            publicNews.setFailReason(failReason);
        }
        publicNews.setReviewUserId(currentUser.getUserId());
        publicNews.setReviewTime(System.currentTimeMillis());

        publicNewsService.reviewNews(publicNews);

        data.put("success", true);
        return data;
    }

    /**
     * 待审核爆料数量，用于首页提示
     *
     * @return
     */
    @RequestMapping(value = "/pendingSize", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getPendingSize() {
        Map<String, Object> data = new HashMap<String, Object>();
        int size = publicNewsService.getPendingNewsSize();
        data.put("size", size);
        return data;
    }

    /**
     * 统计近三个月内的事件发生数据
     *
     * @return
     */
    @RequestMapping(value = "/statistics", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> threeMonthData() {
        Map<String, Object> data = new HashMap<String, Object>();

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date today, last, last2, last3;

        Calendar cal = Calendar.getInstance();
        today = cal.getTime();
        cal.add(Calendar.MONTH, -1); // 取前一个月的同一天
        last = cal.getTime();
        cal.add(Calendar.MONTH, -1);
        last2 = cal.getTime();
        cal.add(Calendar.MONTH, -1);
        last3 = cal.getTime();

        List<String> xCategories = new ArrayList<String>();
        xCategories.add(sdf.format(last3) + " 至 " + sdf.format(last2));
        xCategories.add(sdf.format(last2) + " 至 " + sdf.format(last));
        xCategories.add(sdf.format(last) + " 至 " + sdf.format(today));
        data.put("xCategories", xCategories);

        int[] last3Month = publicNewsService.getQtyByType(last3, last2);
        int[] last2Month = publicNewsService.getQtyByType(last2, last);
        int[] lastMonth = publicNewsService.getQtyByType(last, today);

        List<List<Integer>> types = setTypes(last3Month, last2Month, lastMonth);
        data.put("types", types);

        return data;
    }

    /**
     * 包装数据
     *
     * @param last3Month
     * @param last2Month
     * @param lastMonth
     * @return
     */
    private List<List<Integer>> setTypes(int[] last3Month, int[] last2Month, int[] lastMonth) {
        List<List<Integer>> result = new ArrayList<List<Integer>>();

        List<Integer> cityEnvironment = new ArrayList<Integer>();
        List<Integer> municipalUtilities = new ArrayList<Integer>();
        List<Integer> landscaping = new ArrayList<Integer>();
        List<Integer> streetOrder = new ArrayList<Integer>();
        List<Integer> emergencyIncidents = new ArrayList<Integer>();
        List<Integer> other = new ArrayList<Integer>();

        int[][] table = new int[3][6];
        System.arraycopy(last3Month, 0, table[0], 0, last3Month.length);
        System.arraycopy(last2Month, 0, table[1], 0, last2Month.length);
        System.arraycopy(lastMonth, 0, table[2], 0, lastMonth.length);

        for (int[] t : table) {
            cityEnvironment.add(t[0]);
            municipalUtilities.add(t[1]);
            landscaping.add(t[2]);
            streetOrder.add(t[3]);
            emergencyIncidents.add(t[4]);
            other.add(t[5]);
        }

        result.add(cityEnvironment);
        result.add(municipalUtilities);
        result.add(landscaping);
        result.add(streetOrder);
        result.add(emergencyIncidents);
        result.add(other);

        return result;
    }
}
