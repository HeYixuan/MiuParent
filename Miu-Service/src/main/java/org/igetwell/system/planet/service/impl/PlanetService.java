package org.igetwell.system.planet.service.impl;

import com.github.pagehelper.PageHelper;
import org.igetwell.common.utils.ResponseEntity;
import org.igetwell.system.Pagination;
import org.igetwell.system.planet.dto.PlanetCommentDTO;
import org.igetwell.system.planet.dto.PlanetDTO;
import org.igetwell.system.planet.mapper.PlanetCommentMapper;
import org.igetwell.system.planet.mapper.PlanetSaidMapper;
import org.igetwell.system.planet.retrieve.PlanetCommentQuery;
import org.igetwell.system.planet.retrieve.PlanetQuery;
import org.igetwell.system.planet.service.IPlanetService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collection;

@Service
public class PlanetService implements IPlanetService {

    @Autowired
    private PlanetSaidMapper planetSaidMapper;

    @Autowired
    private PlanetCommentMapper planetCommentMapper;

    /**
     * 查询星球说列表(分页)
     */
    public ResponseEntity<Pagination<PlanetDTO>> getList(PlanetQuery query){
        PageHelper.startPage(query.getPageNo(), query.getPageSize());
        Collection<PlanetDTO> dtos = planetSaidMapper.getList(query);
        Pagination<PlanetDTO> pagination = new Pagination<PlanetDTO>(dtos);
        return new ResponseEntity<Pagination<PlanetDTO>>(pagination);
    }

    public ResponseEntity<Pagination<PlanetCommentDTO>> getList(PlanetCommentQuery query){
        PageHelper.startPage(query.getPageNo(), query.getPageSize());
        Collection<PlanetCommentDTO> dtos = planetCommentMapper.getList(query);
        Pagination<PlanetCommentDTO> pagination = new Pagination<PlanetCommentDTO>(dtos);
        return new ResponseEntity<Pagination<PlanetCommentDTO>>(pagination);
    }
}
