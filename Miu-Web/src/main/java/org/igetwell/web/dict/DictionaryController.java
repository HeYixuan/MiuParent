package org.igetwell.web.dict;

import org.igetwell.common.utils.ResponseEntity;
import org.igetwell.system.dict.dto.DictionaryDTO;
import org.igetwell.system.dict.service.IDictionaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @ClassName: DictionaryController
 * @ProjectName MiuParent
 * @Description: TODO
 * @Author user
 * @Date 2018/12/20 11:26
 * @Version 1.0
 */
@RestController
@RequestMapping("/api")
public class DictionaryController {

    @Autowired
    private IDictionaryService dictionaryService;

    @GetMapping("/dict")
    public ResponseEntity getKey(String key){
        DictionaryDTO dictionaryDTO = dictionaryService.getByKey(key);
        String url = String.format(dictionaryDTO.getV(), "EW_N7078276125");
        String url2 = String.format(dictionaryDTO.getV(), "EW_N777777");
        System.err.println(url2);
        return new ResponseEntity(url);
    }

    @GetMapping("/save")
    public ResponseEntity save(){
        dictionaryService.insert("113131","http://192.168.5.204:81/EW_N7078276125/pay");
        return new ResponseEntity();
    }
}
