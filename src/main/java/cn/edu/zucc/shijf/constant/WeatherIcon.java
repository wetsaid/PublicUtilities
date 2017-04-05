package cn.edu.zucc.shijf.constant;

/**
 * Created by steven on 2017/4/4.
 */
public enum WeatherIcon {

    SUNNY(0, "wi-day-sunny"),
    CLEAR(1, "wi-night-clear"),
    FAIR(2, "wi-day-sunny"),
    FAIR_N(3, "wi-night-clear"),
    CLOUDY(4, "wi-cloudy"),
    PARTLY_CLOUDY(5, "wi-day-cloudy"),
    PARTLY_CLOUDY_N(6, "wi-night-cloudy"),
    MOSTLY_CLOUDY(7, "wi-cloudy"),
    MOSTLY_CLOUDY_N(8, "wi-cloudy"),
    OVERCAST(9, "wi-cloud"),
    SHOWER(10, "wi-showers"),
    THUNDERSHOWER(11, "wi-storm-showers"),
    THUNDERSHOWER_WITH_HAIL(12, "wi-storm-showers"),
    LIGHT_RAIN(13, "wi-rain-mix"),
    MODERATE_RAIN(14, "wi-rain"),
    HEAVY_RAIN(15, "wi-rain"),
    STORM(16, "wi-thunderstorm"),
    HEAVY_STORM(17, "wi-thunderstorm"),
    SEVERE_STORM(18, "wi-thunderstorm"),
    ICE_RAIN(19, "wi-hail"),
    SLEET(20, "wi-hail"),
    SNOW_FLURRY(21, "wi-snow"),
    LIGHT_SNOW(22, "wi-snow"),
    MODERATE_SNOW(23, "wi-snow"),
    HEAVY_SNOW(24, "wi-snow"),
    SNOWSTORM(25, "wi-snow"),
    DUST(26, "wi-fog"),
    SAND(27, "wi-fog"),
    DUST_STORM(28, "wi-fog"),
    SAND_STORM(29, "wi-fog"),
    FOGGY(30, "wi-fog"),
    Haze(31, "wi-fog"),
    WINDY(32, "wi-windy"),
    BLUSTERY(33, "wi-strong-wind"),
    HURRICANE(34, "wi-tornado"),
    TROPICAL_STORM(35, "wi-tornado"),
    TORNADO(36, "wi-tornado"),
    COLD(37, "wi-snow"),
    HOT(38, "wi-sunny"),
    UNKNOWN(99, "wi-cloud-refresh");

    private int code;
    private String icon;

    WeatherIcon(int code, String icon) {
        this.code = code;
        this.icon = icon;
    }

    public int getCode() {
        return code;
    }

    public String getIcon() {
        return icon;
    }

    public static String getIcon(int code) {
        WeatherIcon[] icons = WeatherIcon.values();
        for (WeatherIcon icon : icons) {
            if (icon.getCode() == code) {
                return icon.getIcon();
            }
        }
        return "";
    }
}
