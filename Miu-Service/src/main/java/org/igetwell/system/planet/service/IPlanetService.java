package org.igetwell.system.planet.service;

import org.igetwell.common.utils.ResponseEntity;
import org.igetwell.system.Pagination;
import org.igetwell.system.planet.dto.MyPlanetDTO;
import org.igetwell.system.planet.dto.MyPlanetDetailDTO;
import org.igetwell.system.planet.dto.PlanetCommentDTO;
import org.igetwell.system.planet.dto.PlanetDTO;
import org.igetwell.system.planet.retrieve.MyPlanetQuery;
import org.igetwell.system.planet.retrieve.PlanetCommentQuery;
import org.igetwell.system.planet.retrieve.PlanetQuery;

public interface IPlanetService {

    /**
     * 查询星球说列表(分页)
     */
    ResponseEntity<Pagination<PlanetDTO>> getList(PlanetQuery query);

    /**
     * 根据星球说ID获取评论列表(分页)
     * @param query
     * @return
     */
    ResponseEntity<Pagination<PlanetCommentDTO>> getList(PlanetCommentQuery query);

    /**
     * 查询我的星球说列表(分页)
     * @return
     */
    ResponseEntity<Pagination<MyPlanetDTO>> getMyPlanet(MyPlanetQuery query);

    /**
     * 根据星球说ID查询星球说
     * @param said
     * @return
     */
    ResponseEntity<MyPlanetDetailDTO> getMyPlanetDetail(Integer said);
}
