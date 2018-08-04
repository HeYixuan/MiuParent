package org.igetwell.web.wechat.pay;

import org.igetwell.common.enums.JsApiType;
import org.igetwell.common.local.HttpKit;
import org.igetwell.common.local.LocalPay;
import org.igetwell.web.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import java.util.Map;


@RestController
@RequestMapping("/WxPay")
public class WxPayController extends BaseController {

    @Autowired
    private LocalPay localPay;

    /**
     * 扫码支付
     * @return
     */
    @PostMapping("/scanPay")
    @ResponseBody
    public String scanPay() {
        String codeUrl = localPay.scanOrder(request.get(), "官网费用","GW201807162055","1");
        return codeUrl;
    }


    /**
     * 公众号支付，APP内调起微信支付
     * 微信H5、APP内调起支付
     * @return
     */
    @PostMapping("/preOrder")
    @ResponseBody
    public Map<String, String> preOrder() {
        return localPay.preOrder(request.get(), null, JsApiType.APP,"官网费用","GW201807162055","1");
    }


    /**
     * 微信支付返回通知
     */
    @PostMapping(value = "payNotify", produces = {"application/xml"})
    public void payNotify(){
        try {
            String xmlStr = HttpKit.readData(request.get());
            String resultXml = localPay.notifyMethod(xmlStr);
            renderReturn(resultXml);
        } catch (Exception e){
            logger.error("支付回调异常！", e);
        }

    }

}
