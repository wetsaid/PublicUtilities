package cn.edu.zucc.shijf.service.impl;

import cn.edu.zucc.shijf.constant.NewsStatus;
import cn.edu.zucc.shijf.dao.TPublicNewsMapper;
import cn.edu.zucc.shijf.exception.BizException;
import cn.edu.zucc.shijf.model.NewsItem;
import cn.edu.zucc.shijf.model.TPublicNews;
import cn.edu.zucc.shijf.model.TPublicNewsExample;
import cn.edu.zucc.shijf.model.TUser;
import cn.edu.zucc.shijf.service.PublicNewsService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by steven on 2017/3/24.
 */

@Service
public class PublicNewsServiceImpl implements PublicNewsService {

    @Resource
    private TPublicNewsMapper publicNewsMapper;

    @Transactional(rollbackFor = Exception.class)
    public void generateNews(TPublicNews publicNews) {
        publicNewsMapper.insert(publicNews);
    }

    public List<NewsItem> getNewsByUser(TUser user) throws BizException {
        TPublicNewsExample example = new TPublicNewsExample();
        TPublicNewsExample.Criteria criteria = example.createCriteria();
        criteria.andUserIdEqualTo(user.getUserId());

        example.setOrderByClause("news_id desc");

        List<TPublicNews> publicNewsList = publicNewsMapper.selectByExample(example);
        if (publicNewsList.isEmpty()) {
            throw new BizException("你还没有爆过料");
        }

        List<NewsItem> newsItemList = new ArrayList<NewsItem>();
        for (TPublicNews publicNews : publicNewsList) {
            NewsItem newsItem = new NewsItem();
            newsItem.setNewsType(publicNews.getNewsType());
            newsItem.setReportTime(publicNews.getReportTime());
            newsItem.setNewsDescription(publicNews.getNewsDescription());
            newsItem.setFailReason(publicNews.getFailReason());
            newsItem.setNewsStatus(publicNews.getNewsStatus());
            newsItemList.add(newsItem);
        }
        return newsItemList;
    }

    public int getPendingNewsSize() {
        TPublicNewsExample example = new TPublicNewsExample();
        TPublicNewsExample.Criteria criteria = example.createCriteria();
        criteria.andNewsStatusEqualTo(NewsStatus.PENDING.getValue());

        List<TPublicNews> pendingNews = publicNewsMapper.selectByExample(example);
        return pendingNews.size();
    }

    public TPublicNews getNewsByNumber(int number) throws BizException {
        TPublicNewsExample example = new TPublicNewsExample();
        TPublicNewsExample.Criteria criteria = example.createCriteria();
        criteria.andNewsStatusEqualTo(NewsStatus.PENDING.getValue());

        List<TPublicNews> pendingNews = publicNewsMapper.selectByExample(example);
        if (number > pendingNews.size()) {
            throw new BizException("没有下一条了");
        }
        if (number < 1) {
            throw new BizException("没有上一条了");
        }
        return pendingNews.get(number - 1);
    }

    @Transactional(rollbackFor = Exception.class)
    public void reviewNews(TPublicNews publicNews) {
        publicNewsMapper.updateByPrimaryKey(publicNews);
    }

    public int[] getQtyByType(Date begin, Date end) {
        TPublicNewsExample example = new TPublicNewsExample();
        TPublicNewsExample.Criteria criteria = example.createCriteria();
        criteria.andReportTimeBetween(begin.getTime(), end.getTime());

        List<TPublicNews> newsList = publicNewsMapper.selectByExample(example);

        int[] types = new int[6];
        for (TPublicNews news : newsList) {
            ++types[news.getNewsType() - 1];
        }

        return types;
    }
}
