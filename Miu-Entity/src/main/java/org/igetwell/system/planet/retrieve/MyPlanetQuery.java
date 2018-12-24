package org.igetwell.system.planet.retrieve;

import lombok.Data;
import org.igetwell.system.base.Page;

import javax.validation.constraints.NotBlank;

@Data
public class MyPlanetQuery extends Page {

    /**
     * 发表星球说用户OPEN_ID
     */
    @NotBlank(message = "OPEN_ID不能为空")
    private String openId;
}
