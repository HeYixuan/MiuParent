package org.igetwell.common.utils;

import com.alibaba.fastjson.JSONObject;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

public class WeChatUtils {

    /**
     * APP ID 应用ID
     */
    private static final String APP_ID = "wx893db98985206df6";
    //private static final String APP_ID = "wx20082c1a905540a7";

    /**
     * App Secret 应用密钥
     */
    private static final String APP_SECRET = "a7681bcfbd70c0beb497715bfa1fb35a";
    //private static final String APP_SECRET = "931ff3e147646e2b259d4e3a73d383ac";

    /**
     * 获得 Access Token
     * %s appid
     * %s secret
     */
    private static final String API_ACCESS_TOKEN = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=%s&secret=%s";

    /**
     * 获得 Ticket
     * %s access_token
     * %s type
     */
    private static final String API_TICKET = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=%s&type=%s";

    /**
     * 微信授权登录获取code
     * %s appid
     * %s redirect_uri
     * %s scope
     */
    private static final String API_AUTHORIZE_URL = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=%s&redirect_uri=%s&response_type=code&scope=snsapi_userinfo&state=state#wechat_redirect";


    /**
     * 微信授权登录根据code获取Access Token
     * %s appid
     * %s secret
     * %s code
     */
    private static final String API_AUTHORIZE_ACCESS_TOKEN = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=%s&secret=%s&code=%s&grant_type=authorization_code";


    /**
     * http客户端
     */
    private static final CloseableHttpClient httpclient = HttpClients.createDefault();

    private static final Logger LOG = LoggerFactory.getLogger(WeChatUtils.class);

    private static WeChatCache cache = new WeChatCache();
    private static WXOauth2Token oauth2Token = new WXOauth2Token();

    /**
     * 获得通用接口访问令牌
     *
     * @return
     * @throws Exception
     */
    public static String getAccessToken() throws Exception {
        if (cache.getAccessToken() == null ||
                System.currentTimeMillis() > cache.getAccessTokenExpires()) {
            reGetAccessToken();
        }
        return cache.getAccessToken();
    }

    /**
     * 获得微信授权登录接口访问令牌
     *
     * @return
     * @throws Exception
     */
    public static String getAccessToken(String code) throws Exception {
        if (oauth2Token.getAccessToken() == null ||
                System.currentTimeMillis() > oauth2Token.getExpiresIn()) {
            reGetAccessToken(code);
        }
        return oauth2Token.getAccessToken();
    }

    /**
     * 获得JS API 调用凭证
     *
     * @param accessToken
     * @return
     * @throws Exception
     */
    public static String getJsApiTicket(String accessToken) throws Exception {
        if (cache.getJsApiTicket() == null ||
                System.currentTimeMillis() > cache.getJsApiTicketExpires()) {
            reGetJsApiTicket(accessToken);
        }
        return cache.getJsApiTicket();
    }



    private static void reGetAccessToken() throws Exception {
        HttpGet get = new HttpGet(String.format(API_ACCESS_TOKEN, APP_ID, APP_SECRET));
        CloseableHttpResponse httpResponse = null;
        try {
            httpResponse = httpclient.execute(get);
            HttpEntity httpEntity = httpResponse.getEntity();
            String responseData = EntityUtils.toString(httpEntity);
            int statusCode = httpResponse.getStatusLine().getStatusCode();
            LOG.debug("获得微信Access Token statusCode: {}, responseData: {}", statusCode, responseData);
            JSONObject data = JSONObject.parseObject(responseData);

            String accessToken = data.getString("access_token");
            long expiresIn = data.getLong("expires_in");
            cache.setAccessToken(accessToken);
            cache.setAccessTokenExpires(System.currentTimeMillis() + expiresIn * 1000);
        } catch (Exception e) {
            LOG.error("获得微信Access Token异常", e);
            throw e;
        } finally {
            try {
                httpResponse.close();
            } catch (IOException e) {}
        }
    }

    private static void reGetJsApiTicket(String accessToken) throws Exception {
        HttpGet get = new HttpGet(String.format(API_TICKET, accessToken, "jsapi"));
        CloseableHttpResponse httpResponse = null;
        try {
            httpResponse = httpclient.execute(get);
            HttpEntity httpEntity = httpResponse.getEntity();
            String responseData = EntityUtils.toString(httpEntity);
            int statusCode = httpResponse.getStatusLine().getStatusCode();
            LOG.debug("获得微信JS API Ticket statusCode: {}, responseData: {}", statusCode, responseData);
            JSONObject data = JSONObject.parseObject(responseData);

            String ticket = data.getString("ticket");
            long expiresIn = data.getLong("expires_in");

            cache.setJsApiTicket(ticket);
            cache.setJsApiTicketExpires(System.currentTimeMillis() + expiresIn * 1000);
        } catch (Exception e) {
            LOG.error("获得微信JS API Ticket异常", e);
            throw e;
        } finally {
            try {
                httpResponse.close();
            } catch (IOException e) {}
        }
    }

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
            LOG.error("获得微信JS API Ticket异常", e);
            throw e;
        }

    }


    /**
     * 根据code获取微信网页授权登录AccessToken
     * @param code
     * @throws Exception
     */
    public static void reGetAccessToken(String code) throws Exception{
        HttpGet get = new HttpGet(String.format(API_AUTHORIZE_ACCESS_TOKEN, APP_ID, APP_SECRET, code));
        CloseableHttpResponse httpResponse = null;
        try {
            httpResponse = httpclient.execute(get);
            HttpEntity httpEntity = httpResponse.getEntity();
            String responseData = EntityUtils.toString(httpEntity);
            int statusCode = httpResponse.getStatusLine().getStatusCode();
            LOG.debug("获得微信授权登录AccessToken statusCode: {}, responseData: {}", statusCode, responseData);
            JSONObject data = JSONObject.parseObject(responseData);

            String accessToken = data.getString("access_token");
            long expiresIn = data.getLong("expires_in");
            String refreshToken = data.getString("refresh_token");
            String openId = data.getString("openid");
            String scope = data.getString("scope");

            oauth2Token.setAccessToken(accessToken);
            oauth2Token.setExpiresIn(System.currentTimeMillis() + expiresIn * 1000);
            oauth2Token.setRefreshToken(refreshToken);
            oauth2Token.setOpenId(openId);
            oauth2Token.setScope(scope);
        } catch (Exception e) {
            LOG.error("获得微信授权登录AccessToken异常", e);
            throw e;
        } finally {
            try {
                httpResponse.close();
            } catch (IOException e) {}
        }
    }



    public static String getSignature(String jsApiTicket, String noncestr, long timestamp, String url) throws Exception{
        String string1 = String.format("jsapi_ticket=%s&noncestr=%s&timestamp=%s&url=%s", jsApiTicket, noncestr, timestamp, url);
        LOG.debug(string1);
        // SHA1
        return DigestUtils.sha1Hex(string1);
    }

    public static void main(String [] args){
        try {
            String token = getAccessToken();
            System.err.println("token = " + token);
            System.err.println("jsApiTicket = " + getJsApiTicket(token));

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
