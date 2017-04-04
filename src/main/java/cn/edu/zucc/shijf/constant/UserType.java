package cn.edu.zucc.shijf.constant;

/**
 * Created by steven on 2017/4/4.
 */
public enum UserType {

    ADMINISTRATOR(1), USER(2);

    private int value;

    UserType(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }
}
