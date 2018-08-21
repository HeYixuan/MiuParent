package org.igetwell.system.users.service.impl;

import lombok.extern.slf4j.Slf4j;
import org.igetwell.common.enums.HttpStatus;
import org.igetwell.common.enums.LoginType;
import org.igetwell.common.utils.GenerateUtils;
import org.igetwell.common.utils.RedisUtils;
import org.igetwell.common.utils.ResponseEntity;
import org.igetwell.common.utils.WeChatUtils;
import org.igetwell.system.users.create.MobileUser;
import org.igetwell.system.users.service.IUserService;
import org.igetwell.system.users.domain.User;
import org.igetwell.system.users.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

@Slf4j
@Service
public class UserService implements IUserService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private RedisUtils redis;

    /**
     * 微信授权登陆
     * @param code
     */
    @Transactional(rollbackFor = RuntimeException.class)
    public void WxAuthorizedLogin(String code) {
        try {
            if (StringUtils.isEmpty(code)){
                log.error("微信授权登陆异常, code不能为空!");
                return;
            }
            WeChatUtils.getAccessToken(code);
            if (null != WeChatUtils.oauth2Token){
                WeChatUtils.getUserInfo(WeChatUtils.oauth2Token.getAccessToken(), WeChatUtils.oauth2Token.getOpenId());
                if (null != WeChatUtils.WeChatInfo){
                    User user = new User();
                    user.setOpenId(WeChatUtils.WeChatInfo.getOpenId());
                    user.setNickName(WeChatUtils.WeChatInfo.getNickName());
                    user.setAvatar(WeChatUtils.WeChatInfo.getAvatar());
                    user.setLoginType(LoginType.WECHAT.getValue());
                    userMapper.insert(user);
                }
            }
        } catch (Exception e){
            log.error("微信授权登陆异常", e);
            throw new RuntimeException("授权登陆异常", e);
        }

    }

    /**
     * 检测手机号是否重复
     * @param mobile
     * @return
     */
    public ResponseEntity checkMobile(String mobile){
        if (StringUtils.isEmpty(mobile)){
            return new ResponseEntity(HttpStatus.BAD_REQUEST, "手机号不能为空");
        }
        int count = userMapper.checkMobile(mobile);
        if (count > 0){
            return new ResponseEntity(HttpStatus.BAD_REQUEST, "手机号重复");
        }
        return new ResponseEntity();
    }


    /**
     * 手机号注册用户
     * @param mobileUser
     * @return
     */
    @Transactional(rollbackFor = RuntimeException.class)
    public ResponseEntity mobileUser(MobileUser mobileUser){
        if (!"1234".equals(mobileUser.getMessage())){
            return new ResponseEntity(HttpStatus.BAD_REQUEST, "验证码错误");
        }
        User user = new User();
        user.setOpenId(GenerateUtils.create(32));
        user.setMobile(mobileUser.getMobile());
        user.setLoginType(LoginType.WEB_LOGIN.getValue());
        userMapper.insert(user);
        return new ResponseEntity();
    }
}
