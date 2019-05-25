package org.igetwell.common.bean;

        import lombok.Getter;
        import lombok.Setter;

@Getter
@Setter
public class WxOpenAuthorizerAccessToken {

    private String authorizerAccessToken;

    private int expiresIn = -1;
}
