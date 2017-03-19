package cn.edu.zucc.shijf.service.impl;

import cn.edu.zucc.shijf.dao.TUserMapper;
import cn.edu.zucc.shijf.exception.BizException;
import cn.edu.zucc.shijf.model.TUser;
import cn.edu.zucc.shijf.model.TUserExample;
import cn.edu.zucc.shijf.service.UserService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by steven on 2017/3/11.
 */

@Service
public class UserServiceImpl implements UserService {

    @Resource
    private TUserMapper userMapper;

    public List<TUser> getAllUsers() {
        return userMapper.selectByExample(null);
    }

    @Transactional(rollbackFor = Exception.class)
    public TUser getUser(TUser user) throws BizException {
        TUserExample example = new TUserExample();
        TUserExample.Criteria criteria = example.createCriteria();
        criteria.andUserNameEqualTo(user.getUserName());

        // 唯一
        List<TUser> users = userMapper.selectByExample(example);
        if (users.isEmpty()) {
            throw new BizException("用户不存在");
        }
        if (users.size() > 1) {
            throw new BizException("数据异常");
        }
        return users.get(0);
    }

    @Transactional(rollbackFor = Exception.class)
    public void registerUser(TUser user) throws BizException {
        TUserExample example = new TUserExample();
        TUserExample.Criteria criteria = example.createCriteria();
        criteria.andUserNameEqualTo(user.getUserName());

        List<TUser> users = userMapper.selectByExample(example);
        if (!users.isEmpty()) {
            throw new BizException("用户名已存在");
        }

        userMapper.insert(user);

        // TODO 捕捉数据库错误（重复索引）
    }
}
