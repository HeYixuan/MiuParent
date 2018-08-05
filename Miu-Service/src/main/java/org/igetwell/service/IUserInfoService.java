package org.igetwell.service;

import org.igetwell.common.utils.ResponseEntity;
import org.igetwell.user.update.UserInfoUpdate;

public interface IUserInfoService {

    /**
     * 注册时修改用户基础信息
     * @param info
     * @return
     */
    ResponseEntity updateUserInfo(UserInfoUpdate info);
}
