package org.igetwell.system.planet.dto;

import lombok.Data;

import java.util.Date;

@Data
public class MyPlanetDetailDTO {

    /**
     * 发表星球说用户OPEN
     */
    private String openId;
    /**
     * 星球说ID
     */
    private Integer said;
    /**
     * 星球说标签
     */
    private String labelName;

    /**
     * 星球说内容
     */
    private String text;

    /**
     * 星球说位置经纬度坐标轴
     */
    private String axis;

    /**
     * 星球说点赞数
     */
    private int likeCount;

    /**
     * 星球说发表时间
     */
    private Date createTime;
}
