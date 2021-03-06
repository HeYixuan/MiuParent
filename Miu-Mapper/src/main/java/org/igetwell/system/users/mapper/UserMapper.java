package org.igetwell.system.users.mapper;

import org.igetwell.system.users.domain.User;
import tk.mybatis.mapper.common.Mapper;

public interface UserMapper extends Mapper<User> {

    /**
     * 根据OPEN_ID查询
     * @param openId
     * @return
     */
    User get(String openId);

    /**
     * 检测手机号是否重复
     * @param mobile
     * @return
     */
    int checkMobile(String mobile);

    /**
     * 更新用户信息
     * @param user
     */
    void updateByOpenId(User user);
}