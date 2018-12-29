package org.igetwell.system.pay.service.impl;

import org.igetwell.common.bean.WxNotifyBean;
import org.igetwell.common.constans.WXPayConstants;
import org.igetwell.common.enums.LoginType;
import org.igetwell.common.enums.JsApiType;
import org.igetwell.common.enums.PayStatus;
import org.igetwell.common.enums.PayType;
import org.igetwell.common.enums.SignType;
import org.igetwell.common.local.IpKit;
import org.igetwell.common.local.LocalSnowflakeService;
import org.igetwell.common.utils.*;
import org.igetwell.system.pay.domain.Payment;
import org.igetwell.system.pay.mapper.PaymentMapper;
import org.igetwell.system.pay.retrieve.PaymentQuery;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

/**
 * 微信支付
 */
@Component
public class LocalPay {

    private static final Logger logger = LoggerFactory.getLogger(LocalPay.class);

    @Value("${defaultAppId}")
    private String defaultAppId;

    @Value("${paterKey}")
    private String paterKey;

    @Value("${mchId}")
    private String mchId;

    @Value("${attach}")
    private String attach;

    @Value("${domain}")
    private String domain;


    @Autowired
    private LocalSnowflakeService localSnowflakeService;

    @Autowired
    private PaymentMapper paymentMapper;


    /**
     * 扫码预付款下单
     * @param request
     * @param productName
     * @param productId
     * @param fee
     * @return
     */
    public String scanOrder(HttpServletRequest request, String productName, String productId, String fee) {

        String nonceStr = UUID.randomUUID().toString().replace("-", "");
        String timestamp = String.valueOf(System.currentTimeMillis()/1000);
        String tradeNo = attach + localSnowflakeService.nextId();

        try {
            String clientIp = IpKit.getIpAddr(request);

            Map<String,String> paraMap= ParaMap.create("productId", productId)
                    .put("body", productName)
                    .put("tradeNo", tradeNo)
                    .put("fee", fee)
                    .put("nonceStr", nonceStr)
                    .put("timestamp",timestamp)
                    .put("clientIp", clientIp)
                    .put("tradeType", "NATIVE")
                    .put("notifyUrl","/WxPay/payNotify")
                    .getData();

            Map<String, String> resultXml = this.prePay(paraMap, SignType.MD5);
            String returnCode = resultXml.get("return_code");
            String resultCode = resultXml.get("result_code");
            String codeUrl = resultXml.get("code_url");
            boolean isSuccess = WXPayConstants.SUCCESS.equals(returnCode) && WXPayConstants.SUCCESS.equals(resultCode);
            if (!isSuccess) {
                throw new RuntimeException("统一支付失败！" +
                        "return_code:" + resultXml.get("return_code") + " " +
                        "return_msg:" + resultXml.get("return_msg"));
            }
            logger.info("统一下单调用结束！预支付交易标识：{}. {}", resultXml.get("prepay_id"), resultXml.get("return_msg"));

            return codeUrl;
        } catch (Exception e) {
            logger.error("商户交易号：{} 预支付失败！", tradeNo, e);
        }
        return null;
    }

    /**
     * APP预付款下单
     * @param request
     * @param productName
     * @param productId
     * @param fee
     * @return
     */
    public Map<String, String> jsAppOrder(HttpServletRequest request, String productName, String productId, String fee) {
        String nonceStr = UUID.randomUUID().toString().replace("-", "");
        String timestamp = String.valueOf(System.currentTimeMillis()/1000);
        String tradeNo = attach + localSnowflakeService.nextId();
        String clientIp = IpKit.getIpAddr(request);

        Map<String,String> paraMap= ParaMap.create("productId", productId)
                .put("body", productName)
                .put("tradeNo", tradeNo)
                .put("fee", fee)
                .put("nonceStr", nonceStr)
                .put("timestamp",timestamp)
                .put("clientIp", clientIp)
                .put("tradeType", "APP")
                .put("notifyUrl","/WxPay/payNotify")
                .getData();
        try {

            Map<String, String> resultXml = this.prePay(paraMap, SignType.MD5);
            String returnCode = resultXml.get("return_code");
            String resultCode = resultXml.get("result_code");
            boolean isSuccess = WXPayConstants.SUCCESS.equals(returnCode) && WXPayConstants.SUCCESS.equals(resultCode);
            if (!isSuccess) {
                throw new RuntimeException("统一支付失败！" +
                        "return_code:" + resultXml.get("return_code") + " " +
                        "return_msg:" + resultXml.get("return_msg"));
            }
            String prepayId = resultXml.get("prepay_id");
            logger.info("统一下单调用结束！预支付交易标识：{}. {}", prepayId, resultXml.get("return_msg"));

            Map<String, String> packageMap = new HashMap<>();
            packageMap.put("appid", defaultAppId);
            packageMap.put("partnerid", mchId);
            packageMap.put("prepayid", prepayId);
            packageMap.put("package", "Sign=WXPay");
            packageMap.put("noncestr", nonceStr);
            packageMap.put("timestamp", timestamp);
            String sign = SignUtils.createSign(packageMap, paterKey, SignType.MD5);
            packageMap.put("sign", sign);

        } catch (Exception e) {
            logger.error("商户交易号：{} 预支付失败！", tradeNo, e);
        }
        return null;
    }


    /**
     * 微信JSAPI、H5、APP、NATIVE调起支付
     * @param request
     * @param jsApiType
     * @param productName
     * @param productId
     * @param fee
     * @return
     */
    @Transactional(rollbackFor = RuntimeException.class)
    public Map<String, String> preOrder(HttpServletRequest request, String openId, JsApiType jsApiType, PayType payType, String productName, String productId, String fee){
        String nonceStr = UUID.randomUUID().toString().replace("-", "");
        String timestamp = String.valueOf(System.currentTimeMillis()/1000);
        String tradeNo = attach + localSnowflakeService.nextId();
        String clientIp = IpKit.getIpAddr(request);

        Map<String,String> paraMap= ParaMap.create("openId", openId)
                .put("productId", productId)
                .put("body", productName)
                .put("tradeNo", tradeNo)
                .put("fee", fee)
                .put("nonceStr", nonceStr)
                .put("timestamp",timestamp)
                .put("clientIp", clientIp)
                .put("tradeType", jsApiType.toString())
                .put("notifyUrl","/WxPay/payNotify")
                .getData();
        try {

            Map<String, String> resultXml = this.prePay(paraMap, SignType.MD5);
            //调用统一下单支付结束方法
            String prepayId = parseXml(resultXml);

            Payment payment = new Payment();
            payment.setOpenId(openId);
            payment.setProductId(productId);
            payment.setTradeNo(tradeNo);
            payment.setPrepayId(prepayId);
            payment.setFee(Integer.valueOf(fee));
            payment.setLoginType(LoginType.WECHAT.value());
            payment.setPayStatus(PayStatus.WAITPAY.value());
            payment.setPayType(payType.value());
            paymentMapper.insert(payment);

            Map<String, String> packageMap = new HashMap<>();
            if (JsApiType.APP.equals(jsApiType)){
                packageMap.put("appid", defaultAppId);
                packageMap.put("partnerid", mchId);
                packageMap.put("prepayid", prepayId);
                packageMap.put("package", "Sign=WXPay");
                packageMap.put("noncestr", nonceStr);
                packageMap.put("timestamp", timestamp);
                String sign = SignUtils.createSign(packageMap, paterKey, SignType.MD5);
                packageMap.put("sign", sign);
            }

            if (JsApiType.JSAPI.equals(jsApiType)){
                packageMap.put("appid", defaultAppId);
                packageMap.put("timeStamp", timestamp);
                packageMap.put("nonceStr", nonceStr);
                packageMap.put("package", "prepay_id=" + prepayId);
                packageMap.put("signType", "MD5");
                String sign = SignUtils.createSign(packageMap, paterKey, SignType.MD5);
                packageMap.put("paySign", sign);
            }

            if (JsApiType.MWEB.equals(jsApiType)){
                packageMap.put("appid", defaultAppId);
                packageMap.put("mch_id", mchId);
                packageMap.put("prepayid", prepayId);
                packageMap.put("mweb_url", nonceStr);
                packageMap.put("package", "prepay_id=" + prepayId);
                packageMap.put("signType", "MD5");
                String sign = SignUtils.createSign(packageMap, paterKey, SignType.MD5);
                packageMap.put("paySign", sign);
            }

            if (JsApiType.NATIVE.equals(jsApiType)){
                packageMap.put("codeUrl", resultXml.get("code_url"));
            }

            return packageMap;

        } catch (Exception e) {
            logger.error("商户交易号：{} 预支付失败！", tradeNo, e);
            throw new RuntimeException("创建预支付订单失败！", e);
        }
    }

    /**
     * 预支付接口
     * @param hashMap
     * @param signType
     * @return
     * @throws Exception
     */
    private Map<String, String> prePay(Map<String, String> hashMap, SignType signType) throws Exception{
        hashMap.put("appId", defaultAppId);
        hashMap.put("mchId", mchId);

        // 创建请求参数
        Map<String, String> params = createParams(hashMap, signType);

        logger.info("=================统一下单调用开始====================");
        // 微信统一下单
        String result = pushOrder(params);

        Map<String, String> resultXml = BeanUtils.xmlBean2Map(result);

        return resultXml;

    }


    /**
     * 签名入参
     * @param hashMap
     * @param signType
     * @return
     * @throws Exception
     */
    private Map<String, String> createParams(Map<String, String> hashMap, SignType signType) throws Exception {

        Map<String, String> params = new HashMap<>();
        params.put("appid", hashMap.get("appId")); //  appId
        params.put("mch_id", hashMap.get("mchId")); //  商户号
        params.put("openid", hashMap.get("openId")); // trade_type=JSAPI，此参数必传，用户在商户appid下的唯一标识
        params.put("device_info", "WEB"); // 终端设备号(门店号或收银设备ID)，注意：PC网页或公众号内支付请传"WEB"
        params.put("nonce_str", hashMap.get("nonceStr")); // 随机字符串，不长于32位。
        params.put("body", hashMap.get("body")); // 商品或支付单简要描述
        params.put("attach", attach); // 附加数据=来源
        params.put("out_trade_no", hashMap.get("tradeNo")); // 商户系统内部的订单号,32个字符内、可包含字母
        params.put("fee_type", "CNY"); // 货币类型，默认人民币：CNY
        params.put("total_fee", hashMap.get("fee")); // 订单总金额，单位为分
        params.put("spbill_create_ip", hashMap.get("clientIp")); // APP和网页支付提交用户端ip，Native支付填调用微信支付API的机器IP
        params.put("trade_type", hashMap.get("tradeType")); // JSAPI--公众号支付、NATIVE--原生扫码支付、APP--app支付
        params.put("notify_url", domain + hashMap.get("notifyUrl")); // 通知地址，接收微信支付异步通知回调地址，通知url必须为直接可访问的url，不能携带参数。
        params.put("product_id", hashMap.get("productId"));

        String sign = SignUtils.createSign(params, paterKey, signType);
        params.put("sign", sign);

        return params;
    }

    /**
     * 请求下单地址
     * @param params
     * @return
     */
    private static String pushOrder(Map<String, String> params) {
        //final String unifiedOrderUrl = "https://api.mch.weixin.qq.com/pay/unifiedorder";
        return HttpClientUtils.getInstance().sendHttpPost(WXPayConstants.DOMAIN_API + WXPayConstants.UNIFIED_ORDER, BeanUtils.mapBean2Xml(params), "UTF-8");
    }

    /**
     * 解析微信返回xml
     * @param resultXml
     * @return
     */
    private static String parseXml(Map<String, String> resultXml){
        String returnCode = resultXml.get("return_code");
        String resultCode = resultXml.get("result_code");
        boolean isSuccess = WXPayConstants.SUCCESS.equalsIgnoreCase(returnCode) && WXPayConstants.SUCCESS.equalsIgnoreCase(resultCode);
        if (!isSuccess) {
            throw new RuntimeException("统一支付失败！" +
                    "return_code:" + resultXml.get("return_code") + " " +
                    "return_msg:" + resultXml.get("return_msg"));
        }
        String prepayId = resultXml.get("prepay_id");
        logger.info("统一下单调用结束！预支付交易标识：{}. {}", prepayId, resultXml.get("return_msg"));
        return prepayId;
    }


    /**
     * 处理微信回调
     * @param xmlStr
     * @return
     */
    public String notifyMethod(String xmlStr){
        String successXml = "<xml><return_code><![CDATA[SUCCESS]]></return_code><return_msg><![CDATA[OK]]></return_msg></xml>";
        String failXml = "<xml><return_code><![CDATA[FAIL]]></return_code><return_msg><![CDATA[${return_msg}]]></return_msg></xml>";
        // 获取参数
        Map<String, String> resultXml = BeanUtils.xmlBean2Map(xmlStr);
        // 获取商户交易号
        WxNotifyBean notifyBean = WxNotifyBean.create();
        notifyBean.setAppId(resultXml.get("appid"));// 获取商户appId
        notifyBean.setMchId(resultXml.get("mch_id"));// 获取商户号
        notifyBean.setOpenId(resultXml.get("openid"));// 获取openId
        notifyBean.setJsApiType(resultXml.get("trade_type"));// 获取交易类型
        notifyBean.setFee(resultXml.get("total_fee")); // 获取支付金额
        notifyBean.setTradeNo(resultXml.get("out_trade_no"));//获取商户交易号
        notifyBean.setTransactionId(resultXml.get("transaction_id"));//获取微信支付订单号
        notifyBean.setPayTime(resultXml.get("time_end"));//获取微信支付完成时间


        try {
            boolean bool = SignUtils.checkSign(resultXml, paterKey, SignType.MD5);
            if (!bool){
                logger.error("微信支付回调验证签名错误！");
                return failXml.replace("${return_msg}", "微信支付回调验证签名错误！");
            }
            String returnCode = resultXml.get("return_code");
            String resultCode = resultXml.get("result_code");
            boolean isSuccess = WXPayConstants.SUCCESS.equalsIgnoreCase(returnCode) && WXPayConstants.SUCCESS.equalsIgnoreCase(resultCode);
            if (isSuccess){
                //TODO:需要做数据库记录交易订单号
                PaymentQuery paymentQuery = new PaymentQuery();
                paymentQuery.setOpenId(notifyBean.getOpenId());
                paymentQuery.setTradeNo(notifyBean.getTradeNo());
                paymentQuery.setPayStatus(PayStatus.WAITPAY.value());
                Payment payment = paymentMapper.get(paymentQuery);
                if (!StringUtils.isEmpty(payment)){
                    payment.setPaymentNo(notifyBean.getTransactionId());
                    payment.setPayStatus(PayStatus.PAID.value());
                    payment.setPayTime(notifyBean.getPayTime());
                    paymentMapper.updateByPrimaryKey(payment);
                    logger.info("用户公众ID：{} , 订单号：{} , 交易号：{} 微信支付成功！",
                            notifyBean.getOpenId(), notifyBean.getTradeNo(), notifyBean.getTransactionId());
                }
                return successXml;
            }
            return failXml;
        } catch (Exception e) {
            logger.error("调用微信支付回调方法异常,商户订单号：{}. 微信支付订单号：{}. ", notifyBean.getTradeNo(), notifyBean.getTransactionId(), e);
            throw new RuntimeException("调用微信支付回调方法异常！", e);
        }
    }

}
