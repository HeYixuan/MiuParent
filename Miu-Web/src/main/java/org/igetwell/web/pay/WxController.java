package org.igetwell.web.pay;

import lombok.extern.slf4j.Slf4j;
import org.apache.commons.codec.digest.DigestUtils;
import org.igetwell.common.utils.CheckoutUtil;
import org.igetwell.web.BaseController;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

@RestController
@RequestMapping("/Wx")
@Slf4j
public class WxController extends BaseController {



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
