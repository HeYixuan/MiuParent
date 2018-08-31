package org.igetwell.common.utils;

import com.alibaba.fastjson.JSONObject;
import lombok.extern.slf4j.Slf4j;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Slf4j
public class Face {

    //FaceID API的密钥Access Key ID
    private static String ACCESS_KEY_ID;
    //FaceID API的密钥Access Key Secret
    private static String ACCESS_KEY_SECRET;
    //FaceID 人脸核身获取TOKEN地址
    private static String TOKEN_URL;
    //FaceID 人脸核身获取验证详细信息地址
    private static String RESULT_URL;

    //初始化属性
    static{
        ACCESS_KEY_ID = "ZbC8Gvy-_W7EWZ4fluvnmYAasswFAXTQ";
        ACCESS_KEY_SECRET = "l7fJYYi65XG-MJx_2zXpZK4fmrYdzbMA";
        TOKEN_URL = "https://openapi.faceid.com/lite/v1/get_biz_token";
        RESULT_URL = "https://openapi.faceid.com/lite/v1/get_result";
    }

    public static String getToken(String returnUrl, String notifyUrl, String idCardId, String idCardName) {
        try{
            String sign = FaceSignUtils.createSign(ACCESS_KEY_ID, ACCESS_KEY_SECRET, 100l);

            Map<String, String> params = new HashMap<>();
            params.put("sign", sign);
            params.put("sign_version", "hmac_sha1");
            params.put("comparison_type", "1");
            params.put("liveness_type", "video_number");
            params.put("return_url", returnUrl);
            params.put("notify_url", notifyUrl);
            params.put("idcard_number", idCardId);
            params.put("idcard_name", idCardName);
            String result = HttpClientUtils.getInstance().sendHttpPost(TOKEN_URL, params, "UTF-8");
            return result;
        } catch (Exception e){
            log.error("获取人脸核身TOKEN异常：", e);
            return null;
        }
    }


    public static String getResult(String token) throws Exception {
        try{
            String sign = FaceSignUtils.createSign(ACCESS_KEY_ID, ACCESS_KEY_SECRET, 100l);
            Map<String, Object> params = new HashMap<>();
            params.put("sign", sign);
            params.put("sign_version", "hmac_sha1");
            params.put("biz_token", token);

            String result = HttpClientUtils.getInstance().sendHttpsGet(RESULT_URL, params);
            return result;
        } catch (Exception e){
            log.error("获取人脸核身验证详细信息异常：", e);
            return null;
        }
    }


    public static void main(String [] args) throws IOException {

        try {
            String jsonResult = getToken("http://api.insdate.com.cn/face/returnUrl?biz_token=", "http://api.insdate.com.cn/face/notifyUrl", "430422199207040423", "谢磊");

            JSONObject json = JSONObject.parseObject(jsonResult);
            String token = json.getString("biz_token");
            System.err.println(token);

//            String result = getResult("1535701866,add38f72-1bb5-42cf-b317-c4db6705ee15");
//            System.err.println("result:" + result);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
