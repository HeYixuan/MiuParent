package org.igetwell.common.constans;

/**
 * 微信支付常量
 */
public class WXPayConstants {
    public static final String DOMAIN_API = "https://api.mch.weixin.qq.com";
    public static final String DOMAIN_API2 = "https://api2.mch.weixin.qq.com";
    public static final String DOMAIN_APIHK = "https://apihk.mch.weixin.qq.com";
    public static final String DOMAIN_APIUS = "https://apius.mch.weixin.qq.com";

    public static final String FAIL     = "FAIL";
    public static final String SUCCESS  = "SUCCESS";

    public static final String MICROPAY     = "/pay/micropay";
    public static final String UNIFIED_ORDER = "/pay/unifiedorder";
    public static final String ORDER_QUERY   = "/pay/orderquery";
    public static final String REVERSE     = "/secapi/pay/reverse";
    public static final String CLOSEORDER   = "/pay/closeorder";
    public static final String REFUND      = "/secapi/pay/refund";
    public static final String REFUND_QUERY = "/pay/refundquery";
    public static final String DOWNLOAD_BILL = "/pay/downloadbill";
    public static final String REPORT_URL       = "/payitil/report";
    public static final String SHORTURL_URL     = "/tools/shorturl";
    public static final String AUTHCODE_TO_OPENID = "/tools/authcodetoopenid";

    // sandbox
    public static final String SANDBOX_MICRO_PAY     = "/sandboxnew/pay/micropay";
    public static final String SANDBOX_UNIFIED_ORDER = "/sandboxnew/pay/unifiedorder";
    public static final String SANDBOX_ORDER_QUERY   = "/sandboxnew/pay/orderquery";
    public static final String SANDBOX_REVERSE      = "/sandboxnew/secapi/pay/reverse";
    public static final String SANDBOX_CLOSE_ORDER   = "/sandboxnew/pay/closeorder";
    public static final String SANDBOX_REFUND       = "/sandboxnew/secapi/pay/refund";
    public static final String SANDBOX_REFUND_QUERY  = "/sandboxnew/pay/refundquery";
    public static final String SANDBOX_DOWNLOAD_BILL = "/sandboxnew/pay/downloadbill";
    public static final String SANDBOX_REPORT      = "/sandboxnew/payitil/report";
    public static final String SANDBOX_SHORTURL     = "/sandboxnew/tools/shorturl";
    public static final String SANDBOX_AUTHCODE_TO_OPENID = "/sandboxnew/tools/authcodetoopenid";


    /**
     * 微信第三方平台
     */
    public static String API_COMPONENT_TOKEN_URL = "https://api.weixin.qq.com/cgi-bin/component/api_component_token";
    public static String API_CREATE_PREAUTHCODE_URL = "https://api.weixin.qq.com/cgi-bin/component/api_create_preauthcode";
    public static String API_QUERY_AUTH_URL = "https://api.weixin.qq.com/cgi-bin/component/api_query_auth";
    public static String API_AUTHORIZER_TOKEN_URL = "https://api.weixin.qq.com/cgi-bin/component/api_authorizer_token";
    public static String API_GET_AUTHORIZER_INFO_URL = "https://api.weixin.qq.com/cgi-bin/component/api_get_authorizer_info";
    public static String API_GET_AUTHORIZER_OPTION_URL = "https://api.weixin.qq.com/cgi-bin/component/api_get_authorizer_option";
    public static String API_SET_AUTHORIZER_OPTION_URL = "https://api.weixin.qq.com/cgi-bin/component/api_set_authorizer_option";

    String COMPONENT_LOGIN_PAGE_URL = "https://mp.weixin.qq.com/cgi-bin/componentloginpage?component_appid=%s&pre_auth_code=%s&redirect_uri=%s";
    /**
     * 手机端打开授权链接
     */
    String COMPONENT_MOBILE_LOGIN_PAGE_URL = "https://mp.weixin.qq.com/safe/bindcomponent?action=bindcomponent&no_scan=1&auth_type=3&component_appid=%s&pre_auth_code=%s&redirect_uri=%s&auth_type=xxx&biz_appid=xxx$#wechat_redirect";
    String CONNECT_OAUTH2_AUTHORIZE_URL = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=%s&redirect_uri=%s&response_type=code&scope=%s&state=%s&component_appid=%s#wechat_redirect";

    /**
     * 用code换取oauth2的access token
     */
    String OAUTH2_ACCESS_TOKEN_URL = "https://api.weixin.qq.com/sns/oauth2/component/access_token?appid=%s&code=%s&grant_type=authorization_code&component_appid=%s";
    /**
     * 刷新oauth2的access token
     */
    String OAUTH2_REFRESH_TOKEN_URL = "https://api.weixin.qq.com/sns/oauth2/component/refresh_token?appid=%s&grant_type=refresh_token&refresh_token=%s&component_appid=%s";
}
