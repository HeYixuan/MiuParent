package org.igetwell.system.dict.service.impl;

import org.igetwell.system.dict.domain.Dictionary;
import org.igetwell.system.dict.dto.DictionaryDTO;
import org.igetwell.system.dict.mapper.DictionaryMapper;
import org.igetwell.system.dict.service.IDictionaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @ClassName: DictionaryService
 * @ProjectName MiuParent
 * @Description: TODO
 * @Author user
 * @Date 2018/12/20 11:24
 * @Version 1.0
 */
@Service
public class DictionaryService implements IDictionaryService {

    @Autowired
    private DictionaryMapper dictionaryMapper;

    @Override
    public DictionaryDTO getByKey(String key) {
        return dictionaryMapper.getByKey(key);
    }

    @Override
    public void insert(String key, String val){
        Dictionary dict = new Dictionary();
        dict.setK(key);
        dict.setV(val);
        dictionaryMapper.insertSelective(dict);
    }
}
