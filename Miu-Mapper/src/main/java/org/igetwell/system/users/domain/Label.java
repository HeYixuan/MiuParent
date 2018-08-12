package org.igetwell.system.users.domain;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

public class Label {
    /**
     * 主键
     */
    @Id
    @Column(name = "ID")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    /**
     * 标签名称
     */
    @Column(name = "LABEL_NAME")
    private String labelName;

    /**
     * 标签类型: 1爱好标签 2兴趣标签
     */
    @Column(name = "LABEL_TYPE")
    private Integer labelType;

    /**
     * 获取主键
     *
     * @return ID - 主键
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
     * 获取标签名称
     *
     * @return LABEL_NAME - 标签名称
     */
    public String getLabelName() {
        return labelName;
    }

    /**
     * 设置标签名称
     *
     * @param labelName 标签名称
     */
    public void setLabelName(String labelName) {
        this.labelName = labelName == null ? null : labelName.trim();
    }

    /**
     * 获取标签类型: 1爱好标签 2兴趣标签
     *
     * @return LABEL_TYPE - 标签类型: 1爱好标签 2兴趣标签
     */
    public Integer getLabelType() {
        return labelType;
    }

    /**
     * 设置标签类型: 1爱好标签 2兴趣标签
     *
     * @param labelType 标签类型: 1爱好标签 2兴趣标签
     */
    public void setLabelType(Integer labelType) {
        this.labelType = labelType;
    }
}