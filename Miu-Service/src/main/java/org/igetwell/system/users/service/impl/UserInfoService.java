package org.igetwell.system.users.service.impl;

import lombok.extern.slf4j.Slf4j;
import org.igetwell.common.local.LocalSnowflakeService;
import org.igetwell.common.utils.AliyunOss;
import org.igetwell.common.utils.GenerateUtils;
import org.igetwell.common.utils.ResponseEntity;
import org.igetwell.system.users.create.UserImageUpload;
import org.igetwell.system.users.service.IUserInfoService;
import org.igetwell.system.users.domain.UserInfo;
import org.igetwell.system.users.mapper.UserInfoMapper;
import org.igetwell.system.users.update.UserInfoUpdate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;

@Slf4j
@Service
public class UserInfoService implements IUserInfoService {

    @Autowired
    private UserInfoMapper userInfoMapper;
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
            //return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }

    /**
     * 用户相册上传
     * @param imageUpload
     * @return
     */
    public ResponseEntity uploadImage(UserImageUpload imageUpload) {
        if(imageUpload.getMultipartFiles() !=null && imageUpload.getMultipartFiles().length > 0){
            //循环获取file数组中得文件
            for(int i = 0;i<imageUpload.getMultipartFiles().length;i++){
                File file = imageUpload.getMultipartFiles()[i];
                //保存文件
                //saveFile(file, path);
                String yyyyMMdd = GenerateUtils.create(30);
                try {
                    AliyunOss.multipartUpload(yyyyMMdd, file, AliyunOss.ossClient(), AliyunOss.BUCKET_NAME);
                } catch (IOException e) {
                    log.error("上传用户相册异常.", e);
                }
            }
        }
        return new ResponseEntity();
    }
}
