package org.igetwell.system.pay.retrieve;

import lombok.Data;

@Data
public class PaymentQuery {

    /**
     * 用户OPEN_ID
     */
    private String openId;

    /**
     * 商品ID
     */
    private String productId;

    /**
     * 订单号
     */
    private String tradeNo;

    /**
     * 预付款ID
     */
    private String prepayId;

    /**
     * 微信支付单号
     */
    private String paymentNo;

    /**
     * 支付金额
     */
    private Integer fee;

    /**
     * 支付类型: 1实名认证费用 2活动费 3其他
     */
    private Integer payType;

    /**
     * 支付状态: 0未支付 1已支付
     */
    private Integer payStatus;
}
