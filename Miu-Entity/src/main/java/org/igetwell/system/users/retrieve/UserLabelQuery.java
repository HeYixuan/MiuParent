package org.igetwell.system.users.retrieve;

import lombok.Data;

@Data
public class UserLabelQuery {

    /**
     * 用户OPEN_ID
     */
    private String openId;
    /**
     * 标签类型： 1电影标签 2音乐标签 3运动标签 4美食标签 5个性标签
     */
    private Integer labelType;
}
