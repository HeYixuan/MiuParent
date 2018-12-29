package org.igetwell.system.users.service;

import org.igetwell.common.utils.ResponseEntity;
import org.igetwell.system.users.create.IDCert;
import org.igetwell.system.users.create.MobileUser;
import org.igetwell.system.users.create.UserAvatarUpload;

public interface IUserService {

    /**
     * 微信授权登陆
     * @param code
     */
    void wxAuthorized(String code);

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

    /**
     * 个人实名认证
     * @param cert
     * @return
     */
    ResponseEntity authorizedName(IDCert cert);


    /**
     * 用户头像上传
     * @param avatarUpload
     * @return
     */
    ResponseEntity uploadAvatar(UserAvatarUpload avatarUpload);
}
