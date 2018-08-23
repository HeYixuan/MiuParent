package org.igetwell.system.users.mapper;

import org.igetwell.system.users.domain.UserInfo;
import org.igetwell.system.users.dto.UserInfoDTO;
import tk.mybatis.mapper.common.Mapper;

public interface UserInfoMapper extends Mapper<UserInfo> {

    /**
     * 根据OPEN_ID查询
     * @param openId
     * @return
     */
    UserInfo get(String openId);

    /**
     * 根据OPEN_ID查询
     * @param openId
     * @return
     */
    UserInfoDTO getInfo(String openId);

    /**
     * 更新用户基础信息
     * @param info
     */
    void updateByOpenId(UserInfo info);
}