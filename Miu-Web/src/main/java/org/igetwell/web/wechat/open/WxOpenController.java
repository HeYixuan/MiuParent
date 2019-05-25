package org.igetwell.web.wechat.open;

import org.igetwell.common.utils.ResponseEntity;
import org.igetwell.web.BaseController;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 微信开放平台
 */
@RestController
@RequestMapping("/WxOpen")
public class WxOpenController extends BaseController {
    public static final String auth = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=%s&redirect_uri=%s&response_type=code&scope=snsapi_userinfo&state=STATE&component_appid=%s#wechat_redirect";

    //http://testwepay.free.idcfengye.com
    //e0a8fcee1c5b0821
    /*public String authCode(){
        String authCode = String.format(auth, "wxd709ce21db85e926", "www.baidu,com", "wx81aa03f442e8d692");
    }*/

    @ResponseBody
    @GetMapping(value = "/authorization/callBack")
    public ResponseEntity<String> authorizationCallBack(HttpServletRequest request, HttpServletResponse response,
                                                        @RequestBody String xml,
                                                        @RequestParam(value = "signature", required = false) String signature,
                                                        @RequestParam(value = "timestamp", required = false) String timeStamp,
                                                        @RequestParam(value = "nonce", required = false) String nonce,
                                                        @RequestParam(value = "encrypt_type", required = false) String encryptType,
                                                        @RequestParam(value = "msg_signature", required = false) String msgSignature
    ){
        return null;
    }

}
