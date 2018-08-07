package org.igetwell.web.system.user;

import org.igetwell.common.utils.ResponseEntity;
import org.igetwell.system.users.service.IUserInfoService;
import org.igetwell.system.user.update.UserInfoUpdate;
import org.igetwell.web.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/users")
public class UsersController extends BaseController {

    @Autowired
    private IUserInfoService userInfoService;

    @PostMapping("/updateUserInfo")
    @ResponseBody
    ResponseEntity updateUserInfo(@RequestBody @Validated UserInfoUpdate info){
        return userInfoService.updateUserInfo(info);
    }
}
