package org.igetwell.system.dict.service;

import org.igetwell.system.dict.dto.DictionaryDTO;

/**
 * @ClassName: IDictionaryService
 * @ProjectName MiuParent
 * @Description: TODO
 * @Author user
 * @Date 2018/12/20 11:22
 * @Version 1.0
 */
public interface IDictionaryService {

    public DictionaryDTO getByKey(String key);

    public void insert(String key, String val);
}
