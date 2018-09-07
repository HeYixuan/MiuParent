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

    /**
     * App Secret 应用密钥
     */
    public static final String APP_PRIVATE_KEY = "MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCw+mzVW46bDn1n\n" +
            "awhtC7WPfl96h8V9/Q30ALLX7livyuK9sHRpzGbjNMf+WgtQ2DygtTiBdWEh2HOc\n" +
            "RgWycdQvoM1suTeWOuV0blZ1VbBs5TLykfKakbVhHgb9hjWa7JGWc2g4qTEK69ko\n" +
            "u7Z7XO4zT/yyY+0brUn5S8NBGDSt47MUlLSToQPqgWOdm4lMlvqDmLbHQPNSp9AR\n" +
            "WjjvnITi9JuSR3rptnLut0Yc8RzcYNT5sUYwrOMHxfhidS1VQqjywKFpOcgkGayC\n" +
            "eqw/UpT0Fy0vhuY08e6D4ddkcl5lgFVMw7zne5gzztaNDzZwo883wrAvb9LDQOM8\n" +
            "sGINcFWpAgMBAAECggEAaNxIhfZUvZzNQuyRNoM8lYQMMH6nzqmUjeGoFfccRzSQ\n" +
            "OlKF93Xr9G1+nj9d+w3Uhmg5zcLtxW8JuStoDr4ROhMuBGCOBg5pjB4gTi9ydGMt\n" +
            "V7qQI3N4I8312FugAWZwMNO6ie/9pfnuVos6aUe7v12CXXSFteNsNDDmxPgBppGK\n" +
            "X8nrGsPWgLQRrNbD44Bm6nmDBHsNDDxVzZZYY2firuLeF0+RZAVtLm++93h0E9do\n" +
            "rmFteBP3Fly1JL6apxe/BsDFCNEsH17YzAXetv/cu+X2Hwth3dVu8v9as02dTQQr\n" +
            "1eJCu2T/hIqmFFK72fO5Xf13PqihmX068ud8aJw9bQKBgQDbDN9Rc2SXYMuWIY9q\n" +
            "dWsZ7Q2PsJRMk/sVr/IckA1D1XA4PzEx2nDayqaj1x8ZFOaNSzhsJ5i2Vd/5Dr3V\n" +
            "ghV8T+lIAnaI4xTwoDeukpUqkOeMu5Tt04G5EMcob3uvct98dLcImJB9meFp8ruI\n" +
            "iJM+L/QlevlFoo4bnB54htjynwKBgQDO1Mc6SVJqVRjNZJMUsVB6ICZJxc06lWU+\n" +
            "U6PksXcSVQEieKXSrzK0eHHutOyDgPCAv8ORQyGJbo4+3uwOMYBzwtmXlhIA50yN\n" +
            "qdmze1FDusc9AJ90+w1aZhGKmA6/zsLVT1Y3E4Aa/kesfhrZbvJsOAo15V/7nQ6Z\n" +
            "gQcbqZFatwKBgQCMafH06j0+9CNMt3KRUXc4BUa+JvjJJcq7mi9es9Bs/TKUO52z\n" +
            "UU0qUuEDAXDDySwIwoEGg1NW/jE2G4cAiARxzV/CcyG8maPgozNOSlQoFv72rX/H\n" +
            "+96Z3PFtMBle3An6Y264qeNlP/DI03n3CWUpZd/g7rU/N/ZUKH030WjcDQKBgEGj\n" +
            "98KAyJ4keaWduKwFhhPsJhqdov9nsGTyaH5I8BAqWBzXi1Ds9zudShNG6hTmE+3Y\n" +
            "bjmow3j5VD2Rw/rRLQIQIbxhDT+qKHqBIC09AtJq8ZZjnzeiAV/iKskAbxXiiaTm\n" +
            "8+aw0qQ+dQLCVsUQ1/EOa/ck36xb8Ok4sMfPrejLAoGAFzW9IFuJyOCGVm+yubix\n" +
            "2AEwgDPEbiBX1jFs7Q2sgGmkF8uA6ZKkejHCa9jHwMNVdB/gjvAQ08GmiYpVxL5u\n" +
            "m7P3HuQnzUmv+/as1AC5Gafr6DmKVfigdlKzgqzfkz7zG7aR32xO+1+t2KZczqy9\n" +
            "hC7eFFmMysN39q3ZPTVN1WA=";

    public static final String ALIPAY_PUBLIC_KEY = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAnnuQBJsOA86f0v0YBo3doKIHuKslWS6987HsbQbE27cQcMiR3l6BL4/elQ/teFL+D4YMkfx2zWdxP/ynatUFVhfXjRI5McGaqXTgoPhm+aCk6I8SxReYVaR4/jJsqBECkZDwt8a0iobyeroXgSBl2sFTgJ9W1nmvIRs0wGqF3RfZeuMShZdoinu5wxx36pOC0ixw23YT0JMkuORMMfakOV+yMLCHW+OFAhP6KJGW4tS7ijvOmSarKacBNm1WhRmMHHCgcW0N7lMw/lbzgbhlifdKLCfXo8jyPjqVQoaJO/hUivqozKb0fW5NzfVR7pLzwC/u1GhYG7RWf+kXZVqrYwIDAQAB";

    /**
     * 支付宝授权登录获取code
     * %s appid
     * %s redirect_uri
     * %s scope
     */
    private static final String API_AUTHORIZE_URL = "https://openauth.alipay.com/oauth2/appToAppAuth.htm?app_id=%s&scope=auth_userinfo,auth_base&redirect_uri=%s";


    /**
     * 支付授权登录根据code获取Access Token
     * %s appid
     * %s secret
     * %s code
     */
    private static final String API_AUTHORIZE_ACCESS_TOKEN = "http://example.com/doc/toAuthPage.html?app_id=%s&app_auth_code=%s";


    /**
     * 获取微信网页授权登录
     * @param redirectUrl
     * @return
     */
    public static String getAuthorizeUrl(String redirectUrl) throws Exception {
        try {
            redirectUrl = URLEncoder.encode(redirectUrl, "UTF-8");
            return String.format(API_AUTHORIZE_URL, APP_ID, redirectUrl);
        } catch (UnsupportedEncodingException e) {
            log.error("获得支付宝授权登录AccessToken异常", e);
            throw e;
        }

    }
}
