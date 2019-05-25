package org.igetwell.wechat.open.api.impl;

import lombok.extern.slf4j.Slf4j;


import org.igetwell.common.bean.WxOpenComponentAccessToken;
import org.igetwell.common.bean.WxOpenComponentAuthorization;
import org.igetwell.common.bean.WxOpenPreAuthAuthorization;
import org.igetwell.common.utils.GsonUtils;
import org.igetwell.common.utils.HttpClientUtils;
import org.igetwell.wechat.open.api.IWxOpenComponentService;
import org.igetwell.wechat.open.api.IWxOpenConfigStorage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.net.URLEncoder;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 微信开放平台接口
 */
@Service
@Slf4j
public class WxOpenComponentService implements IWxOpenComponentService {

    @Value("${componentAppId}")
    private String componentAppId;

    @Value("${componentAppSecret}")
    private String componentAppSecret;

    @Value("${componentVerifyTicket}")
    private String componentVerifyTicket;

    @Autowired
    public IWxOpenConfigStorage wxOpenConfigStorage;

    @Override
    public String getComponentAccessToken(boolean forceRefresh) {
        if (forceRefresh){
            Map<String, String> params = new ConcurrentHashMap<>();
            params.put("component_appid", componentAppId);
            params.put("component_appsecret", componentAppSecret);
            params.put("component_verify_ticket", componentVerifyTicket);
            String response = HttpClientUtils.getInstance().sendHttpPost(API_COMPONENT_TOKEN_URL, params, "UTF-8");
            WxOpenComponentAccessToken wxOpenComponentAccessToken = GsonUtils.fromJson(response, WxOpenComponentAccessToken.class);
            updateComponentAccessToken(wxOpenComponentAccessToken);
        }
        return null;
    }

    @Override
    public String getPreAuthUrl(String redirectURI) throws Exception {
        return getPreAuthUrl(redirectURI, null, null);
    }

    @Override
    public String getPreAuthUrl(String redirectURI, String authType, String bizAppid) throws Exception {
        return createPreAuthUrl(redirectURI, authType, bizAppid, false);
    }

    @Override
    public String getMobilePreAuthUrl(String redirectURI) throws Exception {
        return getMobilePreAuthUrl(redirectURI, null, null);
    }

    @Override
    public String getMobilePreAuthUrl(String redirectURI, String authType, String bizAppid) throws Exception {
        return createPreAuthUrl(redirectURI, authType, bizAppid, true);
    }

    /**
     * 使用授权码换取公众号的授权信息
     * @param authorizationCode  授权code
     */
    @Override
    public void getQueryAuth(String authorizationCode) throws Exception {
        Map<String, String> params = new ConcurrentHashMap<>();
        params.put("component_appid", componentAppId);
        params.put("authorization_code", authorizationCode);
        String response = HttpClientUtils.getInstance().sendHttpPost(API_QUERY_AUTH_URL, params, "UTF-8");
        WxOpenComponentAuthorization authorization = GsonUtils.fromJson(response, WxOpenComponentAuthorization.class);
        if (StringUtils.isEmpty(authorization)){
            return;
        }
        /*if (authorization.getAuthorizerAccessToken() != null) {
            getWxOpenConfigStorage().updateAuthorizerAccessToken(authorizationInfo.getAuthorizerAppid(),
                    authorizationInfo.getAuthorizerAccessToken(), authorizationInfo.getExpiresIn());
        }
        if (authorizationInfo.getAuthorizerRefreshToken() != null) {
            getWxOpenConfigStorage().setAuthorizerRefreshToken(authorizationInfo.getAuthorizerAppid(), authorizationInfo.getAuthorizerRefreshToken());
        }*/
    }


    /**
     * 创建预授权链接
     *
     * @param redirectURI
     * @param authType
     * @param bizAppid
     * @param isMobile    是否移动端预授权
     * @return
     */
    private String createPreAuthUrl(String redirectURI, String authType, String bizAppid, boolean isMobile) throws Exception{
        Map<String, String> params = new ConcurrentHashMap<>();
        params.put("component_appid", "1231132131"); //这个AppId可以从缓存里面取
        //String PREAUTHCODE_URL = String.format(API_CREATE_PREAUTHCODE_URL, "accessToken");

        String response = HttpClientUtils.getInstance().sendHttpPost(String.format(API_CREATE_PREAUTHCODE_URL, "accessToken"), params, "UTF-8");
        WxOpenPreAuthAuthorization preAuth = GsonUtils.fromJson(response, WxOpenPreAuthAuthorization.class);

        String preAuthUrl;
        if (isMobile){
            preAuthUrl = String.format(COMPONENT_MOBILE_LOGIN_PAGE_URL, componentAppId, preAuth.getPreAuthCode(), URLEncoder.encode(redirectURI, "UTF-8"), authType, bizAppid);
        } else {
            preAuthUrl = String.format(COMPONENT_LOGIN_PAGE_URL, componentAppId, preAuth.getPreAuthCode(), URLEncoder.encode(redirectURI, "UTF-8"), authType, bizAppid);
        }

        return preAuthUrl;
    }


    @Override
    public void updateComponentAccessToken(WxOpenComponentAccessToken componentAccessToken) {
        updateComponentAccessToken(componentAccessToken.getComponentAccessToken(), componentAccessToken.getExpiresIn());
    }


    private void updateComponentAccessToken(String componentAccessToken, long expiresInSeconds) {
        WxOpenComponentAccessToken wxOpenComponentAccessToken = new WxOpenComponentAccessToken();
        wxOpenComponentAccessToken.setComponentAccessToken(componentAccessToken);
        long expire = System.currentTimeMillis() + (expiresInSeconds - 200) * 1000L;
        wxOpenComponentAccessToken.setExpiresIn(expire);
    }

    public static void main(String [] args) throws Exception {
        WxOpenComponentService service = new WxOpenComponentService();
        service.createPreAuthUrl(null, null,null,false);
    }
}
