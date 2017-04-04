package cn.edu.zucc.shijf.constant;

/**
 * Created by steven on 2017/3/25.
 */
public enum NewsStatus {

    PENDING(1),
    PASSED(2),
    FAILED(3),
    SOLVED(4);

    private int value;

    NewsStatus(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }
}
