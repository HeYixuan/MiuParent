package org.igetwell.web.system.user;

import org.igetwell.common.utils.ResponseEntity;
import org.igetwell.system.users.create.IDCert;
import org.igetwell.system.users.create.MobileUser;
import org.igetwell.system.users.create.UserImageUpload;
import org.igetwell.system.users.service.IUserInfoService;
import org.igetwell.system.users.service.IUserService;
import org.igetwell.system.users.update.UserInfoUpdate;
import org.igetwell.web.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/users")
public class UsersController extends BaseController {

    @Autowired
    private IUserInfoService userInfoService;

    @Autowired
    private IUserService userService;

    @PostMapping("/updateUserInfo")
    @ResponseBody
    public ResponseEntity updateUserInfo(@RequestBody @Validated UserInfoUpdate info){
        return userInfoService.updateUserInfo(info);
    }


    /**
     * 检测手机号是否重复
     * @param mobile
     * @return
     */
    @PostMapping("/checkMobile")
    @ResponseBody
    public ResponseEntity checkMobile(String mobile){
        return userService.checkMobile(mobile);
    }

    /**
     * 手机号注册
     * @param mobileUser
     * @return
     */
    @PostMapping("/mobileUser")
    @ResponseBody
    public ResponseEntity mobileUser(@RequestBody @Validated MobileUser mobileUser){
        return userService.mobileUser(mobileUser);
    }

    /**
     * 个人实名认证
     * @param cert
     * @return
     */
    @PostMapping("/checkIDCert")
    @ResponseBody
    public ResponseEntity checkIDCert(@RequestBody @Validated IDCert cert){
        return userService.checkIDCert(cert);
    }


    /**
     * 用户相册上传
     * @param imageUpload
     * @return
     */
    @PostMapping("/uploadImage")
    @ResponseBody
    public ResponseEntity uploadImage(@Validated UserImageUpload imageUpload){
        return userInfoService.uploadImage(imageUpload);
    }
}
