package org.igetwell.common.bean;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

/**
 * 使用授权码换取公众号的授权信息
 */

@Getter
@Setter
public class WxOpenComponentAuthorization {
    private String authorizerAppid;
    private String authorizerAccessToken;
    private long expiresIn;
    private String authorizerRefreshToken;
    private List<Integer> funcInfo;
}
