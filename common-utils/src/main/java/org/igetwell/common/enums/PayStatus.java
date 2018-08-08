package org.igetwell.common.enums;

public enum PayStatus {

    WAITPAY(0, "未支付"),PAY(1, "已支付");


    private final int value;
    private final String message;

    public int value() {
        return this.value;
    }

    public String getMessage() {
        return this.message;
    }

    private PayStatus(int value, String message) {
        this.value = value;
        this.message = message;
    }
}
