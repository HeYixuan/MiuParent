package org.igetwell.common.utils;

import org.apache.commons.codec.digest.DigestUtils;

import java.util.Arrays;

public class CheckSignature {

    // 与接口配置信息中的Token要一致
    private static String TOKEN = "HeYixuan";

    /**
     * 微信验证签名
     *
     * @param signature
     * @param timestamp
     * @param nonce
     * @return
     */
    public static boolean checkSignature(String signature, String timestamp, String nonce) {
            String[] arr = new String[] { TOKEN, timestamp, nonce };
            Arrays.sort(arr);
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < arr.length; i++) {
                sb.append(arr[i]);
            }
            return DigestUtils.sha1Hex(sb.toString()).equalsIgnoreCase(signature);
        }

}
