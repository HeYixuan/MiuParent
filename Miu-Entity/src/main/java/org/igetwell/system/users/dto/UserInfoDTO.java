package org.igetwell.system.users.dto;

import lombok.Data;

import java.util.List;

@Data
public class UserInfoDTO {

    /**
     * 微信OPEN_ID
     */
    private String openId;

    /**
     * 昵称
     */
    private String nickName;

    /**
     * 年龄
     */
    private Integer age;

    /**
     * 头像
     */
    private String avatar;

    /**
     * 真实姓名
     */
    private String userName;

    /**
     * 身份证号
     */
    private String idCard;

    /**
     * 出生日期
     */
    private String birthDay;

    /**
     * 性别: N未知 M男 F女
     */
    private String sex;

    /**
     * 手机号码
     */
    private String mobile;

    /**
     * 学校(学籍)
     */
    private String school;

    /**
     * 企业名称
     */
    private String companyName;

    /**
     * 学历:1高中及以下 2大专 3本科 4硕士 5博士
     */
    private Integer education;

    /**
     * 身高
     */
    private Integer height;

    /**
     * 体重
     */
    private Integer weight;

    /**
     * 个人认证:0未认证 1已认证 2认证失败
     */
    private Integer idCert;

    /**
     * 学历认证:0未认证 1已认证 2认证失败
     */
    private Integer educationCert;

    /**
     * 企业认证:0未认证 1已认证 2认证失败
     */
    private Integer corporateCert;

    /**
     * 房产认证:0未认证 1已认证 2认证失败
     */
    private Integer propertyCert;

    /**
     *  车辆认证:0未认证 1已认证 2认证失败
     */
    private Integer vehicleCert;

    /**
     * 电影标签
     */
    private List<String> movieTags;

    /**
     * 音乐标签
     */
    private List<String> musicTags;

    /**
     * 运动标签
     */
    private List<String> sportTags;

    /**
     * 美食标签
     */
    private List<String> foodTags;

    /**
     * 个性标签
     */
    private List<String> liveTags;

}
