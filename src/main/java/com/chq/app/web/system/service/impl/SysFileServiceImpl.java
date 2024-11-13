package com.chq.app.web.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chq.app.common.exception.ServiceException;
import com.chq.app.web.system.pojo.SysFile;
import com.chq.app.web.system.service.IFileService;
import com.chq.app.web.system.service.ISysFileService;
import com.chq.app.web.system.mapper.SysFileMapper;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;

/**
 * @author ASUS
 * @description 针对表【sys_file(文件存储表)】的数据库操作Service实现
 * @createDate 2024-09-29 02:06:57
 */
@Service
public class SysFileServiceImpl extends ServiceImpl<SysFileMapper, SysFile>
        implements ISysFileService, IFileService {

    @Override
    public String uploadImg(String contentType, String fileName, byte[] bytes, String directory) {
        if (!contentType.startsWith("image"))
            throw new ServiceException(contentType + "文件格式不对,请上传image类型");
        String md5 = DigestUtils.md5DigestAsHex(bytes);
        String ext = fileName.substring(fileName.lastIndexOf("."));
        String fileN = md5 + ext;
        SysFile sysFile = new SysFile();
        sysFile.setFilename(fileName);
        sysFile.setMd5(md5);
        sysFile.setContent(bytes);
        StringBuilder sb = new StringBuilder("/file/");
        if (directory != null) {
            sb.append(directory).append("/");
        }
        sb.append(fileN);
        String url = sb.toString();
        sysFile.setUrl(url);
        save(sysFile);
        return url;
    }

    @Override
    public byte[] download(String fileName, String directory) {
        int i = fileName.lastIndexOf(".");
        String md5 = fileName.substring(0, i);
        LambdaQueryWrapper<SysFile> lqw = new LambdaQueryWrapper<SysFile>().eq(SysFile::getMd5, md5);
        SysFile sysFile = getOne(lqw);
        if (sysFile == null) {
            throw new ServiceException("文件不存在");
        }
        return sysFile.getContent();
    }

}




