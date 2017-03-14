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
@Transactional(rollbackFor = BizException.class)
public class UserServiceImpl implements UserService {

    @Resource
    private TUserMapper userMapper;

    public List<TUser> getAllUsers() {
        return userMapper.selectByExample(null);
    }

    public TUser getUser(TUser user) throws BizException {
        TUserExample example = new TUserExample();
        TUserExample.Criteria criteria = example.createCriteria();
        criteria.andUserNameEqualTo(user.getUserName());

        // 唯一
        List<TUser> users = userMapper.selectByExample(example);
        if (users.isEmpty()) {
            throw new BizException("用户不存在");
        }
        return users.get(0);
    }
}
