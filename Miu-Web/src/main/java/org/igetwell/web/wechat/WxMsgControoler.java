package org.igetwell.web.wechat;

import com.jfinal.weixin.sdk.msg.in.event.InFollowEvent;
import com.jfinal.weixin.sdk.msg.in.event.InLocationEvent;
import com.jfinal.weixin.sdk.msg.in.event.InQrCodeEvent;
import com.jfinal.weixin.sdk.msg.out.OutTextMsg;
import lombok.extern.slf4j.Slf4j;
import org.igetwell.common.event.WxEvent;
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

    @PostMapping(value = "follow", produces = {"application/xml"})
    public void processInFollowEvent() {
        String xmlStr = HttpKit.readData(request.get());
        Map<String, String> resultMap = BeanUtils.xmlBean2Map(xmlStr);
        String fromUserName = resultMap.get("FromUserName");
        String toUserName = resultMap.get("ToUserName");
        String msgType = resultMap.get("MsgType");

        //判断请求是否事件类型 event
        if(MessageUtils.MESSAGE_EVENT.equals(msgType)){
            String eventType = resultMap.get("Event");
            //若是关注事件  subscribe
            if(MessageUtils.EVENT_SUB.equals(eventType)){
                String text = MessageUtils.menuText();
                String message = MessageUtils.initText(toUserName, fromUserName, text);
                System.err.println(message);
                render(message);
            }
        }
    }

    public void processInQrCodeEvent(InQrCodeEvent event) {

    }

    public void processInLocationEvent(InLocationEvent event) {

    }
}
