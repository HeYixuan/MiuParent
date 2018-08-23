package org.igetwell.system.users.service.impl;

import lombok.extern.slf4j.Slf4j;
import org.igetwell.common.enums.HttpStatus;
import org.igetwell.common.local.LocalSnowflakeService;
import org.igetwell.common.utils.AliyunOss;
import org.igetwell.common.utils.GenerateUtils;
import org.igetwell.common.utils.ResponseEntity;
import org.igetwell.system.users.create.UserImageUpload;
import org.igetwell.system.users.domain.UserImage;
import org.igetwell.system.users.mapper.UserImageMapper;
import org.igetwell.system.users.service.IUserInfoService;
import org.igetwell.system.users.domain.UserInfo;
import org.igetwell.system.users.mapper.UserInfoMapper;
import org.igetwell.system.users.update.UserInfoUpdate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@Slf4j
@Service
public class UserInfoService implements IUserInfoService {

    @Autowired
    private UserInfoMapper userInfoMapper;

    @Autowired
    private UserImageMapper userImageMapper;

    @Autowired
    private LocalSnowflakeService snowflakeService;

    /**
     * 注册时修改用户基础信息
     * @param info
     * @return
     */
    @Transactional(rollbackFor = RuntimeException.class)
    public ResponseEntity updateUserInfo(@Validated UserInfoUpdate info) {
        try {
            String openId = String.valueOf(snowflakeService.nextId());
            UserInfo userInfo = new UserInfo();
            userInfo.setOpenId(openId);
            userInfo.setSchool(info.getSchool());
            userInfo.setCompanyName(info.getCompanyName());
            userInfo.setEducation(info.getEducation());
            userInfo.setHeight(info.getHeight());
            userInfo.setWeight(info.getWeight());
            userInfo.setMaritalStatus(info.getMaritalStatus());
            userInfo.setWageStatus(info.getWageStatus());
            userInfoMapper.insert(userInfo);
            return new ResponseEntity();
        } catch (Exception e){
            log.info("保存UserInfo对象失败. ", e);
            throw new RuntimeException("保存UserInfo对象失败", e);
        }
    }

    /**
     * 用户相册上传
     * @param imageUpload
     * @return
     */
    @Transactional(rollbackFor = RuntimeException.class)
    public ResponseEntity uploadImage(UserImageUpload imageUpload) {
        if(imageUpload.getMultipartFiles() != null && imageUpload.getMultipartFiles().length > 0){
            //循环获取file数组中得文件
            for(int i = 0;i<imageUpload.getMultipartFiles().length;i++){
                try {
                    MultipartFile file = imageUpload.getMultipartFiles()[i];
                    String key = AliyunOss.multipartUpload(AliyunOss.ossClient(), AliyunOss.BUCKET_NAME, GenerateUtils.create(30), file.getOriginalFilename(), file.getInputStream(), file.getSize());
                    if (!StringUtils.isEmpty(key)){
                        String url = AliyunOss.getUrl(AliyunOss.ossClient(), AliyunOss.BUCKET_NAME, key);
                        UserImage image = new UserImage();
                        image.setOpenId(imageUpload.getOpenId());
                        image.setImgUrl(url);
                        userImageMapper.insertSelective(image);
                        return new ResponseEntity();
                    }
                } catch (IOException e) {
                    log.error("上传用户相册异常.", e);
                    throw new RuntimeException("上传用户相册异常", e);
                }
            }
        }
        return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR,"上传用户相册失败");
    }
}
