package org.igetwell.common.handler;

import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.dysmsapi.model.v20170525.SendSmsRequest;
import com.aliyuncs.dysmsapi.model.v20170525.SendSmsResponse;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.profile.DefaultProfile;
import com.aliyuncs.profile.IClientProfile;
import lombok.extern.slf4j.Slf4j;
import org.igetwell.common.template.MobileMsgTemplate;


@Slf4j
public class SmsAliyunMessageHandler {

    private static final String PRODUCT = "Dysmsapi";
    private static final String DOMAIN = "dysmsapi.aliyuncs.com";

    //替换成你的AK
    private static final String ACCESS_KEY = "LTAIe9IazjyMVXNF";//你的accessKeyId,参考本文档步骤2
    private static final String ACCESS_KEY_SECRET = "gGeeR95sOGwTrZA41RdmiZW4BF1HPh";//你的accessKeySecret，参考本文档步骤2

    //短信签名
    private static final String SIGN = "乐创";
    //短信模板
    private static final String TEMPLATE = "SMS_114390986";

    public void check(MobileMsgTemplate mobileMsgTemplate) {

//        Assert.isBlank(mobileMsgTemplate.getMobile(), "手机号不能为空");
//        Assert.isBlank(mobileMsgTemplate.getContext(), "短信内容不能为空");
    }

    public static boolean process(MobileMsgTemplate mobileMsgTemplate) {
        //可自助调整超时时间
        System.setProperty("sun.net.client.defaultConnectTimeout", "10000");
        System.setProperty("sun.net.client.defaultReadTimeout", "10000");

        //初始化acsClient,暂不支持region化
        IClientProfile profile = DefaultProfile.getProfile("cn-hangzhou", ACCESS_KEY, ACCESS_KEY_SECRET);
        try {
            DefaultProfile.addEndpoint("cn-hangzhou", "cn-hangzhou", PRODUCT, DOMAIN);
        } catch (ClientException e) {
            log.error("初始化SDK 异常", e);
            e.printStackTrace();
        }
        IAcsClient acsClient = new DefaultAcsClient(profile);

        //组装请求对象-具体描述见控制台-文档部分内容
        SendSmsRequest request = new SendSmsRequest();
        //必填:待发送手机号
        request.setPhoneNumbers(mobileMsgTemplate.getMobile());

        //必填:短信签名-可在短信控制台中找到
        request.setSignName(mobileMsgTemplate.getSignName());

        //必填:短信模板-可在短信控制台中找到
        request.setTemplateCode(mobileMsgTemplate.getTemplate());

        //可选:模板中的变量替换JSON串,如模板内容为"亲爱的${name},您的验证码为${code}"
        request.setTemplateParam(mobileMsgTemplate.getContext());
        request.setOutId(mobileMsgTemplate.getMobile());

        try {
            SendSmsResponse sendSmsResponse = acsClient.getAcsResponse(request);
            log.info("短信发送完毕，手机号：{}，返回状态：{}", mobileMsgTemplate.getMobile(), sendSmsResponse.getCode());
        } catch (ClientException e) {
            log.error("短信发送异常.", e);
        }
        return true;
    }

    //以下为测试代码，随机生成验证码
    private static int newcode;
    public static int getNewcode() {
        return newcode;
    }
    public static void setNewcode(){
        newcode = (int)(Math.random()*9999)+100;  //每次调用生成一次四位数的随机数
    }

    public static void main(String[] args) throws Exception {
        setNewcode();
        String code = Integer.toString(getNewcode());

        //SendSmsResponse sendSms = sendSms("测试手机号码",code);//填写你需要测试的手机号码
        MobileMsgTemplate mobileMsgTemplate = new MobileMsgTemplate();
        mobileMsgTemplate.setMobile("13288885138");
        mobileMsgTemplate.setContext("{\"code\":\""+code+"\"}");
        mobileMsgTemplate.setSignName(SIGN);
        mobileMsgTemplate.setTemplate(TEMPLATE);
        process(mobileMsgTemplate);
    }

}
