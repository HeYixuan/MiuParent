package org.igetwell.system.users.create;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

@Data
public class UserAvatarUpload {

    /**
     * 用户OPEN_ID
     */
    @NotBlank(message = "OPEN_ID应不为空")
    private String openId;

    /**
     * 用户头像
     */
    @NotNull(message = "至少上传一个文件")
    private MultipartFile multipartFile;
}
