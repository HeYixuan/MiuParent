package org.igetwell.web.pay;

import lombok.extern.slf4j.Slf4j;
import org.igetwell.common.utils.CheckoutUtil;
import org.igetwell.common.utils.WXOauth2Token;
import org.igetwell.common.utils.WeChatInfo;
import org.igetwell.common.utils.WeChatUtils;
import org.igetwell.web.BaseController;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;

@RestController
@RequestMapping("/Wx")
@Slf4j
public class WxController extends BaseController {


    @RequestMapping("/authorLogin")
    public void authorLogin() {
        String redirect_uri = "http://insdate.free.ngrok.cc/Wx/authorCallback";
        try {
            String url = WeChatUtils.getAuthorizeUrl(redirect_uri);
            response.get().sendRedirect(url);
        } catch (Exception e) {
            log.error("微信授权登录异常.{}", e);
        }
    }

    @RequestMapping("/authorCallback")
    public void authorCallback(String code, String state) {
        log.info("code:"+ code +",state:" + state);
        try {
            String accessToken = WeChatUtils.getAccessToken(code);
            //String accessToken = "12_QN_SXhaM1NEzKfdtzFHEOd_zQTowasVMVNvj0v-yY2_x0DOdUwpJremJCSoI-39CUL4wxAddOJZ0PMcW9WyjS-pmaGnpoblIGWycZJr6NgXXF9HGil7Vm56YErGEN9ZlBjJP30opRGBYAiZTRJRhAAANFN";
            System.err.println(accessToken);
            WXOauth2Token oauth2Token = WeChatUtils.oauth2Token;
            if (null != oauth2Token){
                WeChatUtils.getUserInfo(oauth2Token.getAccessToken(), oauth2Token.getOpenId());
                WeChatInfo weChatInfo = WeChatUtils.WeChatInfo;
                System.err.println("weChatInfo:" + weChatInfo.getOpenId());
            }



        } catch (Exception e) {
            log.error("获取微信授权登录AccessToken异常.{}",e);
        }
    }



    @RequestMapping("/callback")
    public void callback(String signature, String echostr, String timestamp, String nonce) {
        String token = "HeYixuan";

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

    //62df0725f11697cb
    //http://insdate.free.ngrok.cc
    public void callbacka(String signature, String echostr, String timestamp, String nonce){
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
