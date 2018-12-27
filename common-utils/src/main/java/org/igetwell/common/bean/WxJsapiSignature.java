package org.igetwell.common.bean;

/**
 * @ClassName: WxJsapiSignature
 * @ProjectName MiuParent
 * @Description: JS Api签名
 * @Author Yixuan He
 * @Date 2018/12/27 15:42
 * @Version 1.0
 */
public class WxJsapiSignature {

    private String appId;

    private String nonceStr;

    private long timestamp;

    private String url;

    private String signature;
}
