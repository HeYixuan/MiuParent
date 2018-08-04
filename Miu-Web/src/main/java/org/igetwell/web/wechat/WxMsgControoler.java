package org.igetwell.web.wechat;

import com.jfinal.weixin.sdk.msg.in.event.InLocationEvent;
import com.jfinal.weixin.sdk.msg.in.event.InQrCodeEvent;
import lombok.extern.slf4j.Slf4j;
import org.igetwell.common.local.HttpKit;
import org.igetwell.common.utils.BeanUtils;

import org.igetwell.common.utils.MessageUtils;
import org.igetwell.web.BaseController;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;


@Slf4j
@RestController
@RequestMapping("/WxMsg")
public class WxMsgControoler extends BaseController {

    @PostMapping(value = "/follow", produces = {"application/xml"})
    public void processInFollowEvent() {
        String xmlStr = HttpKit.readData(request.get());
        Map<String, String> resultMap = BeanUtils.xmlBean2Map(xmlStr);
        String message = MessageUtils.callbackMessage(resultMap);
        render(message);
    }

    public void processInQrCodeEvent(InQrCodeEvent event) {

    }

    public void processInLocationEvent(InLocationEvent event) {

    }
}
