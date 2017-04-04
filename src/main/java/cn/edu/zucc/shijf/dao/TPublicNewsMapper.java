package cn.edu.zucc.shijf.dao;

import cn.edu.zucc.shijf.model.TPublicNews;
import cn.edu.zucc.shijf.model.TPublicNewsExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TPublicNewsMapper {
    int countByExample(TPublicNewsExample example);

    int deleteByExample(TPublicNewsExample example);

    int deleteByPrimaryKey(Integer newsId);

    int insert(TPublicNews record);

    int insertSelective(TPublicNews record);

    List<TPublicNews> selectByExample(TPublicNewsExample example);

    TPublicNews selectByPrimaryKey(Integer newsId);

    int updateByExampleSelective(@Param("record") TPublicNews record, @Param("example") TPublicNewsExample example);

    int updateByExample(@Param("record") TPublicNews record, @Param("example") TPublicNewsExample example);

    int updateByPrimaryKeySelective(TPublicNews record);

    int updateByPrimaryKey(TPublicNews record);
}