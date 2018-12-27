package org.igetwell.common.enums;

public enum PayType {

    AUTH(1, "认证费用"), ACTIVITY(2, "活动费"), OTHER(3, "其他");


    private final int value;
    private final String message;

    public int value() {
        return this.value;
    }

    public String getMessage() {
        return this.message;
    }

    private PayType(int value, String message) {
        this.value = value;
        this.message = message;
    }
}
