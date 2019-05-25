package org.igetwell.common.api;

import lombok.extern.slf4j.Slf4j;


/**
 * 公众号第三方平台
 * @Author Yixuan He
 */
@Slf4j
public class ComponentAPI extends BaseAPI{

    private static String API_COMPONENT_TOKEN_URL = "https://api.weixin.qq.com/cgi-bin/component/api_component_token";
    String API_CREATE_PREAUTHCODE_URL = "https://api.weixin.qq.com/cgi-bin/component/api_create_preauthcode?component_access_token=%s";
    String API_QUERY_AUTH_URL = "https://api.weixin.qq.com/cgi-bin/component/api_query_auth";
    String API_AUTHORIZER_TOKEN_URL = "https://api.weixin.qq.com/cgi-bin/component/api_authorizer_token";
    String API_GET_AUTHORIZER_INFO_URL = "https://api.weixin.qq.com/cgi-bin/component/api_get_authorizer_info";
    String API_GET_AUTHORIZER_OPTION_URL = "https://api.weixin.qq.com/cgi-bin/component/api_get_authorizer_option";
    String API_SET_AUTHORIZER_OPTION_URL = "https://api.weixin.qq.com/cgi-bin/component/api_set_authorizer_option";

    String COMPONENT_LOGIN_PAGE_URL = "https://mp.weixin.qq.com/cgi-bin/componentloginpage?component_appid=%s&pre_auth_code=%s&redirect_uri=%s&auth_type=%s&biz_appid=%s";

    /**
     * 手机端打开授权链接
     */
    String COMPONENT_MOBILE_LOGIN_PAGE_URL = "https://mp.weixin.qq.com/safe/bindcomponent?action=bindcomponent&no_scan=1&auth_type=3&component_appid=%s&pre_auth_code=%s&redirect_uri=%s&auth_type=%s&biz_appid=%s#wechat_redirect";
    String CONNECT_OAUTH2_AUTHORIZE_URL = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=%s&redirect_uri=%s&response_type=code&scope=%s&state=%s&component_appid=%s#wechat_redirect";

    /**
     * 用code换取oauth2的access token
     */
    String OAUTH2_ACCESS_TOKEN_URL = "https://api.weixin.qq.com/sns/oauth2/component/access_token?appid=%s&code=%s&grant_type=authorization_code&component_appid=%s";
    /**
     * 刷新oauth2的access token
     */
    String OAUTH2_REFRESH_TOKEN_URL = "https://api.weixin.qq.com/sns/oauth2/component/refresh_token?appid=%s&grant_type=refresh_token&refresh_token=%s&component_appid=%s";

    String MINIAPP_JSCODE_2_SESSION = "https://api.weixin.qq.com/sns/component/jscode2session?appid=%s&js_code=%s&grant_type=authorization_code&component_appid=%s";

    String CREATE_OPEN_URL= "https://api.weixin.qq.com/cgi-bin/open/create";

    /**
     * 快速创建小程序接口
     */
    String FAST_REGISTER_WEAPP_URL = "https://api.weixin.qq.com/cgi-bin/component/fastregisterweapp?action=create";
    String FAST_REGISTER_WEAPP_SEARCH_URL = "https://api.weixin.qq.com/cgi-bin/component/fastregisterweapp?action=search";

    /**
     * 生成授权页 URL
     *
     * @param component_appid 第三方平台ID
     * @param pre_auth_code   预授权码
     * @param redirect_uri    重定向URI
     * @return URL
     */
    public static String componentloginpage(String component_appid, String pre_auth_code, String redirect_uri) {
        return null;
    }

    /**
     * 生成授权页 URL
     *
     * @param component_appid 第三方平台ID
     * @param pre_auth_code   预授权码
     * @param redirect_uri    重定向URI
     * @param auth_type       要授权的帐号类型 <br>
     *                        1 则商户扫码后，手机端仅展示公众号 <br>
     *                        2 表示仅展示小程序 <br>
     *                        3 表示公众号和小程序都展示。<br>
     *                        如果为未制定，则默认小程序和公众号都展示。第三方平台开发者可以使用本字段来控制授权的帐号类型。
     * @return URL
     * @since 2.8.20
     */


    /**
     * 获取公众号第三方平台access_token
     *
     * @param component_appid         公众号第三方平台appid
     * @param component_appsecret     公众号第三方平台appsecret
     * @param component_verify_ticket 微信后台推送的ticket，此ticket会定时推送，具体请见本页末尾的推送说明
     * @return 公众号第三方平台access_token
     */



    /**
     * 获取预授权码
     *
     * @param component_access_token component_access_token
     * @param component_appid        公众号第三方平台appid
     * @return 预授权码
     */


    /**
     * 使用授权码换取公众号的授权信息
     *
     * @param component_appid     公众号第三方平台appid
     * @param authorization_code  授权code
     */




}
