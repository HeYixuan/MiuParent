package org.igetwell.system.users.create;

import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

@Data
public class IDCert {


    /**
     * 用户OPEN_ID
     */
    @NotBlank(message = "OPEN_ID应不为空")
    private String openId;

    /**
     * 身份证真实名称
     */
    @NotBlank(message = "真实姓名应不为空")
    private String userName;

    /**
     * 身份证号码
     */
    @NotBlank(message = "身份证号应不为空")
    @Size(min = 15, max = 18, message = "身份证号应为15-18位")
    private String idCard;
}
