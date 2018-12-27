package org.igetwell.common.utils;


public class WxNotifyBean {

    /**
     * 商户appId
     */
    private String appId;

    /**
     * 商户号
     */
    private String mchId;
    /**
     * 用户openId
     */
    private String openId;
    /**
     * 微信交易订单号
     */
    private String transactionId;
    /**
     * 商家交易订单号
     */
    private String tradeNo;
    /**
     * 支付金额
     */
    private String fee;
    /**
     * 交易类型：
     * 公众号支付(JSAPI)
     * APP支付(APP)
     * 扫码支付(NATIVE)
     */
    private String jsApiType;

    /**
     * 微信交易完成时间
     */
    private String payTime;


    private WxNotifyBean(){}

    public static WxNotifyBean create(){ return new WxNotifyBean(); }


    public String getAppId() {
        return appId;
    }

    public void setAppId(String appId) {
        this.appId = appId;
    }

    public String getMchId() {
        return mchId;
    }

    public void setMchId(String mchId) {
        this.mchId = mchId;
    }

    public String getOpenId() {
        return openId;
    }

    public void setOpenId(String openId) {
        this.openId = openId;
    }

    public String getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }

    public String getTradeNo() {
        return tradeNo;
    }

    public void setTradeNo(String tradeNo) {
        this.tradeNo = tradeNo;
    }

    public String getFee() {
        return fee;
    }

    public void setFee(String fee) {
        this.fee = fee;
    }

    public String getJsApiType() {
        return jsApiType;
    }

    public void setJsApiType(String jsApiType) {
        this.jsApiType = jsApiType;
    }

    public String getPayTime() {
        return payTime;
    }

    public void setPayTime(String payTime) {
        this.payTime = payTime;
    }
}
