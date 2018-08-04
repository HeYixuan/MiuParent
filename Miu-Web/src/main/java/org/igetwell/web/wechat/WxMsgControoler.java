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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;


@Slf4j
@RestController
@RequestMapping("/WxMsg")
public class WxMsgControoler extends BaseController {

    /*public void processInFollowEvent() {
        Map<String, String> params = BeanUtils.xmlBean2Map(xmlStr);

        *//*if (InFollowEvent.EVENT_INFOLLOW_SUBSCRIBE.equalsIgnoreCase(event.getEvent()))
        {
        }
        // 如果为取消关注事件，将无法接收到传回的信息
        if (InFollowEvent.EVENT_INFOLLOW_UNSUBSCRIBE.equals(event.getEvent()))
        {
            log.debug("取消关注：" + event.getFromUserName());
        }*//*
    }*/

    @RequestMapping("/follow")
    public void processInFollowEvent() {
        String xmlStr = HttpKit.readData(request.get());
        Map<String, String> resultMap = BeanUtils.xmlBean2Map(xmlStr);
        String toUserName = resultMap.get("ToUserName");
        String fromUserName = resultMap.get("FromUserName");
        String msgType = resultMap.get("MsgType");

        //判断请求是否事件类型 event
        if(MessageUtils.MESSAGE_EVENT.equals(msgType)){
            String eventType = resultMap.get("Event");
            //若是关注事件  subscribe
            if(MessageUtils.EVENT_SUB.equals(eventType)){
                String mycontent = MessageUtils.menuText();
                String message = MessageUtils.initText(toUserName, fromUserName, mycontent);
                System.err.println(message);
                renderReturn(message);
            }
        }
    }

    public void processInQrCodeEvent(InQrCodeEvent event) {

    }

    public void processInLocationEvent(InLocationEvent event) {

    }
}
