package cn.edu.zucc.shijf.util;

import cn.edu.zucc.shijf.model.Point;
import okhttp3.*;
import org.apache.log4j.Logger;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;

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

    public static String createPoint(Point point) {
        String response = null;

        try {
            URL url = new URL("http://api.map.baidu.com/geodata/v3/poi/create");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            conn.setDoInput(true);
            conn.setUseCaches(false);
            conn.setRequestProperty("connection", "Keep-Alive");
            conn.setRequestProperty("Charsert", "UTF-8");
            conn.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + BOUNDARY);

            OutputStream out = new DataOutputStream(conn.getOutputStream());

            StringBuilder sb = new StringBuilder();

            // ak
            setNormalParam(sb, "ak", "lSgygOFifAH9G7fXOYB7Uap9lqnjcXe5");
//            sb.append(BOUNDARY_PREFIX)
//                    .append(BOUNDARY)
//                    .append(NEW_LINE)
//                    .append("Content-Disposition: form-data; name=\"ak\"")
//                    .append(NEW_LINE)
//                    .append(NEW_LINE)
//                    .append("lSgygOFifAH9G7fXOYB7Uap9lqnjcXe5")
//                    .append(NEW_LINE);

            // geotable_id
            setNormalParam(sb, "geotable_id", 164910);
//            sb.append(BOUNDARY_PREFIX)
//                    .append(BOUNDARY)
//                    .append(NEW_LINE)
//                    .append("Content-Disposition: form-data; name=\"geotable_id\"")
//                    .append(NEW_LINE)
//                    .append(NEW_LINE)
//                    .append(164910)
//                    .append(NEW_LINE);

            setNormalParam(sb, "title", point.getTitle());

            setNormalParam(sb, "address", point.getAddress());

            setNormalParam(sb, "longitude", point.getLongitude());
//            sb.append(BOUNDARY_PREFIX)
//                    .append(BOUNDARY)
//                    .append(NEW_LINE)
//                    .append("Content-Disposition: form-data; name=\"longitude\"")
//                    .append(NEW_LINE)
//                    .append(NEW_LINE)
//                    .append(point.getLongitude())
//                    .append(NEW_LINE);

            setNormalParam(sb, "latitude", point.getLatitude());
//            sb.append(BOUNDARY_PREFIX)
//                    .append(BOUNDARY)
//                    .append(NEW_LINE)
//                    .append("Content-Disposition: form-data; name=\"latitude\"")
//                    .append(NEW_LINE)
//                    .append(NEW_LINE)
//                    .append(30.33)
//                    .append(NEW_LINE);
//
//            setNormalParam(sb, "coord_type", point.getCoordType());

            // 结尾标识
            sb.append(NEW_LINE)
                    .append(BOUNDARY_PREFIX)
                    .append(BOUNDARY)
                    .append(BOUNDARY_PREFIX)
                    .append(NEW_LINE);

            log.info(NEW_LINE + sb.toString());

            out.write(sb.toString().getBytes());
            out.flush();
            out.close();

            // 读取URL的响应
            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
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
            conn.setRequestProperty("Charsert", "UTF-8");
            conn.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + BOUNDARY);

            OutputStream out = new DataOutputStream(conn.getOutputStream());

            // 上传文件
            File file = new File(fileName);

            StringBuilder sb = new StringBuilder();

            // ak
            setNormalParam(sb, "ak", "lSgygOFifAH9G7fXOYB7Uap9lqnjcXe5");
//            sb.append(BOUNDARY_PREFIX)
//                    .append(BOUNDARY)
//                    .append(NEW_LINE)
//                    .append("Content-Disposition: form-data; name=\"ak\"")
//                    .append(NEW_LINE)
//                    .append(NEW_LINE)
//                    .append("lSgygOFifAH9G7fXOYB7Uap9lqnjcXe5")
//                    .append(NEW_LINE);

            // geotable_id
            setNormalParam(sb, "geotable_id", 164910);
//            sb.append(BOUNDARY_PREFIX)
//                    .append(BOUNDARY)
//                    .append(NEW_LINE)
//                    .append("Content-Disposition: form-data; name=\"geotable_id\"")
//                    .append(NEW_LINE)
//                    .append(NEW_LINE)
//                    .append(164910)
//                    .append(NEW_LINE);

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


    // not OK
    public static String testOK() {

        String res = null;

        try {

            MediaType JSON
                    = MediaType.parse("multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW");

            OkHttpClient client = new OkHttpClient();

            RequestBody body = RequestBody.create(JSON, "------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"ak\"\r\n\r\nlSgygOFifAH9G7fXOYB7Uap9lqnjcXe5\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"geotable_id\"\r\n\r\n164910\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"title\"\r\n\r\ntttttt\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"address\"\r\n\r\ntesttest\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"longitude\"\r\n\r\n120\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"latitude\"\r\n\r\n\"30\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"coord_type\"\r\n\r\n1\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW--");
            Request request = new Request.Builder()
                    .url("http://api.map.baidu.com/geodata/v3/poi/create")
                    .post(body)
                    .build();
            Response response = client.newCall(request).execute();


//            OkHttpClient client = new OkHttpClient();
//
//            MediaType mediaType = MediaType.parse("multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW");
//            RequestBody body = RequestBody.create(mediaType, "------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"ak\"\r\n\r\nlSgygOFifAH9G7fXOYB7Uap9lqnjcXe5\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"geotable_id\"\r\n\r\n164910\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"title\"\r\n\r\ntttttt\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"address\"\r\n\r\ntesttest\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"longitude\"\r\n\r\n120\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"latitude\"\r\n\r\n\"30\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"coord_type\"\r\n\r\n1\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW--");
//            Request request = new Request.Builder()
//                    .url("http://api.map.baidu.com/geodata/v3/poi/create")
//                    .post(body)
//                    .addHeader("content-type", "multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW")
//                    .addHeader("cache-control", "no-cache")
//                    .build();
//
//            Response response = client.newCall(request).execute();

            res = response.body().string();

        } catch (IOException e) {
            e.printStackTrace();
            log.error(e.getMessage());
        }


        return res;
    }
}
