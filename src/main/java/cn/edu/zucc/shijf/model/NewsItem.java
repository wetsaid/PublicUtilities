package cn.edu.zucc.shijf.model;

import cn.edu.zucc.shijf.constant.NewsType;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * “我的爆料”表格内的每一条爆料
 *
 * Created by steven on 2017/3/27.
 */
public class NewsItem {

    private SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss");

    private String[] statusInHtml = {
            "<span class=\"status-metro status-disabled\">待审核</span>",
            "<span class=\"status-metro status-active\">&nbsp;&nbsp;通过&nbsp;&nbsp;</span>",
            "<span class=\"status-metro status-suspended\">未通过</span>",
            "<span class=\"status-metro status-active\">已解决</span>"
    };

    private String newsType;

    private String reportTime;

    private String newsDescription;

    private String failReason;

    private String newsStatus;

    public String getNewsType() {
        return newsType;
    }

    public void setNewsType(int newsType) {
        this.newsType = NewsType.getName(newsType);
    }

    public String getReportTime() {
        return reportTime;
    }

    public void setReportTime(Long reportTime) {
        this.reportTime = sdf.format(new Date(reportTime));
    }

    public String getNewsDescription() {
        return newsDescription;
    }

    public void setNewsDescription(String newsDescription) {
        this.newsDescription = newsDescription;
    }

    public String getFailReason() {
        return failReason;
    }

    public void setFailReason(String failReason) {
        this.failReason = failReason;
    }

    public String getNewsStatus() {
        return newsStatus;
    }

    public void setNewsStatus(int newsStatus) {
        this.newsStatus = statusInHtml[newsStatus - 1];
    }
}
