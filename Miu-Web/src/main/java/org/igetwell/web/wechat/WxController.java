package org.igetwell.web.wechat;

import lombok.extern.slf4j.Slf4j;
import org.igetwell.common.utils.CheckoutUtil;
import org.igetwell.common.utils.WeChatUtils;
import org.igetwell.service.IUserService;
import org.igetwell.web.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;

@RestController
@RequestMapping("/Wx")
@Slf4j
public class WxController extends BaseController {

    @Autowired
    private IUserService userService;


    @PostMapping("/WxAuthorizedLogin")
    public void WxAuthorizedLogin() {
        String redirect_uri = "http://insdate.free.ngrok.cc/Wx/WxAuthorizedLoginCallback";
        try {
            String url = WeChatUtils.getAuthorizeUrl(redirect_uri);
            response.get().sendRedirect(url);
        } catch (Exception e) {
            log.error("微信授权登录异常.{}", e);
        }
    }

    @GetMapping("/WxAuthorizedLoginCallback")
    public void WxAuthorizedLogin(String code) {
        try {
            userService.WxAuthorizedLogin(code);
        } catch (Exception e) {
            log.error("获取微信授权登录AccessToken异常.", e);
        }
    }


    //62df0725f11697cb
    //http://insdate.free.ngrok.cc
    @PostMapping("/callback")
    public void callback(String signature, String echostr, String timestamp, String nonce) {
        if (StringUtils.isEmpty(signature) || StringUtils.isEmpty(echostr) || StringUtils.isEmpty(timestamp) || StringUtils.isEmpty(nonce)){
            return;
        }
        boolean bool = CheckoutUtil.checkSignature(signature, timestamp, nonce);
        System.err.println(bool);
        if (bool){
            try {
                response.get().getWriter().write(echostr);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

}
