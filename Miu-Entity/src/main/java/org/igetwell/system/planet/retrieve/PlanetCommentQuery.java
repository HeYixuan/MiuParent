package org.igetwell.system.planet.retrieve;

import lombok.Data;
import org.igetwell.system.base.Page;

import javax.validation.constraints.NotNull;

@Data
public class PlanetCommentQuery extends Page {

    /**
     * 星球说ID
     */
    @NotNull(message = "星球说ID不能为空")
    private Integer said;
}
