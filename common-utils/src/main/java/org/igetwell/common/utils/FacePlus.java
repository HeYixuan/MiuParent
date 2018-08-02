package org.igetwell.common.utils;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang3.StringUtils;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.util.HashMap;
import java.util.Map;

/**
 * Face++工具类
 */
@Slf4j
public class FacePlus {
    
    //Face++ API的密钥Access Key ID
    private static String ACCESS_KEY_ID;
    //Face++ API的密钥Access Key Secret
    private static String ACCESS_KEY_SECRET;
    //Face++ API的美颜和美白地址
    private static String BEAUTIFY_URL;

    //初始化属性
    static{
        BEAUTIFY_URL = "oss-cn-beijing.aliyuncs.com";
        ACCESS_KEY_ID = "pbJrwcxVxmy3lrESlEFobFQctGjCdpVL";
        ACCESS_KEY_SECRET = "ja5S6VHY9riKbDtHQ_l0QZ2p8SqSFB2-";
        BEAUTIFY_URL = "oss-fit";
    }

    /**
     *
     * @param base64Image
     * @param whitening 美白程度，取值范围[0,100]
     *                  0不美白，100代表最高程度
     *                  默认值为 100
     * @param smoothing 磨皮程度，取值范围 [0,100]
     *                  0不磨皮，100代表最高程度
     *                  默认值为 100
     * @return
     */
    public static JSON getBeautify(String base64Image, String whitening, String smoothing){
        JSONObject json = null;
        try{
            Map<String, String> params = new HashMap<>();
            if (StringUtils.isBlank(whitening))
                whitening = "100";
            if (StringUtils.isBlank(smoothing))
                smoothing = "100";
            params.put("api_key", ACCESS_KEY_ID);
            params.put("api_secret", ACCESS_KEY_SECRET);
            params.put("image_base64", base64Image);
            params.put("whitening", whitening);
            params.put("smoothing", smoothing);
            String str = HttpClientUtils.getInstance().sendHttpPost(BEAUTIFY_URL, params, "UTF-8");
            json = JSON.parseObject(str);
            if (!json.containsKey("result")){
                throw new RuntimeException(str);
            }
            return json;
        } catch (Exception e){
            log.error("调用Face+美颜功能失败！", e);
        }
        return null;
    }


    /**
     *
     * @param file 本地文件
     * @param whitening 美白程度，取值范围[0,100]
     *                  0不美白，100代表最高程度
     *                  默认值为 100
     * @param smoothing 磨皮程度，取值范围 [0,100]
     *                  0不磨皮，100代表最高程度
     *                  默认值为 100
     * @return
     */
    public static JSONObject getBeautify(File file, String whitening, String smoothing){
        JSONObject json = null;
        try{
            Map<String, String> params = new HashMap<>();
            if (StringUtils.isBlank(whitening))
                whitening = "100";
            if (StringUtils.isBlank(smoothing))
                smoothing = "100";
            params.put("api_key", ACCESS_KEY_ID);
            params.put("api_secret", ACCESS_KEY_SECRET);
            params.put("whitening", whitening);
            params.put("smoothing", smoothing);
            /*String str = HttpClientUtil.getInstance().multipartFile(BEAUTIFY_URL, file.getPath(), "image_file", params);
            json = JSON.parseObject(str);
            if (!json.containsKey("result")){
                throw new RuntimeException(str);
            }
            return json;*/
        } catch (Exception e){
            log.error("调用Face+美颜功能失败！", e);
        }
        return null;
    }

    public static void main(String [] args) throws IOException {
        File file = new File("D://微信图片_20180723153217.jpg");
        File filea = new File("D://c.jpg"); //创建美颜后临时文件
        JSONObject json = getBeautify(file, "100", "100");

        Files.write(Paths.get(filea.getCanonicalPath()), Base64.decodeBase64(json.getString("result")),StandardOpenOption.CREATE_NEW);

        System.err.println(json);
    }

}
