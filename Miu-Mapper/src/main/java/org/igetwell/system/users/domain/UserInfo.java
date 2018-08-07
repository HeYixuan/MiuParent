package org.igetwell.system.users.domain;

import javax.persistence.*;

@Table(name = "user_info")
public class UserInfo {
    /**
     * 主键
     */
    @Id
    @Column(name = "ID")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    /**
     * 用户微信OPEN_ID
     */
    @Column(name = "OPEN_ID")
    private String openId;

    /**
     * 学校(学籍)
     */
    @Column(name = "SCHOOL")
    private String school;

    /**
     * 企业名称
     */
    @Column(name = "COMPANY_NAME")
    private String companyName;

    /**
     * 学历:1高中及以下 2大专 3本科 4硕士 5博士
     */
    @Column(name = "EDUCATION")
    private Integer education;

    /**
     * 身高
     */
    @Column(name = "HEIGHT")
    private Integer height;

    /**
     * 体重
     */
    @Column(name = "WEIGHT")
    private Integer weight;

    /**
     * 婚姻状况:1未婚 2离异
     */
    @Column(name = "MARITAL_STATUS")
    private Integer maritalStatus;

    /**
     * 收入状况:1.5K及以下 2.5K-1W 3.1W-3W 4.3W+
     */
    @Column(name = "WAGE_STATUS")
    private Integer wageStatus;

    /**
     * 个人认证:0未认证 1已认证 2认证失败
     */
    @Column(name = "ID_CERT")
    private Integer idCert;

    /**
     * 学历认证:0未认证 1已认证 2认证失败
     */
    @Column(name = "EDUCATION_CERT")
    private Integer educationCert;

    /**
     * 企业认证:0未认证 1已认证 2认证失败
     */
    @Column(name = "CORPORATE_CERT")
    private Integer corporateCert;

    /**
     * 房产认证:0未认证 1已认证 2认证失败
     */
    @Column(name = "PROPERTY_CERT")
    private Integer propertyCert;

    /**
     *  车辆认证:0未认证 1已认证 2认证失败
     */
    @Column(name = "VEHICLE_CERT")
    private Integer vehicleCert;

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
     * 获取用户微信OPEN_ID
     *
     * @return OPEN_ID - 用户微信OPEN_ID
     */
    public String getOpenId() {
        return openId;
    }

    /**
     * 设置用户微信OPEN_ID
     *
     * @param openId 用户微信OPEN_ID
     */
    public void setOpenId(String openId) {
        this.openId = openId == null ? null : openId.trim();
    }

    /**
     * 获取学校(学籍)
     *
     * @return SCHOOL - 学校(学籍)
     */
    public String getSchool() {
        return school;
    }

    /**
     * 设置学校(学籍)
     *
     * @param school 学校(学籍)
     */
    public void setSchool(String school) {
        this.school = school == null ? null : school.trim();
    }

    /**
     * 获取企业名称
     *
     * @return COMPANY_NAME - 企业名称
     */
    public String getCompanyName() {
        return companyName;
    }

    /**
     * 设置企业名称
     *
     * @param companyName 企业名称
     */
    public void setCompanyName(String companyName) {
        this.companyName = companyName == null ? null : companyName.trim();
    }

    /**
     * 获取学历:1高中及以下 2大专 3本科 4硕士 5博士
     *
     * @return EDUCATION - 学历:1高中及以下 2大专 3本科 4硕士 5博士
     */
    public Integer getEducation() {
        return education;
    }

    /**
     * 设置学历:1高中及以下 2大专 3本科 4硕士 5博士
     *
     * @param education 学历:1高中及以下 2大专 3本科 4硕士 5博士
     */
    public void setEducation(Integer education) {
        this.education = education;
    }

    /**
     * 获取身高
     *
     * @return HEIGHT - 身高
     */
    public Integer getHeight() {
        return height;
    }

    /**
     * 设置身高
     *
     * @param height 身高
     */
    public void setHeight(Integer height) {
        this.height = height;
    }

    /**
     * 获取体重
     *
     * @return WEIGHT - 体重
     */
    public Integer getWeight() {
        return weight;
    }

    /**
     * 设置体重
     *
     * @param weight 体重
     */
    public void setWeight(Integer weight) {
        this.weight = weight;
    }

    /**
     * 获取婚姻状况:1未婚 2离异
     *
     * @return MARITAL_STATUS - 婚姻状况:1未婚 2离异
     */
    public Integer getMaritalStatus() {
        return maritalStatus;
    }

    /**
     * 设置婚姻状况:1未婚 2离异
     *
     * @param maritalStatus 婚姻状况:1未婚 2离异
     */
    public void setMaritalStatus(Integer maritalStatus) {
        this.maritalStatus = maritalStatus;
    }

    /**
     * 获取收入状况:1.5K及以下 2.5K-1W 3.1W-3W 4.3W+
     *
     * @return WAGE_STATUS - 收入状况:1.5K及以下 2.5K-1W 3.1W-3W 4.3W+
     */
    public Integer getWageStatus() {
        return wageStatus;
    }

    /**
     * 设置收入状况:1.5K及以下 2.5K-1W 3.1W-3W 4.3W+
     *
     * @param wageStatus 收入状况:1.5K及以下 2.5K-1W 3.1W-3W 4.3W+
     */
    public void setWageStatus(Integer wageStatus) {
        this.wageStatus = wageStatus;
    }

    /**
     * 获取个人认证:0未认证 1已认证 2认证失败
     *
     * @return ID_CERT - 个人认证:0未认证 1已认证 2认证失败
     */
    public Integer getIdCert() {
        return idCert;
    }

    /**
     * 设置个人认证:0未认证 1已认证 2认证失败
     *
     * @param idCert 个人认证:0未认证 1已认证 2认证失败
     */
    public void setIdCert(Integer idCert) {
        this.idCert = idCert;
    }

    /**
     * 获取学历认证:0未认证 1已认证 2认证失败
     *
     * @return EDUCATION_CERT - 学历认证:0未认证 1已认证 2认证失败
     */
    public Integer getEducationCert() {
        return educationCert;
    }

    /**
     * 设置学历认证:0未认证 1已认证 2认证失败
     *
     * @param educationCert 学历认证:0未认证 1已认证 2认证失败
     */
    public void setEducationCert(Integer educationCert) {
        this.educationCert = educationCert;
    }

    /**
     * 获取企业认证:0未认证 1已认证 2认证失败
     *
     * @return CORPORATE_CERT - 企业认证:0未认证 1已认证 2认证失败
     */
    public Integer getCorporateCert() {
        return corporateCert;
    }

    /**
     * 设置企业认证:0未认证 1已认证 2认证失败
     *
     * @param corporateCert 企业认证:0未认证 1已认证 2认证失败
     */
    public void setCorporateCert(Integer corporateCert) {
        this.corporateCert = corporateCert;
    }

    /**
     * 获取房产认证:0未认证 1已认证 2认证失败
     *
     * @return PROPERTY_CERT - 房产认证:0未认证 1已认证 2认证失败
     */
    public Integer getPropertyCert() {
        return propertyCert;
    }

    /**
     * 设置房产认证:0未认证 1已认证 2认证失败
     *
     * @param propertyCert 房产认证:0未认证 1已认证 2认证失败
     */
    public void setPropertyCert(Integer propertyCert) {
        this.propertyCert = propertyCert;
    }

    /**
     * 获取 车辆认证:0未认证 1已认证 2认证失败
     *
     * @return VEHICLE_CERT -  车辆认证:0未认证 1已认证 2认证失败
     */
    public Integer getVehicleCert() {
        return vehicleCert;
    }

    /**
     * 设置 车辆认证:0未认证 1已认证 2认证失败
     *
     * @param vehicleCert  车辆认证:0未认证 1已认证 2认证失败
     */
    public void setVehicleCert(Integer vehicleCert) {
        this.vehicleCert = vehicleCert;
    }
}