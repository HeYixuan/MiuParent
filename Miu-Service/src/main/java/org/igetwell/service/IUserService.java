package org.igetwell.service;


public interface IUserService {

    /**
     * 微信授权登陆
     * @param code
     */
    void WxAuthorizedLogin(String code);
}
