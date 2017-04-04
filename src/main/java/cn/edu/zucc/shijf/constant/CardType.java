package cn.edu.zucc.shijf.constant;

/**
 * Created by steven on 2017/4/1.
 */
public enum CardType {

    NOT_SET(0, ""), ID_CARD(1, "身份证"), PASSPORT(2, "护照"), MILITARY_CERTIFICATE(3, "军人证");

    private int value;
    private String name;

    CardType(int value, String name) {
        this.value = value;
        this.name = name;
    }

    public int getValue() {
        return value;
    }

    public String getName() {
        return name;
    }

    public static String getName(int value) {
        CardType[] types = CardType.values();
        for (CardType type : types) {
            if (type.getValue() == value) {
                return type.getName();
            }
        }
        return "";
    }
}
