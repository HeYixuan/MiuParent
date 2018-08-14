package org.igetwell.system.planet.mapper;

import org.igetwell.system.planet.domain.PlanetSaid;
import org.igetwell.system.planet.dto.MyPlanetDTO;
import org.igetwell.system.planet.dto.MyPlanetDetailDTO;
import org.igetwell.system.planet.dto.PlanetDTO;
import org.igetwell.system.planet.retrieve.MyPlanetQuery;
import org.igetwell.system.planet.retrieve.PlanetQuery;
import tk.mybatis.mapper.common.Mapper;

import java.util.Collection;
import java.util.List;

public interface PlanetSaidMapper extends Mapper<PlanetSaid> {

    /**
     * 查询星球说列表(分页)
     * @param query
     * @return
     */
    Collection<PlanetDTO> getList(PlanetQuery query);

    /**
     * 查询我的星球说列表(分页)
     * @param query
     * @return
     */
    Collection<MyPlanetDTO> getMyPlanet(MyPlanetQuery query);

    /**
     * 根据星球说ID查询星球说
     * @param said
     * @return
     */
    MyPlanetDetailDTO getMyPlanetDetail(Integer said);
}