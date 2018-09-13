package org.igetwell.system.users.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.request.AlipayOpenAuthTokenAppRequest;
import com.alipay.api.request.AlipayUserInfoShareRequest;
import com.alipay.api.response.AlipayOpenAuthTokenAppResponse;
import com.alipay.api.response.AlipayUserInfoShareResponse;
import lombok.extern.slf4j.Slf4j;
import org.igetwell.common.constans.AliPayConstants;
import org.igetwell.common.constans.OSSClientContstants;
import org.igetwell.common.enums.CertType;
import org.igetwell.common.enums.HttpStatus;
import org.igetwell.common.enums.LoginType;
import org.igetwell.common.enums.SexType;
import org.igetwell.common.utils.*;
import org.igetwell.system.users.create.IDCert;
import org.igetwell.system.users.create.MobileUser;
import org.igetwell.system.users.create.UserAvatarUpload;
import org.igetwell.system.users.domain.UserInfo;
import org.igetwell.system.users.mapper.UserInfoMapper;
import org.igetwell.system.users.service.IUserService;
import org.igetwell.system.users.domain.User;
import org.igetwell.system.users.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

import static org.igetwell.common.utils.AliPayUtils.ALIPAY_PUBLIC_KEY;
import static org.igetwell.common.utils.AliPayUtils.APP_ID;
import static org.igetwell.common.utils.AliPayUtils.APP_PRIVATE_KEY;

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
     * 支付宝授权登陆
     * @param code
     */
    public void AliPayAuthorizedLogin(String code){
        try {
            if (StringUtils.isEmpty(code)){
                log.error("支付宝授权登陆异常, code不能为空!");
                return;
            }


            /*//APP授权登陆
            AlipayClient alipayClient = new DefaultAlipayClient(AliPayConstants.GATEWAY, APP_ID, APP_PRIVATE_KEY, "json", "UTF-8", ALIPAY_PUBLIC_KEY, "RSA2");
            AlipaySystemOauthTokenRequest request = new AlipaySystemOauthTokenRequest();
            request.setCode(code);
            request.setGrantType("authorization_code");
            AlipaySystemOauthTokenResponse oauthTokenResponse = alipayClient.execute(request);
            System.out.println(oauthTokenResponse.getAccessToken());
            if (oauthTokenResponse.isSuccess()){
                AlipayUserInfoShareRequest userInfoRequest = new AlipayUserInfoShareRequest();
                AlipayUserInfoShareResponse userInfoShareResponse = alipayClient.execute(userInfoRequest, oauthTokenResponse.getAccessToken());
                if (userInfoShareResponse.isSuccess()){
                    log.info(userInfoShareResponse.getBody());
                }
            }*/

            //第三方授权登陆
            AlipayClient alipayClient = new DefaultAlipayClient(AliPayConstants.GATEWAY, APP_ID, APP_PRIVATE_KEY, "json", "UTF-8", ALIPAY_PUBLIC_KEY, "RSA2");
            AlipayOpenAuthTokenAppRequest request = new AlipayOpenAuthTokenAppRequest();
            JSONObject object = new JSONObject();
            object.put("grant_type","authorization_code");
            object.put("code",code);

            request.setBizContent(object.toString());
            AlipayOpenAuthTokenAppResponse response = alipayClient.execute(request);
            if (response.isSuccess()){
                response.getAppAuthToken();
                response.getUserId();
                AlipayUserInfoShareRequest userInfoRequest = new AlipayUserInfoShareRequest();
                AlipayUserInfoShareResponse userInfoShareResponse = alipayClient.execute(userInfoRequest, response.getAppAuthToken());
                log.error(userInfoShareResponse.toString());
                if (userInfoShareResponse.isSuccess()){
                    log.info(userInfoShareResponse.getBody());
                }

            }


           /* AlipayClient alipayClient = new DefaultAlipayClient(AliPayConstants.GATEWAY, APP_ID, APP_PRIVATE_KEY, "json", "UTF-8", ALIPAY_PUBLIC_KEY, "RSA2");
            AlipayOpenAuthTokenAppRequest request = new AlipayOpenAuthTokenAppRequest();
            JSONObject object = new JSONObject();
            object.put("grant_type","authorization_code");
            object.put("code",code);

            request.setBizContent(object.toString());
            AlipayOpenAuthTokenAppResponse response = alipayClient.execute(request);
            if (response.isSuccess()){
                response.getAppAuthToken();
                response.getUserId();
                AlipayUserInfoShareRequest userInfoRequest = new AlipayUserInfoShareRequest();
                AlipayUserInfoShareResponse userInfoShareResponse = alipayClient.execute(userInfoRequest, response.getAppAuthToken());
                if (userInfoShareResponse.isSuccess()){
                    log.info(userInfoShareResponse.getBody());
                }

            }*/
        } catch (Exception e){
            log.error("支付宝授权登陆异常", e);
            throw new RuntimeException("支付宝授权登陆异常", e);
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
        String sex = IDCardUtils.getGenderByIdCard(cert.getIdCard()); //性别
        String birthDay = IDCardUtils.getBirthByIdCard(cert.getIdCard()); //出生日期
        user.setBirthDay(birthDay);
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


    /**
     * 用户头像上传
     * @param avatarUpload
     * @return
     */
    public ResponseEntity uploadAvatar(UserAvatarUpload avatarUpload){
        if (StringUtils.isEmpty(avatarUpload.getOpenId())){
            return new ResponseEntity(HttpStatus.BAD_REQUEST, "OPEN_ID应不为空");
        }
        if (avatarUpload.getMultipartFile() == null){
            return new ResponseEntity(HttpStatus.BAD_REQUEST, "至少上传一个文件");
        }

        User user = userMapper.get(avatarUpload.getOpenId());
        if (StringUtils.isEmpty(user)){
            return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR, "用户信息查询异常");
        }

        //TODO:如果用户头像不为空,先删除再上传,以免占用OSS空间
        if (!StringUtils.isEmpty(user.getAvatar())){
            AliyunOss.delete(AliyunOss.ossClient(), AliyunOss.BUCKET_NAME, user.getAvatar());
        }

        if(avatarUpload.getMultipartFile() != null){
            try {
                String folder = AliyunOss.createFolder(AliyunOss.ossClient(),AliyunOss.BUCKET_NAME, OSSClientContstants.AVATAR_FOLDER);
                MultipartFile file = avatarUpload.getMultipartFile();
                String key = AliyunOss.multipartUpload(AliyunOss.ossClient(), AliyunOss.BUCKET_NAME, folder, GenerateUtils.create(30), file.getOriginalFilename(), file.getInputStream(), file.getSize());
                if (!StringUtils.isEmpty(key)){
                    user.setOpenId(avatarUpload.getOpenId());
                    user.setAvatar(key);
                    userMapper.updateByOpenId(user);
                    return new ResponseEntity();
                }
            } catch (IOException e) {
                log.error("上传用户头像异常.", e);
                throw new RuntimeException("上传用户头像异常", e);
            }

        }
        return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR,"上传用户头像失败");
    }
}
