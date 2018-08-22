package org.igetwell.common.enums;

public enum SexType {

    M("M","男"), F("F","女"), N("N","未知");

    private final String value;
    private final String message;

    public String value() {
        return this.value;
    }

    public String message() {
        return this.message;
    }

    private SexType(String value, String message) {
        this.value = value;
        this.message = message;
    }
}
