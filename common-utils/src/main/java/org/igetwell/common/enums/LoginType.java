package org.igetwell.common.enums;

public enum LoginType {

    WECHAT(1), ALI_PAY(2), WEB_LOGIN(3);

    LoginType(int value) {
        this.value = value;
    }

    private int value;

    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }
}
