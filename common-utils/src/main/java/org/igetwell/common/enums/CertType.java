package org.igetwell.common.enums;

public enum CertType {

    UNAUTHORIZED(0, "未认证"), AUTHORIZED(1, "已认证"), AUTHORIZED_FAIL(2, "认证失败");

    private final int value;
    private final String message;

    public int value() {
        return this.value;
    }

    public String message() {
        return this.message;
    }

    private CertType(int value, String message) {
        this.value = value;
        this.message = message;
    }
}
