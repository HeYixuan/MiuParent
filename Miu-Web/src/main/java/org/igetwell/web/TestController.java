package org.igetwell.web;

import org.igetwell.common.utils.WeChatUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;

@RestController
@RequestMapping("/api")
public class TestController {


    @RequestMapping("/getAuthLogin")
    public void testAuth(HttpServletResponse response){
        String redirect_uri = "http://group.360yeke.com/msg";
        try {
            String url = WeChatUtils.getAuthorizeUrl(redirect_uri);
            response.sendRedirect(url);
        } catch (Exception e) {
            e.printStackTrace();
            //logger.error("微信授权登录异常.{}",e);
        }

    }

    @RequestMapping("/getAccessToken")
    public void getAccessToken(String code){
        try {
            WeChatUtils.getAccessToken();
        } catch (Exception e) {
            e.printStackTrace();
            //logger.error("获取微信授权登录AccessToken异常.{}",e);
        }

    }




    /*@RequestMapping(value = "/download", method = RequestMethod.GET)
    *//*@RequiresPermissions(permissionValue="download")*//*
    public ResponseEntity<byte[]> download(HttpServletRequest request) throws IOException {
        String fileName = "-----.xlsx";
        String path = request.getSession().getServletContext().getRealPath("/") + "download/" + fileName;
        File file = new File(path);
        //处理显示中文文件名的问题
        fileName = URLEncoder.encode(fileName, "UTF-8");
        //设置请求头内容,告诉浏览器代开下载窗口
        HttpHeaders headers = new HttpHeaders();
        headers.setContentDispositionFormData("attachment", fileName);
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),
                headers, HttpStatus.CREATED);
    }*/
}
