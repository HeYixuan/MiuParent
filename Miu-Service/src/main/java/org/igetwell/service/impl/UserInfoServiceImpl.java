package org.igetwell.service.impl;

import lombok.extern.slf4j.Slf4j;
import org.igetwell.common.local.LocalSnowflakeService;
import org.igetwell.common.utils.ResponseEntity;
import org.igetwell.service.IUserInfoService;
import org.igetwell.system.domain.UserInfo;
import org.igetwell.system.mapper.UserInfoMapper;
import org.igetwell.user.update.UserInfoUpdate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.annotation.Validated;

@Slf4j
@Service
public class UserInfoServiceImpl implements IUserInfoService {

    @Autowired
    private UserInfoMapper userInfoMapper;
    @Autowired
    private LocalSnowflakeService snowflakeService;

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
}
