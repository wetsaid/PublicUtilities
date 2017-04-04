package cn.edu.zucc.shijf.service;

import cn.edu.zucc.shijf.exception.BizException;
import cn.edu.zucc.shijf.model.NewsItem;
import cn.edu.zucc.shijf.model.TPublicNews;
import cn.edu.zucc.shijf.model.TUser;

import java.util.Date;
import java.util.List;

/**
 * Created by steven on 2017/3/25.
 */
public interface PublicNewsService {

    void generateNews(TPublicNews publicNews);

    List<NewsItem> getNewsByUser(TUser user) throws BizException;

    int getPendingNewsSize();

    TPublicNews getNewsByNumber(int number) throws BizException;

    void reviewNews(TPublicNews publicNews);

    int[] getQtyByType(Date begin, Date end);
}
