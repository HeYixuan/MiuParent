package org.igetwell.common.event;

import com.jfinal.weixin.sdk.msg.in.event.InFollowEvent;
import com.jfinal.weixin.sdk.msg.in.event.InLocationEvent;
import com.jfinal.weixin.sdk.msg.in.event.InQrCodeEvent;

public interface WxEvent {

    void processInFollowEvent(InFollowEvent event);

    void processInQrCodeEvent(InQrCodeEvent event);

    void processInLocationEvent(InLocationEvent event);


}
