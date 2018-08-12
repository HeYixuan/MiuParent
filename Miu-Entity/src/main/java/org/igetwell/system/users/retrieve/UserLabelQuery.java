package org.igetwell.system.users.retrieve;

import lombok.Data;

@Data
public class UserLabelQuery {

    /**
     * 用户OPEN_ID
     */
    private String openId;
    /**
     * 标签类型：1兴趣爱好 2个性标签
     */
    private Integer labelType;
}
