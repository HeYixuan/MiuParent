package org.igetwell.common.utils;

import com.aliyun.oss.ClientException;
import com.aliyun.oss.OSSClient;
import com.aliyun.oss.OSSException;
import com.aliyun.oss.model.*;
import lombok.extern.slf4j.Slf4j;

import java.io.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Oss上传工具类
 */
@Slf4j
public class AliyunOss {
    
    //阿里云API的内或外网域名
    private static String ENDPOINT;
    //阿里云API的密钥Access Key ID
    private static String ACCESS_KEY_ID;
    //阿里云API的密钥Access Key Secret
    private static String ACCESS_KEY_SECRET;
    //阿里云API的bucket名称
    public static String BUCKET_NAME;
    //初始化属性
    static{
        ENDPOINT = "oss-cn-beijing.aliyuncs.com";
        ACCESS_KEY_ID = "";
        ACCESS_KEY_SECRET = "";
        BUCKET_NAME = "oss-fit";
    }

    /**
     * 获取阿里云OSS客户端对象
     * @return ossClient
     */
    public static OSSClient ossClient(){
        return new OSSClient(ENDPOINT, ACCESS_KEY_ID, ACCESS_KEY_SECRET);
    }

    /**
     * 创建存储空间
     * @param ossClient      OSS连接
     * @param bucketName 存储空间
     * @return
     */
    public static String createBucketName(OSSClient ossClient, String bucketName){
        //存储空间
        final String bucketNames = bucketName;
        if(!ossClient.doesBucketExist(bucketName)){
            //创建存储空间
            Bucket bucket = ossClient.createBucket(bucketName);
            log.info("创建存储空间成功");
            return bucket.getName();
        }
        return bucketNames;
    }

    /**
     * 删除存储空间buckName
     * @param ossClient  oss对象
     * @param bucketName  存储空间
     */
    public static  void deleteBucket(OSSClient ossClient, String bucketName){
        ossClient.deleteBucket(bucketName);
        log.info("删除" + bucketName + "Bucket成功");
    }


    /**
     * 删除单个文件
     * @param ossClient
     * @param bucketName
     * @param key
     */
    public static void delete(OSSClient ossClient, String bucketName, String key){
        ossClient.deleteObject(bucketName, key);
    }

    /**
     * 删除多个文件
     * @param ossClient
     * @param bucketName
     * @param keys
     */
    public static void deleteList(OSSClient ossClient, String bucketName, List<String> keys){
        DeleteObjectsResult deleteObjectsResult = ossClient.deleteObjects(new DeleteObjectsRequest(bucketName).withKeys(keys));
        List<String> deletedObjects = deleteObjectsResult.getDeletedObjects();
    }


    /**
     * 上传文件到阿里云OSS
     * @param file
     * @return
     */
    public static PutObjectResult multipartUpload(OSSClient client, String bucketName, String key, File file) {
        FileInputStream fis = null;
        try {
            //以输入流的形式上传文件
            fis = new FileInputStream(file);
            //文件大小
            Long fileSize = file.length();
            //创建上传Object的Metadata
            ObjectMetadata metadata = new ObjectMetadata();
            //上传的文件的长度
            metadata.setContentLength(fileSize);
            //指定该Object被下载时的网页的缓存行为
            metadata.setCacheControl("no-cache");
            //指定该Object下设置Header
            metadata.setHeader("Pragma", "no-cache");
            //指定该Object被下载时的内容编码格式
            metadata.setContentEncoding("UTF-8");
            //文件的MIME，定义文件的类型及网页编码，决定浏览器将以什么形式、什么编码读取文件。如果用户没有指定则根据Key或文件名的扩展名生成，
            //如果没有扩展名则填默认值application/octet-stream
            metadata.setContentType(getContentType(file.getName()));
            // 用户自定义文件名称
            metadata.addUserMetadata("filename", key);
            //上传文件(上传文件流的形式)
            PutObjectResult putResult = client.putObject(bucketName, key, fis, metadata);
            return putResult;
        } catch (Exception e) {
            log.error("上传阿里云OSS服务器异常.", e);
        } finally {
            if (fis != null) {
                try {
                    fis.close();
                } catch (IOException e) {
                    log.error("关闭IO异常：" + e);
                }
            }
        }
        return null;
    }


    /**
     * 上传文件到阿里云OSS
     * @param client
     * @param bucketName
     * @param key
     * @param fileName
     * @param inputStream
     * @param length
     * @return
     */
    public static boolean multipartUpload(OSSClient client, String bucketName, String key, String fileName, InputStream inputStream, long length){
        try{
            ObjectMetadata objectMetadata = new ObjectMetadata();
            objectMetadata.setContentLength(length);
            objectMetadata.setCacheControl("no-cache");
            objectMetadata.setHeader("Pragma", "no-cache");
            objectMetadata.setContentType(getContentType(fileName));
            objectMetadata.setContentDisposition("inline;filename=" + fileName);
            client.putObject(bucketName, key, inputStream, objectMetadata);
            log.info("上传文件到阿里云成功：" + key);
            return true;
        } catch (Exception e){
            log.error("上传文件到阿里云异常 OSSException:" + e);
        } finally {
            if (inputStream != null) {
                try {
                    inputStream.close();
                } catch (IOException e) {
                    log.error("关闭IO异常：" + e);
                }
            }
        }
        return false;
    }

    /**
     * 分片上传文件到阿里云OSS
     * @param key 指明文件名+扩展名
     * @param partFile 要上传的文件
     * @return 上传后的文件名
     * @throws IOException
     */
    public static String multipartUpload(String key, File partFile, OSSClient client,String bucketName) throws IOException {
        // 开始Multipart Upload
        InitiateMultipartUploadRequest initiateMultipartUploadRequest = new InitiateMultipartUploadRequest(bucketName, key);
        InitiateMultipartUploadResult initiateMultipartUploadResult = client.initiateMultipartUpload(initiateMultipartUploadRequest);
        final int partSize = 1024 * 1024 * 5;
        // 计算分块数目
        int partCount = (int) (partFile.length() / partSize);
        if (partFile.length() % partSize != 0){
            partCount++;
        }
        // 新建一个List保存每个分块上传后的ETag和PartNumber
        List<PartETag> partETags = new ArrayList<PartETag>();
        for(int i = 0; i < partCount; i++){
            // 获取文件流
            FileInputStream fis = new FileInputStream(partFile);
            // 跳到每个分块的开头
            long skipBytes = partSize * i;
            fis.skip(skipBytes);
            // 计算每个分块的大小
            long size = partSize < partFile.length() - skipBytes ?
                    partSize : partFile.length() - skipBytes;
            // 创建UploadPartRequest，上传分块
            UploadPartRequest uploadPartRequest = new UploadPartRequest();
            uploadPartRequest.setBucketName(bucketName);
            uploadPartRequest.setKey(key);
            uploadPartRequest.setUploadId(initiateMultipartUploadResult.getUploadId());
            uploadPartRequest.setInputStream(fis);
            uploadPartRequest.setPartSize(size);
            uploadPartRequest.setPartNumber(i + 1);
            UploadPartResult uploadPartResult = client.uploadPart(uploadPartRequest);
            // 将返回的PartETag保存到List中。
            partETags.add(uploadPartResult.getPartETag());
            // 关闭文件
            fis.close();
        }
        CompleteMultipartUploadRequest completeMultipartUploadRequest =
                new CompleteMultipartUploadRequest(bucketName,key, initiateMultipartUploadResult.getUploadId(), partETags);
        // 完成分块上传
        CompleteMultipartUploadResult completeMultipartUploadResult =
                client.completeMultipartUpload(completeMultipartUploadRequest);
        // 获得location
        return completeMultipartUploadResult.getKey();
    }


    /**
     * 下载文件
     * @param client
     * @param key
     * @param bucketName
     */
    public static void download(OSSClient client, String key, String bucketName) {
        try {
            OSSObject ossObject = client.getObject(bucketName, key);
            if (ossObject == null) {
                log.warn("download aliyun oss is empty,bucketName is " + bucketName + " and key is " + key);
                return;
            }
            BufferedReader reader = new BufferedReader(new InputStreamReader(ossObject.getObjectContent()));
            while (true) {
                String line = reader.readLine();
                if (line == null) break;
            }
            reader.close();
        } catch (OSSException e) {
            log.error("下载文本内容异常,key=" + key + ",OSSException:" + e);
        } catch (ClientException e) {
            log.error("下载文本内容异常,key=" + key + ",ClientException:" + e);
        } catch (Exception e) {
            log.error("下载文本内容异常,key=" + key + ",Exception:" + e);
        }
    }

    public static void download(OSSClient client, String key, String bucketName, String localFile,String checkPointFile){
        try{
            // 下载请求，10个任务并发下载，启动断点续传。
            DownloadFileRequest downloadFileRequest = new DownloadFileRequest(bucketName, key);
            downloadFileRequest.setDownloadFile(localFile);
            downloadFileRequest.setPartSize(1 * 1024 * 1024);
            downloadFileRequest.setTaskNum(10);
            downloadFileRequest.setEnableCheckpoint(true);
            downloadFileRequest.setCheckpointFile(checkPointFile);
            // 下载文件。
            DownloadFileResult downloadRes = client.downloadFile(downloadFileRequest);
            // 下载成功时，会返回文件元信息。
            downloadRes.getObjectMetadata();
        } catch (Throwable throwable) {
            log.error("断点续传下载异常,key=" + key + ",OSSException:" + throwable);
        }

    }


    /**
     * 下载文件
     * @param client
     * @param key
     * @param bucketName
     * @param file
     */
    public static void download(OSSClient client, String key, String bucketName, File file) {
        try {
            client.getObject(new GetObjectRequest(bucketName, key), file);
        } catch (OSSException e) {
            log.error("下载文本内容异常,key=" + key + ",OSSException:" + e);
        } catch (ClientException e) {
            log.error("下载文本内容异常,key=" + key + ",ClientException:" + e);
        } catch (Exception e) {
            log.error("下载文本内容异常,key=" + key + ",Exception:" + e);
        }
    }

    /**
     *  下载文件
     *
     * @param client  OSSClient对象
     * @param bucketName  Bucket名
     * @param key  上传到OSS起的名
     * @param filename 文件下载到本地保存的路径
     * @throws OSSException
     * @throws ClientException
     */
    private static void downloadFile(OSSClient client, String bucketName, String key, String filename)
            throws OSSException, ClientException {
        client.getObject(new GetObjectRequest(bucketName, key),
                new File(filename));
    }


    /**
     * 通过文件名判断并获取OSS服务文件上传时文件的contentType
     * @param fileName 文件名
     * @return 文件的contentType
     */
    public static String getContentType(String fileName){
        //文件的后缀名
        String fileExtension = fileName.substring(fileName.lastIndexOf("."));
        if(".bmp".equalsIgnoreCase(fileExtension)) {
            return "image/bmp";
        }
        if(".gif".equalsIgnoreCase(fileExtension)) {
            return "image/gif";
        }
        if(".jpeg".equalsIgnoreCase(fileExtension) || ".jpg".equalsIgnoreCase(fileExtension)  || ".png".equalsIgnoreCase(fileExtension) ) {
            return "image/jpeg";
        }
        if(".html".equalsIgnoreCase(fileExtension)) {
            return "text/html";
        }
        if(".txt".equalsIgnoreCase(fileExtension)) {
            return "text/plain";
        }
        if(".vsd".equalsIgnoreCase(fileExtension)) {
            return "application/vnd.visio";
        }
        if(".ppt".equalsIgnoreCase(fileExtension) || "pptx".equalsIgnoreCase(fileExtension)) {
            return "application/vnd.ms-powerpoint";
        }
        if(".doc".equalsIgnoreCase(fileExtension) || "docx".equalsIgnoreCase(fileExtension)) {
            return "application/msword";
        }
        if(".xml".equalsIgnoreCase(fileExtension)) {
            return "text/xml";
        }
        //默认返回类型
        return "image/jpeg";
    }

    /**
     * 获取签名Url
     * @param ossClient
     * @param key 上传文件的key
     * @return
     */
    public static String getUrl(OSSClient ossClient, String key) {
        // 设置URL过期时间为2天
        Date expiration = new Date(new Date().getTime() + 3600l * 1000 * 24 * 2);
        // 生成URL
        String url = ossClient.generatePresignedUrl(BUCKET_NAME, key, expiration).toString();
        return url;
    }

    /**
     * 关闭oss服务
     */
    public static void closeOss(){
        ossClient().shutdown();
    }

    public static void main(String [] args) throws IOException {
        //测试上传
        OSSClient client = ossClient();
        String bucketName = createBucketName(client, BUCKET_NAME);
        String key = "abcd.jpg";
        // file = new File("D://17594241441223.jpg");
        //String keyName = multipartUpload(key, file, client, bucketName);
        //System.err.println("keyName:" +keyName);
        //PutObjectResult result = multipartUpload(client, bucketName, key, file);
        //System.err.println("result:" + result.getETag());
        //InputStream inputStream = new FileInputStream(file);
        //boolean bool  = multipartUpload(client, bucketName, key, file.getName(), inputStream, file.length());
        //System.err.println(bool);

        String url = getUrl(client, key);
        System.err.println(url);
        //测试下载
        File downloadLocalFile = new File("D://jack.png");
        File checkPointFile = new File("D://jack.ucp");
        download(client, key, bucketName, downloadLocalFile.getPath(), checkPointFile.getPath());
        //download(client, key, BUCKET_NAME, downloadLocalFile);
    }
}
