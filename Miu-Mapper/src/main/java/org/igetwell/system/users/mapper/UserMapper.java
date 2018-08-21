package org.igetwell.system.users.mapper;

import org.igetwell.system.users.domain.User;
import tk.mybatis.mapper.common.Mapper;

public interface UserMapper extends Mapper<User> {

    /**
     * 检测手机号是否重复
     * @param mobile
     * @return
     */
    int checkMobile(String mobile);
}