package org.igetwell.system.users.domain;

import javax.persistence.*;

public class User {
    /**
     * 主键
     */
    @Id
    @Column(name = "ID")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    /**
     * 微信OPEN_ID
     */
    @Column(name = "OPEN_ID")
    private String openId;

    /**
     * 昵称
     */
    @Column(name = "NICK_NAME")
    private String nickName;

    /**
     * 头像
     */
    @Column(name = "AVATAR")
    private String avatar;

    /**
     * 真实姓名
     */
    @Column(name = "USER_NAME")
    private String userName;

    /**
     * 身份证号
     */
    @Column(name = "ID_CARD")
    private String idCard;

    /**
     * 出生日期
     */
    @Column(name = "BIRTH_DAY")
    private String birthDay;

    /**
     * 性别: 0未知 1男 2女
     */
    @Column(name = "SEX")
    private String sex;

    /**
     * 手机号码
     */
    @Column(name = "MOBILE")
    private String mobile;

    /**
     * 账户密码：手机账户注册时填写该字段
     */
    @Column(name = "SECRET")
    private String secret;

    /**
     * 登陆类型：1微信  2支付宝 3手机号登陆
     */
    @Column(name = "LOGIN_TYPE")
    private Integer loginType;

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
     * 获取微信OPEN_ID
     *
     * @return OPEN_ID - 微信OPEN_ID
     */
    public String getOpenId() {
        return openId;
    }

    /**
     * 设置微信OPEN_ID
     *
     * @param openId 微信OPEN_ID
     */
    public void setOpenId(String openId) {
        this.openId = openId == null ? null : openId.trim();
    }

    /**
     * 获取昵称
     *
     * @return NICK_NAME - 昵称
     */
    public String getNickName() {
        return nickName;
    }

    /**
     * 设置昵称
     *
     * @param nickName 昵称
     */
    public void setNickName(String nickName) {
        this.nickName = nickName == null ? null : nickName.trim();
    }

    /**
     * 获取头像
     *
     * @return AVATAR - 头像
     */
    public String getAvatar() {
        return avatar;
    }

    /**
     * 设置头像
     *
     * @param avatar 头像
     */
    public void setAvatar(String avatar) {
        this.avatar = avatar == null ? null : avatar.trim();
    }

    /**
     * 获取真实姓名
     *
     * @return USER_NAME - 真实姓名
     */
    public String getUserName() {
        return userName;
    }

    /**
     * 设置真实姓名
     *
     * @param userName 真实姓名
     */
    public void setUserName(String userName) {
        this.userName = userName == null ? null : userName.trim();
    }

    /**
     * 获取身份证号
     *
     * @return ID_CARD - 身份证号
     */
    public String getIdCard() {
        return idCard;
    }

    /**
     * 设置身份证号
     *
     * @param idCard 身份证号
     */
    public void setIdCard(String idCard) {
        this.idCard = idCard == null ? null : idCard.trim();
    }

    /**
     * 获取出生日期
     *
     * @return BIRTH_DAY - 出生日期
     */
    public String getBirthDay() {
        return birthDay;
    }

    /**
     * 设置出生日期
     *
     * @param birthDay 出生日期
     */
    public void setBirthDay(String birthDay) {
        this.birthDay = birthDay == null ? null : birthDay.trim();
    }

    /**
     * 获取性别: 0未知 1男 2女
     *
     * @return SEX - 性别: 0未知 1男 2女
     */
    public String getSex() {
        return sex;
    }

    /**
     * 设置性别: 0未知 1男 2女
     *
     * @param sex 性别: 0未知 1男 2女
     */
    public void setSex(String sex) {
        this.sex = sex == null ? null : sex.trim();
    }

    /**
     * 获取手机号码
     *
     * @return MOBILE - 手机号码
     */
    public String getMobile() {
        return mobile;
    }

    /**
     * 设置手机号码
     *
     * @param mobile 手机号码
     */
    public void setMobile(String mobile) {
        this.mobile = mobile == null ? null : mobile.trim();
    }

    /**
     * 获取账户密码：手机账户注册时填写该字段
     *
     * @return SECRET - 账户密码：手机账户注册时填写该字段
     */
    public String getSecret() {
        return secret;
    }

    /**
     * 设置账户密码：手机账户注册时填写该字段
     *
     * @param secret 账户密码：手机账户注册时填写该字段
     */
    public void setSecret(String secret) {
        this.secret = secret == null ? null : secret.trim();
    }

    /**
     * 获取登陆类型：1微信  2支付宝 3手机号登陆
     *
     * @return LOGIN_TYPE - 登陆类型：1微信  2支付宝 3手机号登陆
     */
    public Integer getLoginType() {
        return loginType;
    }

    /**
     * 设置登陆类型：1微信  2支付宝 3手机号登陆
     *
     * @param loginType 登陆类型：1微信  2支付宝 3手机号登陆
     */
    public void setLoginType(Integer loginType) {
        this.loginType = loginType;
    }
}