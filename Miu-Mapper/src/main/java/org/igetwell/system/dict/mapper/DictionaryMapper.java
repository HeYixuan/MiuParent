package org.igetwell.system.dict.mapper;

import org.igetwell.system.dict.domain.Dictionary;
import org.igetwell.system.dict.dto.DictionaryDTO;
import tk.mybatis.mapper.common.Mapper;

public interface DictionaryMapper extends Mapper<Dictionary> {

    /**
     * 根据key查询value
     * @param key
     * @return
     */
    DictionaryDTO getByKey(String key);
}