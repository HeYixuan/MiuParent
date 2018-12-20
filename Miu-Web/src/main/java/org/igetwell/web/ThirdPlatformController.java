package org.igetwell.web;

import org.igetwell.common.utils.HttpClientUtils;

/**
 * @ClassName: ThirdPlatform
 * @ProjectName MiuParent
 * @Description: 第三方平台授权
 * @Author user
 * @Date 2018/12/19 19:44
 * @Version 1.0
 */
public class ThirdPlatformController {


    public void auth(){
        String componentAppId = "wxc50f8ee392ec5a0a"; //第三方平台appId
        String appId = "wx13c67157a3d0a74e"; //公众号appId
        String redirectUrl = "";
        String url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=%s&redirect_uri=%s&response_type=code&scope=%s&state=STATE&component_appid=%s#wechat_redirect";
        String authUrl = String.format(url, appId, redirectUrl, "snsapi_userinfo", componentAppId);

    }
}
