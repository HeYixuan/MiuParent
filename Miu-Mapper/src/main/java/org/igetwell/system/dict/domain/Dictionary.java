package org.igetwell.system.dict.domain;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

public class Dictionary {
    /**
     * 主键
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    /**
     * 键
     */
    private String k;

    /**
     * 值
     */
    private String v;

    /**
     * 描述
     */
    private String description;

    /**
     * 获取主键
     *
     * @return id - 主键
     */
    public Integer getId() {
        return id;
    }

    /**
     * 设置主键
     *
     * @param id 主键
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * 获取键
     *
     * @return key - 键
     */
    public String getK() {
        return k;
    }

    /**
     * 设置键
     *
     * @param k 键
     */
    public void setK(String k) {
        this.k = k == null ? null : k.trim();
    }

    /**
     * 获取值
     *
     * @return value - 值
     */
    public String getV() {
        return v;
    }

    /**
     * 设置值
     *
     * @param v 值
     */
    public void setV(String v) {
        this.v = v == null ? null : v.trim();
    }

    /**
     * 获取描述
     *
     * @return description - 描述
     */
    public String getDescription() {
        return description;
    }

    /**
     * 设置描述
     *
     * @param description 描述
     */
    public void setDescription(String description) {
        this.description = description == null ? null : description.trim();
    }
}