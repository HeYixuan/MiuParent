package org.igetwell.system.planet.dto;

import lombok.Data;

import java.util.Date;

@Data
public class PlanetCommentDTO {

    /**
     * 评论用户OPEN_ID
     */
    private String openId;

    /**
     * 星球说ID
     */
    private String said;

    /**
     * 评论用户昵称
     */
    private String nickName;

    /**
     * 评论用户父评论用户OPEN_ID
     */
    private String parentId;

    /**
     * 评论用户父评论用户OPEN_ID
     */
    private String parentName;

    /**
     * 评论内容
     */
    private String text;

    /**
     * 评论时间
     */
    private Date createTime;

}
