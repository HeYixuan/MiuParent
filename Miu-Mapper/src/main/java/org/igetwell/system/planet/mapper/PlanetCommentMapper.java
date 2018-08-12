package org.igetwell.system.planet.mapper;

import org.igetwell.system.planet.domain.PlanetComment;
import org.igetwell.system.planet.dto.PlanetCommentDTO;
import org.igetwell.system.planet.retrieve.PlanetCommentQuery;
import tk.mybatis.mapper.common.Mapper;

import java.util.Collection;
import java.util.List;

public interface PlanetCommentMapper extends Mapper<PlanetComment> {

    /**
     * 根据星球说ID获取评论列表
     * @param query
     * @return
     */
    Collection<PlanetCommentDTO> getList(PlanetCommentQuery query);
}