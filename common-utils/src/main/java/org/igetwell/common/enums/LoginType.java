package org.igetwell.common.enums;

public enum LoginType {

    WECHAT(1,"微信"), WEB_LOGIN(2,"网站");

    LoginType(int value, String message) {
        this.value = value;
        this.message = message;
    }

    private final int value;
    private final String message;

    public int value() {
        return this.value;
    }

    public String message() {
        return this.message;
    }
}
