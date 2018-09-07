package org.igetwell.web.alipay;

import lombok.extern.slf4j.Slf4j;
import org.igetwell.common.utils.AliPayUtils;
import org.igetwell.system.users.service.IUserService;
import org.igetwell.web.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/AliPay")
@Slf4j
public class AliPayController extends BaseController {

    @Autowired
    private IUserService userService;

    @GetMapping("/AliPayAuthorizedLogin")
    public void AliPayAuthorizedLogin() {
        String redirect_uri = "http://insdate.free.ngrok.cc/AliPay/AliPayAuthorizedLoginCallback";
        try {
            String url = AliPayUtils.getAuthorizeUrl(redirect_uri);
            response.get().sendRedirect(url);
        } catch (Exception e) {
            log.error("支付宝授权登录异常.{}", e);
        }
    }

    @GetMapping("/AliPayAuthorizedLoginCallback")
    @ResponseBody
    public void AliPayAuthorizedLogin(HttpServletRequest request) {
        try {
            String code = request.getParameter("app_auth_code");
            userService.AliPayAuthorizedLogin(code);
            String uri = "http://www.igetwell.org/";
            response.get().sendRedirect(uri);
        } catch (Exception e) {
            log.error("获取支付宝授权登录AccessToken异常.", e);
        }
    }
}
