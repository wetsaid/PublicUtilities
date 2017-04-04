package cn.edu.zucc.shijf.model;

/**
 * 便民服务站点
 *
 * Created by steven on 2017/3/22.
 */
public class Point {

    private String title;

    private String address;

    private double longitude;

    private double latitude;

    private int coordType;

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public int getCoordType() {
        return coordType;
    }

    public void setCoordType(int coordType) {
        this.coordType = coordType;
    }

    @Override
    public String toString() {
        return "Point{" +
                "title='" + title + '\'' +
                ", address='" + address + '\'' +
                ", longitude=" + longitude +
                ", latitude=" + latitude +
                ", coordType=" + coordType +
                '}';
    }
}
