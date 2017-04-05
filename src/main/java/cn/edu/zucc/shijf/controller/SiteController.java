package cn.edu.zucc.shijf.controller;

import cn.edu.zucc.shijf.model.Point;
import cn.edu.zucc.shijf.util.CsvUtil;
import cn.edu.zucc.shijf.util.HttpRequest;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.*;

/**
 * Created by steven on 2017/3/20.
 */

@Controller
@RequestMapping("/site")
public class SiteController {

    private Logger log = Logger.getLogger(SiteController.class);

    /**
     * 新建单个服务站点
     *
     * @param request
     * @param point   站点数据
     * @return
     */
    @RequestMapping(value = "/createPoint", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> createPoint(HttpServletRequest request, Point point) {
        Map<String, Object> data = new HashMap<String, Object>();

        log.info(point.toString());

        List<Point> points = new ArrayList<Point>();
        points.add(point);

        String fileName = CsvUtil.writeCsvFile(request.getServletContext().getRealPath("/"), points);
        String response = HttpRequest.uploadFile(fileName);

        parseResponse(response, data);

        return data;
    }

    /**
     * 批量上传服务站点数据
     *
     * @param request
     * @param fileUp  上传的文件
     * @return
     */
    @RequestMapping(value = "/csvImport", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> csvImport(HttpServletRequest request,
                                         @RequestParam("csv") MultipartFile fileUp) {
        Map<String, Object> data = new HashMap<String, Object>();
        if (fileUp == null || fileUp.isEmpty()) {
            log.error("上传文件为空或没有数据");

            data.put("success", false);
            data.put("reason", "上传文件为空或没有数据");
            return data;
        }
        try {
            String rootPath = request.getServletContext().getRealPath("/"); // 获取项目根目录
            File dir = new File(rootPath + "\\csvData\\");
            if (!dir.exists()) { // 目录不存在则创建
                dir.mkdir();
            }
            File fileServer = new File(rootPath + "\\csvData\\" +
                    (new Random().nextInt(100000) + 100000) + fileUp.getOriginalFilename());

            // 复制到服务器
            fileUp.transferTo(fileServer);

            String response = HttpRequest.uploadFile(fileServer.getPath());
            parseResponse(response, data);

        } catch (IOException e) {
            e.printStackTrace();
            log.error(e.getMessage());

            data.put("success", false);
            data.put("reason", e.getMessage());
        }
        return data;
    }

    /**
     * 解析响应
     *
     * @param response
     * @param data
     */
    private void parseResponse(String response, Map<String, Object> data) {

        if (response == null) {
            data.put("success", false);
            data.put("reason", "响应数据异常");
            return;
        }

        JSONObject jsonObject = JSON.parseObject(response);

        int status = jsonObject.getIntValue("status");
        log.info("status: " + status);
        if (status == 0) {
            data.put("success", true);
            data.put("response", jsonObject.getString("message"));
        } else {
            data.put("success", false);
            data.put("reason", jsonObject.getString("message"));
        }
    }
}
