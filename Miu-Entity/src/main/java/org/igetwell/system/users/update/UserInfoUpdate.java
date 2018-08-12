package org.igetwell.system.users.update;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

/**
 * UserInfo修改对象
 */
public class UserInfoUpdate {
    /**
     * 用户微信OPEN_ID
     */
    //@NotBlank(message = "OPEN_ID不能为空")
    //private String openId;

    /**
     * 学校(学籍)
     */
    @NotBlank(message = "学籍不能为空")
    private String school;

    /**
     * 企业名称
     */
    @NotBlank(message = "企业名称不能为空")
    private String companyName;

    /**
     * 学历:1高中及以下 2大专 3本科 4硕士 5博士
     */
    @NotNull(message = "学历不能为空")
    private Integer education;

    /**
     * 身高
     */
    @NotNull(message = "身高不能为空")
    private Integer height;

    /**
     * 体重
     */
    @NotNull(message = "体重不能为空")
    private Integer weight;

    /**
     * 婚姻状况:1未婚 2离异
     */
    @NotNull(message = "婚姻状况不能为空")
    private Integer maritalStatus;

    /**
     * 收入状况:1.5K及以下 2.5K-1W 3.1W-3W 4.3W+
     */
    @NotNull(message = "收入状况不能为空")
    private Integer wageStatus;

    /**
     * 获取用户微信OPEN_ID
     *
     * @return OPEN_ID - 用户微信OPEN_ID
     */
    /*public String getOpenId() {
        return openId;
    }*/

    /**
     * 设置用户微信OPEN_ID
     *
     * @param openId 用户微信OPEN_ID
     */
    /*public void setOpenId(String openId) {
        this.openId = openId == null ? null : openId.trim();
    }*/

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

}
