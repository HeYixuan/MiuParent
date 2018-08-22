package org.igetwell.system.users.service.impl;

import lombok.extern.slf4j.Slf4j;
import org.igetwell.common.enums.CertType;
import org.igetwell.common.enums.HttpStatus;
import org.igetwell.common.enums.LoginType;
import org.igetwell.common.enums.SexType;
import org.igetwell.common.utils.*;
import org.igetwell.system.users.create.IDCert;
import org.igetwell.system.users.create.MobileUser;
import org.igetwell.system.users.domain.UserInfo;
import org.igetwell.system.users.mapper.UserInfoMapper;
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
    private UserInfoMapper userInfoMapper;

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
        String openId = GenerateUtils.create(32);
        user.setOpenId(openId);
        user.setMobile(mobileUser.getMobile());
        user.setLoginType(LoginType.WEB_LOGIN.getValue());
        userMapper.insertSelective(user);
        UserInfo info = new UserInfo();
        info.setOpenId(openId);
        userInfoMapper.insertSelective(info);
        return new ResponseEntity();
    }

    /**
     * 个人实名认证
     * @param cert
     * @return
     */
    @Transactional(rollbackFor = RuntimeException.class)
    public ResponseEntity checkIDCert(IDCert cert){
        UserInfo info = userInfoMapper.get(cert.getOpenId());
        if (StringUtils.isEmpty(info)){
            return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR, "用户基础信息查询异常");
        }
        User user = new User();//TODO:这里只是记录，免得下次用户又需要输入，不然用户体验贼差
        user.setOpenId(cert.getOpenId());
        user.setUserName(cert.getUserName());
        user.setIdCard(cert.getIdCard());
        userMapper.updateByOpenId(user);
        boolean bool = IDCardUtils.isValidatedAllIdcard(cert.getIdCard());
        if (!bool){
            return new ResponseEntity(HttpStatus.BAD_REQUEST, "身份证号码错误");
        }
        String sex = IDCardUtils.getGenderByIdCard(cert.getIdCard());
        if (SexType.M.value().equals(sex)){
            user.setSex(sex);
        }
        if (SexType.F.value().equals(sex)){
            user.setSex(sex);
        }
        userMapper.updateByOpenId(user);
        info.setIdCert(CertType.AUTHORIZED.value());
        userInfoMapper.updateByOpenId(info);
        return new ResponseEntity();
    }
}
