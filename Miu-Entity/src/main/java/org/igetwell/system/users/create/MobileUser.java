package org.igetwell.system.users.create;

import lombok.Data;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

/**
 * 手机号注册用户
 */
@Data
public class MobileUser {

    /**
     * 手机号
     */
    @NotBlank(message = "手机号不能为空")
    @Size(min = 11, max = 11, message = "手机号应是11位数字")
    private String mobile;

    /**
     * 注册短信验证码
     */
    @NotBlank(message = "验证码不能为空")
    @Size(min = 4, max = 4, message = "验证码应是4位数字")
    private String message;
}
