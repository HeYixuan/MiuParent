package org.igetwell.system.users.service;

import org.igetwell.common.utils.ResponseEntity;
import org.igetwell.system.users.create.UserImageUpload;
import org.igetwell.system.users.update.UserInfoUpdate;

import java.io.IOException;

public interface IUserInfoService {

    /**
     * 注册时修改用户基础信息
     * @param info
     * @return
     */
    ResponseEntity updateUserInfo(UserInfoUpdate info);

    /**
     * 用户相册上传
     * @param imageUpload
     * @return
     */
    ResponseEntity uploadImage(UserImageUpload imageUpload);
}
