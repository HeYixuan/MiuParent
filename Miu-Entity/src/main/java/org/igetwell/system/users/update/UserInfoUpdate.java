package org.igetwell.system.users.update;

import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

/**
 * UserInfo修改对象
 */
@Data
public class UserInfoUpdate {
    /**
     * 用户微信OPEN_ID
     */
    @NotBlank(message = "OPEN_ID应不为空")
    private String openId;

    /**
     * 用户昵称
     */
    @NotBlank(message = "用户昵称应不为空")
    private String nickName;

    /**
     * 身高
     */
    @NotNull(message = "身高应不为空")
    private Integer height;

    /**
     * 体重
     */
    @NotNull(message = "体重应不为空")
    private Integer weight;

    @NotBlank(message = "定位城市应不为空")
    private String location;

    /**
     * 婚姻状况:1未婚 2离异
     */
    @NotNull(message = "婚姻状况应不为空")
    private Integer maritalStatus;

    /**
     * 收入状况:1.5K及以下 2.5K-1W 3.1W-3W 4.3W+
     */
    @NotNull(message = "收入状况应不为空")
    private Integer wageStatus;

}
