package org.igetwell.common.utils;
import com.alibaba.fastjson.JSON;

public class BaiduMap {


    /**
     *
     * @param lng 经度
     * @param lat 纬度
     * @return
     */
    public static String getCity(String lat, String lng){
        String url ="http://api.map.baidu.com/geocoder/v2/?ak=%s&location=%s&output=json&pois=1";
        //String url ="http://api.map.baidu.com/geocoder/v2/?ak="+"jGWRlrz8Iv5CF6Wr1U0oX3A9"+"&location=" + lat + ","+ lng + "&output=json&pois=1";

        String result = HttpClientUtils.getInstance().sendHttpGet(url);
        System.err.println(result);
        String province = JSON.parseObject(result).getJSONObject("result").getJSONObject("addressComponent").getString("city");
        return province;
    }

    public static String getCity(String axis){
        String url = "https://restapi.amap.com/v3/geocode/regeo?key=abad114e8909387e6d99fb08418bff9b&location=113.937987,22.523392";
        String result = HttpClientUtils.getInstance().sendHttpsGet(url);
        String success = JSON.parseObject(result).get("info").toString();
        String infocode = JSON.parseObject(result).get("infocode").toString();
        String city = null;
        if ("OK".equalsIgnoreCase(success) && "10000".equals(infocode)){
            //直辖市城市字段为空处理
            try{
                int size = JSON.parseObject(result).getJSONObject("regeocode").getJSONObject("addressComponent").getJSONArray("city").size();
                if (size <= 0){
                    city = JSON.parseObject(result).getJSONObject("regeocode").getJSONObject("addressComponent").getString("province");
                }
            } catch (Exception e){
                city = JSON.parseObject(result).getJSONObject("regeocode").getJSONObject("addressComponent").getString("city");
                return city;
            }
            /*if (size <= 0){
                city = JSON.parseObject(result).getJSONObject("regeocode").getJSONObject("addressComponent").getString("province");
            }else {
                city = JSON.parseObject(result).getJSONObject("regeocode").getJSONObject("addressComponent").getString("city");
            }*/
        }
        return city;
    }

    public static void main(String[] args) {
        //112.22999999999998,29.120000029560609
        //String o = getCity("116.599556","40.085453");//112.23,29.12  116.47825,39.914598
        //{"status":0,"result":{"location":{"lng":112.22999999999998,"lat":29.120000029560609},"formatted_address":"湖南省常德市汉寿县","business":"","addressComponent":{"country":"中国","country_code":0,"country_code_iso":"CHN","country_code_iso2":"CN","province":"湖南省","city":"常德市","city_level":2,"district":"汉寿县","town":"","adcode":"430722","street":"","street_number":"","direction":"","distance":""},"pois":[{"addr":"常德市汉寿县","cp":" ","direction":"西北","distance":"632","name":"得意障","poiType":"行政地标","point":{"x":112.23482038291368,"y":29.117359690026267},"tag":"行政地标;村庄","tel":"","uid":"5ffb1816b4b6a75c6f47601f","zip":"","parent_poi":{"name":"","tag":"","addr":"","point":{"x":0.0,"y":0.0},"direction":"","distance":"","uid":""}},{"addr":"益阳市南县","cp":" ","direction":"东","distance":"918","name":"张家湾","poiType":"行政地标","point":{"x":112.22218122439247,"y":29.12232152243087},"tag":"行政地标;村庄","tel":"","uid":"24d055082a4f8baf138824e2","zip":"","parent_poi":{"name":"","tag":"","addr":"","point":{"x":0.0,"y":0.0},"direction":"","distance":"","uid":""}}],"roads":[],"poiRegions":[],"sematic_description":"得意障西北632米","cityCode":219}}
        //System.err.println(o);
        String city = getCity("113.937987,22.523392");
        System.err.println(city);
    }

}
