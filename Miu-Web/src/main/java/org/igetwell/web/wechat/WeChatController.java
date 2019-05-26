package org.igetwell.web.wechat;

import com.jfinal.weixin.sdk.encrypt.AesException;
import com.jfinal.weixin.sdk.encrypt.WXBizMsgCrypt;
import lombok.extern.slf4j.Slf4j;
import org.igetwell.common.utils.CheckSignature;
import org.igetwell.common.utils.WeChatUtils;
import org.igetwell.system.users.service.IUserService;
import org.igetwell.web.BaseController;
import org.igetwell.wechat.open.api.IWxOpenComponentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
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

    @Autowired
    private IWxOpenComponentService wxOpenComponentService;


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


    /**
     * 微信开放平台处理授权事件推送Ticket
     * @param request
     * @param nonce
     * @param timestamp
     * @param msg_signature
     */
    @RequestMapping(value = "/event/authorize")
    public void acceptAuthorizeEvent(HttpServletRequest request, String nonce, String timestamp, String msg_signature){
        try {
            render("success");
            wxOpenComponentService.processAuthorizeEvent(request, nonce, timestamp, msg_signature);
        } catch (Exception e) {
            log.error("微信开放平台处理授权事件推送Ticket失败.", e);
        }
    }

    /**
     * 全网发布接入检测消息
     */
    @RequestMapping(value = "/{appid}/checkAllNetWork")
    public void checkWechatAllNetwork(@PathVariable("appid") String appid, String nonce, String timestamp, String msg_signature){
        try {
            wxOpenComponentService.checkWechatAllNetwork(request.get(), response.get(), nonce, timestamp, msg_signature);
        } catch (Exception e) {
            log.error("全网发布接入检测消息失败.", e);
        }
    }

    @GetMapping("/getComponentAccessToken")
    public void getComponentAccessToken(){
        wxOpenComponentService.getComponentAccessToken(true);
    }

    @GetMapping("/preAuth")
    public void preAuth(String redirectUri){
        try {
            String redirectUrl = wxOpenComponentService.getPreAuthUrl(redirectUri, "2", null);
            response.get().sendRedirect(redirectUrl);
        } catch (Exception e) {
            log.error("获取预授权失败.", e);
        }
    }

}
