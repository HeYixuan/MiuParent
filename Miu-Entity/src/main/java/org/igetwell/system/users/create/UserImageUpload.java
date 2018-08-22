package org.igetwell.system.users.create;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;

@Data
public class UserImageUpload {

    /**
     * 用户OPEN_ID
     */
    @NotBlank(message = "OPEN_ID应不为空")
    private String openId;

    /**
     * 多文件
     */
    @NotEmpty(message = "至少上传一个文件")
    private MultipartFile[] multipartFiles;
}
