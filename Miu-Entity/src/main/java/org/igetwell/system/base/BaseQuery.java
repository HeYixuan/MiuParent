package org.igetwell.system.base;

import lombok.Data;

@Data
public class BaseQuery {
    /**
     * 页码
     */
    private int pageNo = 1;
    /**
     * 页数
     */
    private int pageSize = 20;
}
