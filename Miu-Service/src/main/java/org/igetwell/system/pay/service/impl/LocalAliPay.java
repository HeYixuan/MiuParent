package org.igetwell.system.pay.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.request.AlipayTradeAppPayRequest;
import com.alipay.api.request.AlipayTradePagePayRequest;
import com.alipay.api.response.AlipayTradeAppPayResponse;
import com.alipay.api.response.AlipayTradePagePayResponse;
import lombok.extern.slf4j.Slf4j;
import org.igetwell.common.constans.AliPayConstants;
import org.igetwell.common.enums.HttpStatus;
import org.igetwell.common.enums.PayType;
import org.igetwell.common.local.LocalSnowflakeService;
import org.igetwell.common.utils.AliPayUtils;
import org.igetwell.common.utils.ResponseEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;


/**
 * 支付宝支付
 */
@Slf4j
@Component
public class LocalAliPay {

    @Value("${aliPay.appId}")
    private String appId;
    @Value("${aliPay.privateKey}")
    private String privateKey;
    @Value("${aliPay.publicKey}")
    private String publicKey;
    @Value("${aliPay.notifyUrl}")
    private String notifyUrl;
    @Value("${aliPay.returnUrl}")
    private String returnUrl;
    @Value("${aliPay.gatewayUrl}")
    private String gatewayUrl;
    @Value("${aliPay.signType}")
    private String signType = "RSA2";
    @Value("${domain}")
    private String domain;
    @Value("${attach}")
    private String attach;

    @Autowired
    private LocalSnowflakeService localSnowflakeService;

    @Transactional(rollbackFor = RuntimeException.class)
    public ResponseEntity preOrder(PayType payType, String productId, String productName, String fee){
        try {
            AlipayClient alipayClient = new DefaultAlipayClient(gatewayUrl, appId, AliPayUtils.APP_PRIVATE_KEY,"json","UTF-8", AliPayUtils.ALIPAY_PUBLIC_KEY, signType);
            String tradeNo = attach + localSnowflakeService.nextId();
            JSONObject object = new JSONObject();
            object.put("timeout_express","90m");
            object.put("total_amount", fee);
            object.put("product_code", productId);
            object.put("subject", productName);
            object.put("body", payType.value());
            object.put("out_trade_no", tradeNo);
            object.put("goods_type", 0);
            AlipayTradeAppPayRequest appPayRequest = new AlipayTradeAppPayRequest();
            appPayRequest.setBizContent(object.toString());
            AlipayTradeAppPayResponse response = alipayClient.pageExecute(appPayRequest);
            if (response.isSuccess()){
                return new ResponseEntity(response.getBody());
            }
        } catch (AlipayApiException e) {
            log.error("支付宝预下单失败！", e);
            throw new RuntimeException("创建预支付订单失败！", e);
        }
        return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR, "支付宝预下单失败");
    }


    /**
     * PC端网站支付(扫码支付)
     * @return
     */
    public ResponseEntity sanPay(String subject, String body, String fee){
        AlipayClient alipayClient = new DefaultAlipayClient(gatewayUrl, appId, AliPayUtils.APP_PRIVATE_KEY, "json", "UTF-8", AliPayUtils.ALIPAY_PUBLIC_KEY, signType);
        String tradeNo = attach + localSnowflakeService.nextId();
        // 设置请求参数
        JSONObject object = new JSONObject();

        object.put("timeout_express","90m");
        object.put("total_amount", fee);
        object.put("product_code", "FAST_INSTANT_TRADE_PAY");
        object.put("subject", subject);
        object.put("body", body);
        object.put("out_trade_no", tradeNo);
        object.put("goods_type", 0);
        AlipayTradePagePayRequest aliPayRequest = new AlipayTradePagePayRequest();
        aliPayRequest.setReturnUrl(domain + returnUrl);
        aliPayRequest.setNotifyUrl(domain + notifyUrl);
        aliPayRequest.setBizContent(object.toString());
        try {
            AlipayTradePagePayResponse response = alipayClient.pageExecute(aliPayRequest); //调用SDK生成表单
            if (response.isSuccess()){
                return new ResponseEntity(response.getBody());
            }
        } catch (AlipayApiException e) {
            log.error("PC端网站支付异常！", e);
            throw new RuntimeException("PC端网站支付异常！", e);
        }
        return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR, "PC端网站支付异常");
    }
}
