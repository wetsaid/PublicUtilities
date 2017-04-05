package cn.edu.zucc.shijf.service;

import cn.edu.zucc.shijf.exception.BizException;
import cn.edu.zucc.shijf.model.TUser;

/**
 * Created by steven on 2017/3/11.
 */
public interface UserService {

    TUser getUser(TUser user) throws BizException;

    void registerUser(TUser user) throws BizException;

    void updateUser(TUser user);

    void updateProfile(TUser currentUser, TUser newUser);
}
