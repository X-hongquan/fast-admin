package com.chq.app.web.system.service.impl;

import com.chq.app.common.exception.ServiceException;
import com.chq.app.config.MinioConfig;
import com.chq.app.web.system.service.IFileService;
import io.minio.GetObjectArgs;
import io.minio.GetObjectResponse;
import io.minio.MinioClient;
import io.minio.PutObjectArgs;
import io.minio.errors.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

@Slf4j
@Primary
@Service
public class MinioFileServiceImpl implements IFileService {

    @Autowired
    private MinioConfig config;

    @Autowired
    private MinioClient minioClient;


    @Override
    public String uploadImg(String contentType, String fileName, byte[] bytes, String directory) {
        if (!contentType.startsWith("image"))
            throw new ServiceException(contentType + "文件格式不对,请上传image类型");
        String ext = fileName.substring(fileName.lastIndexOf("."));
        String md5 = DigestUtils.md5DigestAsHex(bytes);
        String fileN = md5 + ext;
        String proxyUrl = config.getProxyUrl();
        String bucketName = config.getBucketName();
        PutObjectArgs putObjectArgs = PutObjectArgs.builder()
                .stream(new ByteArrayInputStream(bytes), bytes.length, -1)
                .contentType(contentType)
                .bucket(bucketName)
                .object(fileN)
                .build();
        try {
            minioClient.putObject(putObjectArgs);
        } catch (Exception e) {

        }
        StringBuilder sb = new StringBuilder(proxyUrl);
        sb.append("/").append(bucketName).append("/");
        if (directory != null) {
            sb.append(directory).append("/");
        }
        sb.append(fileN);
        return sb.toString();
    }

    @Override
    public byte[] download(String fileName, String directory) {
        GetObjectArgs.Builder builder = GetObjectArgs.builder();
        builder.bucket(config.getBucketName());
        builder.object(fileName);
        if (directory != null) {
            builder.object(directory + "/" + fileName);
        }
        GetObjectArgs getObjectArgs = builder.build();
        try (GetObjectResponse response = minioClient.getObject(getObjectArgs)) {
            byte[] bytes = response.readAllBytes();
            return bytes;
        } catch (Exception e) {
            log.error("文件下载失败", e);
            throw new ServiceException("文件下载失败");
        }
    }
}
