package org.igetwell.system.activity.retrieve;

import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

@Data
public class ActivityEnrollQuery {

    /**
     * 用户OPEN_ID
     */
    @NotBlank(message = "OPEN_ID不能为空")
    private String openId;

    /**
     * 活动ID
     */
    @NotNull(message = "活动ID不能为空")
    private Integer activityId;


}
