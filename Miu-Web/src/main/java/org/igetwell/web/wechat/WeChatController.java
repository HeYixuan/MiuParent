package org.igetwell.web.wechat;

import lombok.extern.slf4j.Slf4j;
import org.igetwell.common.utils.CheckSignature;
import org.igetwell.common.utils.WeChatUtils;
import org.igetwell.system.users.service.IUserService;
import org.igetwell.web.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;


/**
 * @ClassName: WxPayController
 * @ProjectName MiuParent
 * @Description: 微信授权登录
 * @Author 何壹轩
 * @Date 2018/12/14 15:12
 * @Version 1.0
 */

@RestController
@RequestMapping("/WeChat")
@Slf4j
public class WeChatController extends BaseController {

    @Autowired
    private IUserService userService;


    @GetMapping("/authorLogin")
    public void wxAuthorLogin() {
        String redirectUri = "http://insdate.free.ngrok.cc/WeChat/redirectLogin";
        try {
            String url = WeChatUtils.getAuthorizeUrl(redirectUri);
            response.get().sendRedirect(url);
        } catch (Exception e) {
            log.error("微信授权登录异常.{}", e);
        }
    }

    /**
     * 微信授权回调
     * @param code
     */
    @GetMapping("/redirectLogin")
    @ResponseBody
    public void redirectLogin(String code) {
        try {
            userService.wxAuthorized(code);
            String uri = "http://www.igetwell.org/";
            response.get().sendRedirect(uri);
        } catch (Exception e) {
            log.error("获取微信授权登录AccessToken异常.", e);
        }
    }


    //de1ac07e2182f698
    //http://insdate.free.ngrok.cc
    /**
     * 校验微信服务器回调
     * @param signature
     * @param echostr
     * @param timestamp
     * @param nonce
     */
    @PostMapping("/callback")
    public void callback(String signature, String echostr, String timestamp, String nonce) {
        if (StringUtils.isEmpty(signature) || StringUtils.isEmpty(echostr) || StringUtils.isEmpty(timestamp) || StringUtils.isEmpty(nonce)){
            return;
        }
        boolean bool = CheckSignature.checkSignature(signature, timestamp, nonce);
        if (bool){
            try {
                response.get().getWriter().write(echostr);
            } catch (IOException e) {
                log.error("校验微信服务器异常.", e);
            }
        }
    }

}
