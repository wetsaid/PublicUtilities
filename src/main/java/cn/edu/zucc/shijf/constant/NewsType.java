package cn.edu.zucc.shijf.constant;

/**
 * Created by steven on 2017/3/25.
 */
public enum NewsType {

    CITY_ENVIRONMENT(1, "市容环境"),
    MUNICIPAL_UTILITIES(2, "市政公用设施"),
    LANDSCAPING(3, "园林绿化"),
    STREET_ORDER(4, "街面秩序"),
    EMERGENCY_INCIDENTS(5, "紧急突发事件"),
    OTHER(6, "其他类型");

    private int value;
    private String name;

    NewsType(int value, String name) {
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
        NewsType[] types = NewsType.values();
        for (NewsType type : types) {
            if (type.getValue() == value) {
                return type.getName();
            }
        }
        return "";
    }
}
