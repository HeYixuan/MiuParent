package org.igetwell.common.bean;

import lombok.Data;

/**
 * @ClassName: WxCardApiSignature
 * @ProjectName MiuParent
 * @Description: 卡券Api签名
 * @Author Yixuan He
 * @Date 2018/12/27 15:41
 * @Version 1.0
 */
@Data
public class WxCardApiSignature {

    private String appId;

    private String cardId;

    private String cardType;

    private String locationId;

    private String code;

    private String openId;

    private Long timestamp;

    private String nonceStr;

    private String signature;
}
