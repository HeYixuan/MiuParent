package org.igetwell.web.system.planet;

import org.igetwell.common.utils.ResponseEntity;
import org.igetwell.system.Pagination;
import org.igetwell.system.planet.dto.PlanetCommentDTO;
import org.igetwell.system.planet.dto.PlanetDTO;
import org.igetwell.system.planet.retrieve.PlanetCommentQuery;
import org.igetwell.system.planet.retrieve.PlanetQuery;
import org.igetwell.system.planet.service.IPlanetService;
import org.igetwell.web.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/planet")
public class PlanetController extends BaseController {

    @Autowired
    private IPlanetService planetService;

    /**
     * 查询星球说列表(分页)
     * @return
     */
    @PostMapping("/planetList")
    public ResponseEntity<Pagination<PlanetDTO>> getList(PlanetQuery query){
        return planetService.getList(query);
    }

    /**
     * 根据星球说ID获取评论列表(分页)
     * @return
     */
    @PostMapping("/planetCommentList")
    public ResponseEntity<Pagination<PlanetCommentDTO>> getList(@RequestBody @Validated PlanetCommentQuery query){
        return planetService.getList(query);
    }
}
