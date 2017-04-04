package cn.edu.zucc.shijf.constant;

/**
 * Created by steven on 2017/4/4.
 */
public enum WeatherIcon {

    Sunny(0, "wi-day-sunny"),
    Clear(1, "wi-night-clear"),
    Fair(2, "wi-day-sunny"),
    Fair_N(3, "wi-night-clear"),
    Cloudy(4, "wi-cloudy"),
    Partly_Cloudy(5, "wi-day-cloudy"),
    Partly_Cloudy_N(6, "wi-night-cloudy"),
    Mostly_Cloudy(7, "wi-cloudy"),
    Mostly_Cloudy_N(8, "wi-cloudy"),
    Overcast(9, "wi-cloud"),
    Shower(10, "wi-showers"),
    Thundershower(11, "wi-storm-showers"),
    Thundershower_with_Hail(12, "wi-storm-showers"),
    Light_Rain(13, "wi-rain-mix"),
    Moderate_Rain(14, "wi-rain"),
    Heavy_Rain(15, "wi-rain"),
    Storm(16, "wi-thunderstorm"),
    Heavy_Storm(17, "wi-thunderstorm"),
    Severe_Storm(18, "wi-thunderstorm"),
    Ice_Rain(19, "wi-hail"),
    Sleet(20, "wi-hail"),
    Snow_Flurry(21, "wi-snow"),
    Light_Snow(22, "wi-snow"),
    Moderate_Snow(23, "wi-snow"),
    Heavy_Snow(24, "wi-snow"),
    Snowstorm(25, "wi-snow"),
    Dust(26, "wi-fog"),
    Sand(27, "wi-fog"),
    Duststorm(28, "wi-fog"),
    Sandstorm(29, "wi-fog"),
    Foggy(30, "wi-fog"),
    Haze(31, "wi-fog"),
    Windy(32, "wi-windy"),
    Blustery(33, "wi-strong-wind"),
    Hurricane(34, "wi-tornado"),
    Tropical_Storm(35, "wi-tornado"),
    Tornado(36, "wi-tornado"),
    Cold(37, "wi-snow"),
    Hot(38, "wi-sunny"),
    Unknown(99, "wi-cloud-refresh");

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
