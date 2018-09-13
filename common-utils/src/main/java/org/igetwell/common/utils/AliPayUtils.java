package org.igetwell.common.utils;

import lombok.extern.slf4j.Slf4j;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

@Slf4j
public class AliPayUtils {

    /**
     * APP ID 应用ID
     */
    public static final String APP_ID = "2018090761263694";

    public static final String APP_PRIVATE_KEY = "MIIEwAIBADANBgkqhkiG9w0BAQEFAASCBKowggSmAgEAAoIBAQDUqZBGYLCIPi8Y\n" +
            "1OzZthC+BiKM+JUXZb080LAPXifl0i8ItpG74PkBuuGb4ihDrWxTAglBEfaC+OZX\n" +
            "2c5+IJ8Q4Ukr4p8629t9Le9GcELlSym0El5b8CujcDlSVJk9zjnLSbFX/fpNXSx1\n" +
            "cEoWlBKUEwjSKWC1IXRmvxHbYbOInfghXaiWipDSjtOM9w1LC2uLCqNG7HYX++Ac\n" +
            "IIb1r7I4cHnezB0+C+t0v7l7823PyPR+hmV/MFWstkxf1RT/tNdUk/CAiKza9Xu1\n" +
            "4ioimF/fvYHpO798zsDlxG0nUp1iP2rgTMllTMDSkjz77QoCpgVQK8Anz5TY3e7y\n" +
            "w1amhtJzAgMBAAECggEBAM24sm7CfkNuFFVrNSxuqceJW8cPefrGWsgIASj8po/2\n" +
            "QbWmF1iui3OW+0S3BMhjbZTnNViTLesJKJr3goAUwourxAMGGY7wvGVeGEgFtVDm\n" +
            "4xLlag56SVyz5V+1owBdDR+QzFQYxxgr+CQrWiB5YXeI6lGT4Y+XK2lxkK6u1uRi\n" +
            "WQVimncBpHlsnd8zt05tpK/nYFnG7hW3yMyIkw9ynKXPE88u0GhGUiHpIpGuzzhh\n" +
            "M8cHOnX70WdgS2DU7Y1zOtdghOP4I6ua/CG0B+3LFuSRXSWBorP2TQdGd+BzxM6r\n" +
            "5RbBO1P0WuuCU54mFNcOwE12TKb7XowR67s9GLVGYyECgYEA6l4YK/SgE1PaA23j\n" +
            "0Ybx9yZhWaQliMgjbxy14DgOu1mkbJoshzu9RHaRLSDuVEswmY/scyvG/qXCXDZB\n" +
            "ivq22yG9R5+Zqrl4TYA5Hi6tX7S3HrQ13sn6EVVvoD2XDukVIF9j5mqxbkALubLe\n" +
            "F5bN/EcT07XfgcQmKy73s6QgTjkCgYEA6EqYBAcRJuZwCniRCe28OrNJ4p9MmdYL\n" +
            "V5TVInLCALJx6uM7mV9Onk1en18DD5Z5PvbLXY/JSO4GCpk7vmghJ6Dw0yFPoXA1\n" +
            "+c1JMc45LFhQXVD0XkHYEMzUkMzGDut0EvJFTsGG726v9lNZL3BLnv9LfPm1+EmC\n" +
            "LnW0ovm/JgsCgYEAolV+hKOyZPDFp25sSGsiGkCZWY/a97043fOS/rWVbquOujKn\n" +
            "+Rul41AFCq8upXBXP2ZzLur5sNR7pYdnKq6yDWJ3Sq7/r0M8UuInrgJC0HHKDRhh\n" +
            "3+kirvLwmJtQkGFd4shv19+6+lSeSofcUZaBIubQkun84FNO5MZpiCJ8xfECgYEA\n" +
            "n30f1JwZjbDoOng/dSayd0dEMoIXcQRCc1av4+ARDbN3fcOY1xxV+WC72Aa/LkOt\n" +
            "aaq/RLUFibpLkZlWKMyL/w6EayHS79AAb0wgtj6WiLj2LKv5rIHe3OIWDHlcfz/w\n" +
            "SVXoekNr5xcDX8goUubyNO+qH9u/sgKejFGqvb9mG7MCgYEAk2eckNViqRrLbmIx\n" +
            "rQeSAVFgI0suoEGKahrGZwanIJ2YbPveawPnNdB6Le3Cl0CwcMHRVQbJB9hyn+oh\n" +
            "zH5HrWZoUD8CT+crCb2bqK/UbbfqP/GNi9UYu2wvcTa6RQkYGBmZkVFLR/nMevxW\n" +
            "9U2buAL0DXTyq0Xo7JuVGhYQnFM=";

    public static final String ALIPAY_PUBLIC_KEY = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAnnuQBJsOA86f0v0YBo3doKIHuKslWS6987HsbQbE27cQcMiR3l6BL4/elQ/teFL+D4YMkfx2zWdxP/ynatUFVhfXjRI5McGaqXTgoPhm+aCk6I8SxReYVaR4/jJsqBECkZDwt8a0iobyeroXgSBl2sFTgJ9W1nmvIRs0wGqF3RfZeuMShZdoinu5wxx36pOC0ixw23YT0JMkuORMMfakOV+yMLCHW+OFAhP6KJGW4tS7ijvOmSarKacBNm1WhRmMHHCgcW0N7lMw/lbzgbhlifdKLCfXo8jyPjqVQoaJO/hUivqozKb0fW5NzfVR7pLzwC/u1GhYG7RWf+kXZVqrYwIDAQAB";



    /**
     * 支付宝授权登录获取code
     * %s appid
     * %s redirect_uri
     * %s scope
     */
    //private static final String API_AUTHORIZE_URL = "https://openauth.alipay.com/oauth2/publicAppAuthorize.htm?app_id=%s&scope=auth_user&redirect_uri=%s&state=state";  //APP授权登陆
    private static final String API_AUTHORIZE_URL = "https://openauth.alipay.com/oauth2/appToAppAuth.htm?app_id=%s&redirect_uri=%s";   //第三方授权登陆

    /**
     * 获取支付宝网页授权登录
     * @param redirectUrl
     * @return
     */
    public static String getAuthorizeUrl(String redirectUrl) throws Exception {
        try {
            redirectUrl = URLEncoder.encode(redirectUrl, "UTF-8");
            return String.format(API_AUTHORIZE_URL, APP_ID, redirectUrl);
        } catch (UnsupportedEncodingException e) {
            log.error("获得支付宝网页授权登录地址异常", e);
            throw e;
        }

    }
}
