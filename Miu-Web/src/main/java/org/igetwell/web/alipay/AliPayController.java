package org.igetwell.web.alipay;

import lombok.extern.slf4j.Slf4j;
import org.igetwell.common.enums.PayType;
import org.igetwell.common.utils.AliPayUtils;
import org.igetwell.common.utils.ResponseEntity;
import org.igetwell.system.pay.service.impl.LocalAliPay;
import org.igetwell.system.users.service.IUserService;
import org.igetwell.web.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/AliPay")
@Slf4j
public class AliPayController extends BaseController {

    @Autowired
    private IUserService userService;

    @Autowired
    private LocalAliPay localAliPay;

    /**
     * 支付宝授权登陆
     */
    @GetMapping("/AliPayAuthorizedLogin")
    public void AliPayAuthorizedLogin() {
        String redirect_uri = "http://insdate.free.idcfengye.com/AliPay/AliPayAuthorizedLoginCallback";
        try {
            String url = AliPayUtils.getAuthorizeUrl(redirect_uri);
            response.get().sendRedirect(url);
        } catch (Exception e) {
            log.error("支付宝授权登录异常.{}", e);
        }
    }

    /**
     * 支付宝授权登陆回调地址
     * @param app_auth_code b181c85f70c5d7ef
     */
    @GetMapping("/AliPayAuthorizedLoginCallback")
    @ResponseBody
    public void AliPayAuthorizedLogin(String app_auth_code) {
        try {
            userService.aliAuthorized(app_auth_code);
            String uri = "http://www.igetwell.org/";
            response.get().sendRedirect(uri);
        } catch (Exception e) {
            log.error("获取支付宝授权登录AccessToken异常.", e);
        }
    }

    @PostMapping("/preOrder")
    @ResponseBody
    public ResponseEntity preOrder(){
        return localAliPay.preOrder(PayType.AUTH, "GW201809082322155","活动报名认证费用", "0.01");
    }

    @PostMapping("/sanPay")
    @ResponseBody
    public ResponseEntity sanPay(){
        return localAliPay.sanPay("GW201809082322155","活动报名认证费用", "0.01");
    }


    @GetMapping("/aliPayReturn")
    public void aliPayReturn(){
        request.get();
    }

    @PostMapping("/aliPayNotify")
    public void aliPayNotify(){
        request.get();
    }
}
