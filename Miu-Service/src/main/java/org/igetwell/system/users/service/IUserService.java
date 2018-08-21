package org.igetwell.system.users.service;

import org.igetwell.common.utils.ResponseEntity;
import org.igetwell.system.users.create.MobileUser;

public interface IUserService {

    /**
     * 微信授权登陆
     * @param code
     */
    void WxAuthorizedLogin(String code);


    /**
     * 检测手机号是否重复
     * @param mobile
     * @return
     */
    ResponseEntity checkMobile(String mobile);


    /**
     * 手机号注册用户
     * @param mobileUser
     * @return
     */
    ResponseEntity mobileUser(MobileUser mobileUser);
}
