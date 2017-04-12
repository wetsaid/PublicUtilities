package cn.edu.zucc.shijf.util;

import org.apache.log4j.Logger;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;
import java.util.Map;

/**
 * Created by steven on 2017/3/20.
 */
public class HttpRequest {

    private static Logger log = Logger.getLogger(HttpRequest.class);

    // 换行符
    private static final String NEW_LINE = "\r\n";
    private static final String BOUNDARY_PREFIX = "--";
    // 定义数据分隔线
    private static final String BOUNDARY = "----WebKitFormBoundary7MA4YWxkTrZu0gW";

    private static void setNormalParam(StringBuilder sb, String key, Object value) {

        log.info(key + ": " + value);

        sb.append(BOUNDARY_PREFIX)
                .append(BOUNDARY)
                .append(NEW_LINE)
                .append("Content-Disposition: form-data; name=\"")
                .append(key)
                .append("\"")
                .append(NEW_LINE)
                .append(NEW_LINE)
                .append(value)
                .append(NEW_LINE);
    }

    /**
     * 批量上传数据（csv文件）到LBS
     *
     * @param fileName
     * @return 请求结果（Json字符串）
     */
    public static String uploadFile(String fileName) {
        String response = null;
        try {
            // 服务器的域名
            URL url = new URL("http://api.map.baidu.com/geodata/v3/poi/upload");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            // 设置为POST请求
            conn.setRequestMethod("POST");
            // 发送POST请求必须设置如下两行
            conn.setDoOutput(true);
            conn.setDoInput(true);
            conn.setUseCaches(false);
            // 设置请求头参数
            conn.setRequestProperty("connection", "Keep-Alive");
            conn.setRequestProperty("Charset", "UTF-8");
            conn.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + BOUNDARY);

            OutputStream out = new DataOutputStream(conn.getOutputStream());

            // 上传文件
            File file = new File(fileName);

            StringBuilder sb = new StringBuilder();

            // ak
            setNormalParam(sb, "ak", "lSgygOFifAH9G7fXOYB7Uap9lqnjcXe5");

            // geotable_id
            setNormalParam(sb, "geotable_id", 164910);

            // poi_list （csv文件）
            sb.append(BOUNDARY_PREFIX)
                    .append(BOUNDARY)
                    .append(NEW_LINE)
                    .append("Content-Disposition: form-data; name=\"poi_list\"; filename=\"")
                    .append(fileName)
                    .append("\"")
                    .append(NEW_LINE)
                    .append("Content-Type: text/csv")

                    // 参数头设置完以后需要两个换行，然后才是参数内容
                    .append(NEW_LINE)
                    .append(NEW_LINE);

            // 将参数头的数据写入到输出流中
            out.write(sb.toString().getBytes());

            // 数据输入流,用于读取文件数据
            DataInputStream in = new DataInputStream(new FileInputStream(
                    file));
            byte[] bufferOut = new byte[1024];
            int bytes = 0;
            // 每次读1KB数据,并且将文件数据写入到输出流中
            while ((bytes = in.read(bufferOut)) != -1) {
                out.write(bufferOut, 0, bytes);
            }
            // 最后添加换行
            out.write(NEW_LINE.getBytes());
            in.close();

            // 定义最后数据分隔线，即--加上BOUNDARY再加上--。
            byte[] end_data = (NEW_LINE + BOUNDARY_PREFIX + BOUNDARY + BOUNDARY_PREFIX + NEW_LINE)
                    .getBytes();
            // 写上结尾标识
            out.write(end_data);
            out.flush();
            out.close();

            // 定义BufferedReader输入流来读取URL的响应
            BufferedReader reader = new BufferedReader(new InputStreamReader(
                    conn.getInputStream()));
            if ((response = reader.readLine()) != null) {
                log.info(response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            log.error("发送POST请求出现异常！" + e.getMessage());
        }
        return response;
    }

    /**
     * 获取天气信息
     *
     * @param location "城市拼音" / "ip"
     * @return
     */
    public static String getWeather(String location) {
        String url = "http://api.thinkpage.cn/v3/weather/now.json?key=ewouglcib2zqjbpm&location=" + location;

        String result = "";
        BufferedReader in = null;
        try {
            URL realUrl = new URL(url);
            //打开和URL之间的连接
            HttpURLConnection conn = (HttpURLConnection) realUrl.openConnection();
            //设置通用的请求属性
            conn.setRequestProperty("Charset", "UTF-8");
            conn.setRequestProperty("accept", "*/*");
            conn.setRequestProperty("connection", "Keep-Alive");
            conn.setRequestProperty("user-agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)");
            //建立实际的连接
            conn.connect();
            //获取所有响应头字段
            Map<String, List<String>> map = conn.getHeaderFields();
            //遍历所有的响应头字段
            for (String key : map.keySet()) {
                System.out.println(key + "--->" + map.get(key));
            }
            //定义BufferedReader输入流来读取URL的响应
            in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line;
            while ((line = in.readLine()) != null) {
                result += line;
            }
        } catch (Exception e) {
            System.out.println("发送GET请求出现异常！" + e);
            e.printStackTrace();
        }
        //使用finally块来关闭输入流
        finally {
            try {
                if (in != null) {
                    in.close();
                }
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
        return result;
    }

}
