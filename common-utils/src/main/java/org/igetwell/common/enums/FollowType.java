package org.igetwell.common.enums;

public enum FollowType {

    SUBSCRIBE(0, "未关注"), UNSUBSCRIBE(1, "已关注");

    private final int value;
    private final String message;

    public int value() {
        return this.value;
    }

    public String message() {
        return this.message;
    }

    private FollowType(int value, String message) {
        this.value = value;
        this.message = message;
    }
}
