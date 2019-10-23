package org.igetwell.wechat.open.api;

import org.igetwell.common.bean.ComponentAuthorization;
import org.igetwell.common.bean.WxOpenAuthorizerAccessToken;
import org.igetwell.common.bean.WxOpenComponentAccessToken;

public interface IWxOpenConfigStorage {

    /**
     * 更新第三方平台access_token
     * @param componentAccessToken
     */
    void updateComponentAccessToken(WxOpenComponentAccessToken componentAccessToken);

    /**
     * 更新第三方平台access_token
     *
     * @param componentAccessToken 新的accessToken值
     * @param expiresInSeconds     过期时间，以秒为单位
     */
    void updateComponentAccessToken(String componentAccessToken, long expiresInSeconds);

    void updateComponentAuthorization(ComponentAuthorization authorization);

}
