package org.igetwell.system.pay.domain;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.util.Date;

public class Payment {
    @Id
    @Column(name = "ID")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    /**
     * 用户OPEN_ID
     */
    @Column(name = "OPEN_ID")
    private String openId;

    /**
     * 商品ID
     */
    @Column(name = "PRODUCT_ID")
    private String productId;

    /**
     * 订单号
     */
    @Column(name = "TRADE_NO")
    private String tradeNo;

    /**
     * 预付款ID
     */
    @Column(name = "PREPAY_ID")
    private String prepayId;

    /**
     * 微信支付单号
     */
    @Column(name = "PAYMENT_NO")
    private String paymentNo;

    /**
     * 支付金额
     */
    @Column(name = "FEE")
    private Integer fee;

    /**
     * 支付类型: 1实名认证费用 2活动费 3其他
     */
    @Column(name = "PAY_TYPE")
    private Integer payType;

    /**
     * 支付状态: 0未支付 1已支付
     */
    @Column(name = "PAY_STATUS")
    private Integer payStatus;

    /**
     * 支付方式：1微信 2支付宝
     */
    @Column(name = "LOGIN_TYPE")
    private Integer loginType;

    /**
     * 支付回调时间
     */
    @Column(name = "PAY_TIME")
    private String payTime;

    /**
     * 创建时间
     */
    @Column(name = "CREATE_TIME")
    private Date createTime;

    /**
     * @return ID
     */
    public Integer getId() {
        return id;
    }

    /**
     * @param id
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * 获取用户OPEN_ID
     *
     * @return OPEN_ID - 用户OPEN_ID
     */
    public String getOpenId() {
        return openId;
    }

    /**
     * 设置用户OPEN_ID
     *
     * @param openId 用户OPEN_ID
     */
    public void setOpenId(String openId) {
        this.openId = openId == null ? null : openId.trim();
    }

    /**
     * 获取商品ID
     *
     * @return PRODUCT_ID - 商品ID
     */
    public String getProductId() {
        return productId;
    }

    /**
     * 设置商品ID
     *
     * @param productId 商品ID
     */
    public void setProductId(String productId) {
        this.productId = productId == null ? null : productId.trim();
    }

    /**
     * 获取订单号
     *
     * @return TRADE_NO - 订单号
     */
    public String getTradeNo() {
        return tradeNo;
    }

    /**
     * 设置订单号
     *
     * @param tradeNo 订单号
     */
    public void setTradeNo(String tradeNo) {
        this.tradeNo = tradeNo == null ? null : tradeNo.trim();
    }

    /**
     * 获取预付款ID
     *
     * @return PREPAY_ID - 预付款ID
     */
    public String getPrepayId() {
        return prepayId;
    }

    /**
     * 设置预付款ID
     *
     * @param prepayId 预付款ID
     */
    public void setPrepayId(String prepayId) {
        this.prepayId = prepayId == null ? null : prepayId.trim();
    }

    /**
     * 获取微信支付单号
     *
     * @return PAYMENT_NO - 微信支付单号
     */
    public String getPaymentNo() {
        return paymentNo;
    }

    /**
     * 设置微信支付单号
     *
     * @param paymentNo 微信支付单号
     */
    public void setPaymentNo(String paymentNo) {
        this.paymentNo = paymentNo == null ? null : paymentNo.trim();
    }

    /**
     * 获取支付金额
     *
     * @return FEE - 支付金额
     */
    public Integer getFee() {
        return fee;
    }

    /**
     * 设置支付金额
     *
     * @param fee 支付金额
     */
    public void setFee(Integer fee) {
        this.fee = fee;
    }

    /**
     * 获取支付类型: 1实名认证费用 2活动费 3其他
     *
     * @return PAY_TYPE - 支付类型: 1实名认证费用 2活动费 3其他
     */
    public Integer getPayType() {
        return payType;
    }

    /**
     * 设置支付类型: 1实名认证费用 2活动费 3其他
     *
     * @param payType 支付类型: 1实名认证费用 2活动费 3其他
     */
    public void setPayType(Integer payType) {
        this.payType = payType;
    }

    /**
     * 获取支付状态: 0未支付 1已支付
     *
     * @return PAY_STATUS - 支付状态: 0未支付 1已支付
     */
    public Integer getPayStatus() {
        return payStatus;
    }

    /**
     * 设置支付状态: 0未支付 1已支付
     *
     * @param payStatus 支付状态: 0未支付 1已支付
     */
    public void setPayStatus(Integer payStatus) {
        this.payStatus = payStatus;
    }

    /**
     * 获取支付方式：1微信 2支付宝
     *
     * @return Login_TYPE - 支付方式：1微信 2支付宝
     */
    public Integer getLoginType() {
        return loginType;
    }

    /**
     * 设置支付方式：1微信 2支付宝
     *
     * @param loginType 支付方式：1微信 2支付宝
     */
    public void setLoginType(Integer loginType) {
        this.loginType = loginType;
    }

    /**
     * 获取支付回调时间
     *
     * @return PAY_TIME - 支付回调时间
     */
    public String getPayTime() {
        return payTime;
    }

    /**
     * 设置支付回调时间
     *
     * @param payTime 支付回调时间
     */
    public void setPayTime(String payTime) {
        this.payTime = payTime;
    }

    /**
     * 获取创建时间
     *
     * @return CREATE_TIME - 创建时间
     */
    public Date getCreateTime() {
        return createTime;
    }

    /**
     * 设置创建时间
     *
     * @param createTime 创建时间
     */
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}