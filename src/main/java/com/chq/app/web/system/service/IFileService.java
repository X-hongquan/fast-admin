package com.chq.app.web.system.service;

/**
 * 上传文件接口
 */
public interface IFileService  {

    String uploadImg(String contentType,String fileName, byte[] bytes,String directory);


    byte[] download(String fileName,String directory);
}
