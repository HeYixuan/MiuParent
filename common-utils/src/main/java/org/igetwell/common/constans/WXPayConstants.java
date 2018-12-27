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
}
