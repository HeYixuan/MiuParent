package org.igetwell.system.users.service.impl;

import lombok.extern.slf4j.Slf4j;
import org.igetwell.common.constans.OSSClientContstants;
import org.igetwell.common.enums.HttpStatus;
import org.igetwell.common.utils.*;
import org.igetwell.system.users.create.UserImageUpload;
import org.igetwell.system.users.domain.User;
import org.igetwell.system.users.domain.UserImage;
import org.igetwell.system.users.dto.UserInfoDTO;
import org.igetwell.system.users.mapper.LabelMapper;
import org.igetwell.system.users.mapper.UserImageMapper;
import org.igetwell.system.users.mapper.UserMapper;
import org.igetwell.system.users.retrieve.UserLabelQuery;
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
import java.util.List;

@Slf4j
@Service
public class UserInfoService implements IUserInfoService {

    @Autowired
    private UserMapper userMapper;
    @Autowired
    private UserInfoMapper userInfoMapper;

    @Autowired
    private UserImageMapper userImageMapper;

    @Autowired
    private LabelMapper labelMapper;

    /**
     * 注册时修改用户基础信息
     * @param info
     * @return
     */
    @Transactional(rollbackFor = RuntimeException.class)
    public ResponseEntity updateUserInfo(@Validated UserInfoUpdate info) {
        try {
            String city = BaiduMap.getCity(info.getLocation());
            UserInfo userInfo = new UserInfo();
            userInfo.setOpenId(info.getOpenId());
            userInfo.setHeight(info.getHeight());
            userInfo.setWeight(info.getWeight());
            userInfo.setLocation(city);
            userInfo.setMaritalStatus(info.getMaritalStatus());
            userInfo.setWageStatus(info.getWageStatus());
            userInfoMapper.updateByOpenId(userInfo);
            User user = new User();
            user.setOpenId(info.getOpenId());
            user.setNickName(info.getNickName());
            userMapper.updateByOpenId(user);
            return new ResponseEntity();
        } catch (Exception e){
            log.info("保存用户基础信息异常. ", e);
            throw new RuntimeException("保存用户基础信息异常", e);
        }
    }

    /**
     * 用户相册上传
     * @param imageUpload
     * @return
     */
    @Transactional(rollbackFor = RuntimeException.class)
    public ResponseEntity uploadImage(UserImageUpload imageUpload) {
        if (StringUtils.isEmpty(imageUpload.getOpenId())){
            return new ResponseEntity(HttpStatus.BAD_REQUEST, "OPEN_ID应不为空");
        }

        if (imageUpload.getMultipartFiles() == null && imageUpload.getMultipartFiles().length <= 0){
            return new ResponseEntity(HttpStatus.BAD_REQUEST, "至少上传一个文件");
        }
        if(imageUpload.getMultipartFiles() != null && imageUpload.getMultipartFiles().length > 0){

            String folder = AliyunOss.createFolder(AliyunOss.ossClient(),AliyunOss.BUCKET_NAME, OSSClientContstants.IMG_FOLDER);

            //循环获取file数组中得文件
            for(int i = 0;i<imageUpload.getMultipartFiles().length;i++){
                try {
                    MultipartFile file = imageUpload.getMultipartFiles()[i];
                    String key = AliyunOss.multipartUpload(AliyunOss.ossClient(), AliyunOss.BUCKET_NAME, folder, GenerateUtils.create(30), file.getOriginalFilename(), file.getInputStream(), file.getSize());
                    if (!StringUtils.isEmpty(key)){
                        UserImage image = new UserImage();
                        image.setOpenId(imageUpload.getOpenId());
                        image.setImgUrl(key);
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


    /**
     * 用户基础信息
     * @param openId
     * @return
     */
    public ResponseEntity<UserInfoDTO> getInfo(String openId){
        if (StringUtils.isEmpty(openId)){
            return new ResponseEntity(HttpStatus.BAD_REQUEST, "OPEN_ID应不为空");
        }
        UserInfoDTO dto = userInfoMapper.getInfo(openId);
        if (!StringUtils.isEmpty(dto.getAvatar())){
            String url = AliyunOss.getUrl(AliyunOss.ossClient(), AliyunOss.BUCKET_NAME, dto.getAvatar());
            dto.setAvatar(url);
        }
        Integer age = IDCardUtils.getAgeByIdCard(dto.getIdCard());
        dto.setAge(age);
        UserLabelQuery labelQuery = new UserLabelQuery();
        labelQuery.setOpenId(openId);
        labelQuery.setLabelType(1);
        List<String> movieTags = labelMapper.getLabels(labelQuery);
        labelQuery.setLabelType(2);
        List<String> musicTags = labelMapper.getLabels(labelQuery);
        labelQuery.setLabelType(3);
        List<String> sportTags = labelMapper.getLabels(labelQuery);
        labelQuery.setLabelType(4);
        List<String> foodTags = labelMapper.getLabels(labelQuery);
        labelQuery.setLabelType(5);
        List<String> liveTags = labelMapper.getLabels(labelQuery);

        dto.setMovieTags(movieTags);
        dto.setMusicTags(musicTags);
        dto.setSportTags(sportTags);
        dto.setFoodTags(foodTags);
        dto.setLiveTags(liveTags);
        return new ResponseEntity<UserInfoDTO>(dto);
    }
}
