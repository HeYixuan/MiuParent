package org.igetwell.wechat.open.api.impl;

import com.jfinal.weixin.sdk.encrypt.AesException;
import com.jfinal.weixin.sdk.encrypt.WXBizMsgCrypt;
import lombok.extern.slf4j.Slf4j;


import org.apache.http.client.methods.HttpUriRequest;
import org.apache.http.client.methods.RequestBuilder;
import org.apache.http.entity.StringEntity;
import org.dom4j.Element;
import org.igetwell.common.bean.AuthorizationInfo;
import org.igetwell.common.bean.WxOpenComponentAccessToken;
import org.igetwell.common.bean.WxOpenComponentAuthorization;
import org.igetwell.common.bean.WxOpenPreAuthAuthorization;
import org.igetwell.common.constans.RedisKey;
import org.igetwell.common.local.HttpKit;
import org.igetwell.common.utils.*;
import org.igetwell.wechat.open.api.IWxOpenComponentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.nio.charset.Charset;
import java.util.HashMap;
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

    @Value("${componentToken}")
    private String componentToken;

    @Value("${encodingAesKey}")
    private String encodingAesKey;

    private String componentVerifyTicket;

    @Autowired
    private RedisUtils redisUtils;

    @Autowired
    public WxOpenInMemoryConfigStorage wxOpenConfigStorage;


    /*@PostConstruct
    public void init(){
        componentVerifyTicket = (String) redisTemplate.opsForValue().get(RedisKey.COMPONENT_VERIFY_TICKET);
    }*/

    @Override
    public String getComponentAccessToken(boolean forceRefresh) throws Exception{
        /*if (forceRefresh){
            componentVerifyTicket = (String) redisUtils.get(RedisKey.COMPONENT_VERIFY_TICKET);
            Map<String, String> params = new ConcurrentHashMap<>();
            params.put("component_appid", componentAppId);
            params.put("component_appsecret", componentAppSecret);
            params.put("component_verify_ticket", componentVerifyTicket);
            String response = HttpClientUtils.getInstance().sendHttpPost(API_COMPONENT_TOKEN_URL, GsonUtils.toJson(params), "UTF-8");
            WxOpenComponentAccessToken wxOpenComponentAccessToken = GsonUtils.fromJson(response, WxOpenComponentAccessToken.class);
            redisUtils.set(RedisKey.COMPONENT_ACCESS_TOKEN, wxOpenComponentAccessToken.getComponentAccessToken(), wxOpenComponentAccessToken.getExpiresIn()); //写入redis
            wxOpenConfigStorage.updateComponentAccessToken(wxOpenComponentAccessToken); //写入内存
        }
        return wxOpenConfigStorage.getComponentAccessToken();*/

        /*if (forceRefresh){
            componentVerifyTicket = (String) redisUtils.get(RedisKey.COMPONENT_VERIFY_TICKET);
            if(StringUtils.isEmpty(componentVerifyTicket)){
                throw new Exception("获取微信开放平台验证票据失败");
            }
            Map<String, String> params = new ConcurrentHashMap<>();
            params.put("component_appid", componentAppId);
            params.put("component_appsecret", componentAppSecret);
            params.put("component_verify_ticket", componentVerifyTicket);
            String response = HttpClientUtils.getInstance().sendHttpPost(API_COMPONENT_TOKEN_URL, GsonUtils.toJson(params));
            WxOpenComponentAccessToken componentAccessToken = GsonUtils.fromJson(response, WxOpenComponentAccessToken.class);
            if (!StringUtils.isEmpty(componentAccessToken) || !StringUtils.isEmpty(componentAccessToken.getComponentAccessToken())){
                redisUtils.set(RedisKey.COMPONENT_ACCESS_TOKEN, componentAccessToken.getComponentAccessToken(), componentAccessToken.getExpiresIn()); //写入redis
                wxOpenConfigStorage.updateComponentAccessToken(componentAccessToken); //写入内存
            }
        }*/
        componentVerifyTicket = (String) redisUtils.get(RedisKey.COMPONENT_VERIFY_TICKET);
        if(StringUtils.isEmpty(componentVerifyTicket)){
            throw new Exception("获取微信开放平台验证票据失败");
        }
        Map<String, Object> params = new ConcurrentHashMap<>();
        params.put("component_appid", componentAppId);
        params.put("component_appsecret", componentAppSecret);
        params.put("component_verify_ticket", componentVerifyTicket);
        String response = HttpClientUtils.getInstance().sendHttpPost(API_COMPONENT_TOKEN_URL, null, params, "UTF-8");
        WxOpenComponentAccessToken componentAccessToken = GsonUtils.fromJson(response, WxOpenComponentAccessToken.class);
        if (!StringUtils.isEmpty(componentAccessToken) || !StringUtils.isEmpty(componentAccessToken.getComponentAccessToken())){
            redisUtils.set(RedisKey.COMPONENT_ACCESS_TOKEN, componentAccessToken.getComponentAccessToken(), componentAccessToken.getExpiresIn()); //写入redis
            wxOpenConfigStorage.updateComponentAccessToken(componentAccessToken); //写入内存
        }
        return wxOpenConfigStorage.getComponentAccessToken();
    }

    public String getApiCommentToken(boolean forceRefresh) throws Exception{
        componentVerifyTicket = (String) redisUtils.get(RedisKey.COMPONENT_VERIFY_TICKET);
        if(StringUtils.isEmpty(componentVerifyTicket)){
            throw new Exception("获取微信开放平台验证票据失败");
        }
        Map<String, String> params = new ConcurrentHashMap<>();
        params.put("component_appid", componentAppId);
        params.put("component_appsecret", componentAppSecret);
        params.put("component_verify_ticket", componentVerifyTicket);

        HttpUriRequest httpUriRequest = RequestBuilder
                .post()
                .setHeader(APPLICATION_JSON)
                .setUri(API_COMPONENT_TOKEN_URL)
                .setEntity(new StringEntity(GsonUtils.toJson(params), Charset.forName("UTF-8")))
                .build();
        String response = HttpClientUtils.getInstance().sendHttpPost(httpUriRequest.getURI().toString(), "UTF-8");
        WxOpenComponentAccessToken componentAccessToken = GsonUtils.fromJson(response, WxOpenComponentAccessToken.class);
        if (!StringUtils.isEmpty(componentAccessToken) || !StringUtils.isEmpty(componentAccessToken.getComponentAccessToken())){
            redisUtils.set(RedisKey.COMPONENT_ACCESS_TOKEN, componentAccessToken.getComponentAccessToken(), componentAccessToken.getExpiresIn()); //写入redis
            wxOpenConfigStorage.updateComponentAccessToken(componentAccessToken); //写入内存
        }
        return wxOpenConfigStorage.getComponentAccessToken();
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
    public void getQueryAuth(String authorizationCode) {
        Map<String, Object> params = new ConcurrentHashMap<>();
        params.put("component_appid", componentAppId);
        params.put("authorization_code", authorizationCode);
        String response = HttpClientUtils.getInstance().sendHttpPost(String.format(API_QUERY_AUTH_URL, wxOpenConfigStorage.getComponentAccessToken()), null, params, "UTF-8");
        AuthorizationInfo authorizationInfo = GsonUtils.fromJson(response, AuthorizationInfo.class);
        if (StringUtils.isEmpty(authorizationInfo)){
            return;
        }

        if (!StringUtils.isEmpty(authorizationInfo.getAuthorizationInfo().getAuthorizerAccessToken()) && !StringUtils.isEmpty(authorizationInfo.getAuthorizationInfo().getAuthorizerRefreshToken())) {
            redisUtils.set(RedisKey.COMPONENT_AUTHORIZATION + authorizationInfo.getAuthorizationInfo().getAuthorizerAppid(), GsonUtils.toJson(authorizationInfo.getAuthorizationInfo()), authorizationInfo.getAuthorizationInfo().getExpiresIn());
            wxOpenConfigStorage.updateComponentAuthorization(authorizationInfo.getAuthorizationInfo()); //写入内存
        }

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

        String preAuthCode = (String) redisUtils.get(RedisKey.COMPONENT_PRE_AUTH_CODE);
        if (StringUtils.isEmpty(preAuthCode)){
            Map<String, Object> params = new ConcurrentHashMap<>();
            params.put("component_appid", componentAppId); //这个AppId可以从缓存里面取
            String response = HttpClientUtils.getInstance().sendHttpPost(String.format(API_CREATE_PREAUTHCODE_URL, wxOpenConfigStorage.getComponentAccessToken()), null, params, "UTF-8");
            WxOpenPreAuthAuthorization preAuth = GsonUtils.fromJson(response, WxOpenPreAuthAuthorization.class);
            redisUtils.set(RedisKey.COMPONENT_PRE_AUTH_CODE, preAuth.getPreAuthCode(), preAuth.getExpiresIn());
            preAuthCode = preAuth.getPreAuthCode();
        }

        String preAuthUrl;
        if (isMobile){
            preAuthUrl = String.format(COMPONENT_MOBILE_LOGIN_PAGE_URL, componentAppId, preAuthCode, URLEncoder.encode(redirectURI, "UTF-8"), authType, bizAppid);
        } else {
            preAuthUrl = String.format(COMPONENT_LOGIN_PAGE_URL, componentAppId, preAuthCode, URLEncoder.encode(redirectURI, "UTF-8"), authType, bizAppid);
        }
        return preAuthUrl;
    }


    /**
     * 微信开放平台处理授权事件的推送
     *
     * @param request
     * @throws IOException
     * @throws AesException
     */
    public void processAuthorizeEvent(HttpServletRequest request, String nonce, String timestamp, String msgSignature) throws Exception {

        String xml = HttpKit.readData(request);
        log.info("第三方平台全网发布-----------------------原始 Xml={}", xml);
        WXBizMsgCrypt pc = new WXBizMsgCrypt(componentToken, encodingAesKey, componentAppId);
        log.info("第三方平台全网发布-----------------------解密 WXBizMsgCrypt 成功.");
        String xml1 = pc.decryptMsg(msgSignature, timestamp, nonce, xml);
        log.info("第三方平台全网发布-----------------------解密后 Xml={}", xml1);
        processAuthorizationEvent(xml1);

    }

    /**
     * 保存微信开放平台Ticket
     *
     * @param xml
     */
    private void processAuthorizationEvent(String xml) throws Exception {
        Element element = XmlUtils.parseXml(xml);
        String infoType = XmlUtils.elementText(element,"InfoType");
        if (!StringUtils.isEmpty(infoType)){
            //验证票据component_verify_ticket
            if (infoType.equalsIgnoreCase("component_verify_ticket")){
                String ticket = XmlUtils.elementText(element,"ComponentVerifyTicket");
                log.info("第三方平台全网发布-----------------------解密后 ComponentVerifyTicket={}", ticket);
                if(!StringUtils.isEmpty(ticket)){
                    //设置10分钟
                    redisUtils.set(RedisKey.COMPONENT_VERIFY_TICKET, ticket, RedisKey.COMPONENT_VERIFY_TICKET_EXPIRE);
                    getComponentAccessToken(true);
                }
            }
            //取消授权
            if (infoType.equalsIgnoreCase("unauthorized")){

            }
            //授权成功或更新授权
            if (infoType.equalsIgnoreCase("authorized") ||infoType.equalsIgnoreCase("updateauthorized")){
                String authorizationCode = XmlUtils.elementText(element, "AuthorizationCode");
                String preAuthCode = XmlUtils.elementText(element, "PreAuthCode");
                long expired =  Long.valueOf(XmlUtils.elementText(element, "AuthorizationCodeExpiredTime"));
                redisUtils.set(RedisKey.COMPONENT_AUTHORIZATION_CODE, authorizationCode, expired);
                redisUtils.set(RedisKey.COMPONENT_PRE_AUTH_CODE, preAuthCode, expired);

            }
        }

    }


    /**
     * 全网发布接入检测消息
     * @param request
     * @param response
     * @param nonce
     * @param timestamp
     * @param msgSignature
     * @throws AesException
     */
    public void checkWechatAllNetwork(HttpServletRequest request, HttpServletResponse response, String nonce, String timestamp, String msgSignature) throws AesException {
        String xml = HttpKit.readData(request);
        log.info("全网发布接入检测消息反馈开始--------nonce:{}-------timestamp:{}---------msgSignature:{}.");
        WXBizMsgCrypt pc = new WXBizMsgCrypt(componentToken, encodingAesKey, componentAppId);
        xml = pc.decryptMsg(msgSignature, timestamp, nonce, xml);

        Element element = XmlUtils.parseXml(xml);
        String msgType = XmlUtils.elementText(element, "MsgType");
        String toUserName = XmlUtils.elementText(element,"ToUserName");
        String fromUserName = XmlUtils.elementText(element,"FromUserName");
        log.info("全网发布接入检测--step.1-----------msgType={}----------toUserName={}---------fromUserName={}", msgType, toUserName, fromUserName);
        log.info("---全网发布接入检测--step.2-----------xml="+xml);
        if(MessageUtils.MESSAGE_EVENT.equals(msgType)){
           log.info("---全网发布接入检测--step.3-----------事件消息--------");
            String event = XmlUtils.elementText(element,"Event");
            replyEventMessage(request, response, event, fromUserName, toUserName);
        }else if(MessageUtils.MESSAGE_TEXT.equals(msgType)){
           log.info("---全网发布接入检测--step.3-----------文本消息--------");
            String content = XmlUtils.elementText(element,"Content");
            processTextMessage(request, response, content, fromUserName, toUserName);
        }

    }


    /**
     * 微信全网接入  文本消息
     * @param request
     * @param response
     * @param toUserName
     * @param fromUserName
     */
    private void processTextMessage(HttpServletRequest request, HttpServletResponse response, String content, String toUserName, String fromUserName){
        if("TESTCOMPONENT_MSG_TYPE_TEXT".equals(content)){
            String returnContent = content+"_callback";
            replyTextMessage(request,response,returnContent,toUserName,fromUserName);
        }else if(StringUtils.startsWithIgnoreCase(content, "QUERY_AUTH_CODE")){
            //先回复空串
            output(response, "");
            //接下来客服API再回复一次消息
            //此时 content字符的内容为是 QUERY_AUTH_CODE:adsg5qe4q35
            replyApiTextMessage(content.split(":")[1], toUserName);
        }
    }

    /**
     * 方法描述: 类型为enevt的时候，拼接
     * @param request
     * @param response
     * @param event
     * @param toUserName  发送接收人
     * @param fromUserName  发送人
     */
    public void replyEventMessage(HttpServletRequest request, HttpServletResponse response, String event, String toUserName, String fromUserName) {
        String content = event + "from_callback";
        replyTextMessage(request,response,content,toUserName,fromUserName);
    }



    private void replyApiTextMessage(String authorizationCode, String fromUserName) {
        // 得到微信授权成功的消息后，应该立刻进行处理！！相关信息只会在首次授权的时候推送过来
        log.info("------step.4----使用客服消息接口回复粉丝----逻辑开始-------------------------");
        getQueryAuth(authorizationCode);
        String msg = authorizationCode + "_from_api";
        Map<String, Object> params = new HashMap<>();
        params.put("touser", fromUserName);
        params.put("msgtype", "text");
        Map<String, Object> text = new HashMap<>();
        text.put("content", msg);
        params.put("text", text);
        String response = HttpClientUtils.getInstance().sendHttpPost(String.format(API_SEND_MESSAGE_URL, wxOpenConfigStorage.getAuthorizerAccessToken()), null, params, "UTF-8");
        if (log.isDebugEnabled()){
            log.debug("api reply message to to wechat whole network test respose = "+ response);
        }

    }


    /**
     * 回复微信服务器"文本消息"
     * @param request
     * @param response
     * @param content
     * @param toUserName
     * @param fromUserName
     */
    private void replyTextMessage(HttpServletRequest request, HttpServletResponse response, String content, String toUserName, String fromUserName) {
        Long createTime = System.currentTimeMillis() / 1000;
        StringBuffer sb = new StringBuffer();
        sb.append("<xml>");
        sb.append("<ToUserName><![CDATA["+fromUserName+"]]></ToUserName>");
        sb.append("<FromUserName><![CDATA["+toUserName+"]]></FromUserName>");
        sb.append("<CreateTime>"+createTime+"</CreateTime>");
        sb.append("<MsgType><![CDATA[text]]></MsgType>");
        sb.append("<Content><![CDATA["+content+"]]></Content>");
        sb.append("</xml>");
        try {
            WXBizMsgCrypt pc = new WXBizMsgCrypt(componentToken, encodingAesKey, componentAppId);
            String text = pc.encryptMsg(sb.toString(), createTime.toString(), "easemob");
            output(response, text);
        } catch (AesException e) {
            e.printStackTrace();
        }

    }


    public void output(HttpServletResponse response,String text){
        try {
            PrintWriter pw = response.getWriter();
            pw.write(text);
            pw.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    public static void main(String [] args) throws Exception {
        WxOpenComponentService service = new WxOpenComponentService();
        service.createPreAuthUrl(null, null,null,false);
    }
}
