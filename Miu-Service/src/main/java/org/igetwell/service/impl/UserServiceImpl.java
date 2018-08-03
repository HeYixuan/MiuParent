package org.igetwell.service.impl;

import lombok.extern.slf4j.Slf4j;
import org.igetwell.common.constans.LoginType;
import org.igetwell.common.utils.WeChatUtils;
import org.igetwell.service.IUserService;
import org.igetwell.system.domain.User;
import org.igetwell.system.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

@Slf4j
@Service
public class UserServiceImpl implements IUserService {

    @Autowired
    private UserMapper userMapper;

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

}
