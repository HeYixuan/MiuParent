package org.igetwell.common.enums;

public enum FeeType {
    FREE(0, "免费"), PAID(1, "付费");

    private final int value;
    private final String message;

    public int value() {
        return this.value;
    }

    public String message() {
        return this.message;
    }

    private FeeType(int value, String message) {
        this.value = value;
        this.message = message;
    }
}
