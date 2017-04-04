package cn.edu.zucc.shijf.util;

import cn.edu.zucc.shijf.model.Point;
import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVPrinter;
import org.apache.log4j.Logger;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

/**
 * Created by steven on 2017/3/22.
 */
public class CsvUtil {

    private static Logger log = Logger.getLogger(CsvUtil.class);

    // CSV文件分隔符
    private static final String NEW_LINE_SEPARATOR = "\n";

    // CSV文件头
    private static final Object[] FILE_HEADER = {"title", "address", "longitude", "latitude", "coord_type"};

    public static String writeCsvFile(String rootPath, List<Point> points) {

        String fileName = null;

        FileWriter fileWriter = null;
        CSVPrinter csvFilePrinter = null;
        // 创建 CSVFormat
        CSVFormat csvFileFormat = CSVFormat.DEFAULT.withRecordSeparator(NEW_LINE_SEPARATOR);
        try {
            // 目录不存在则创建
            File dir = new File(rootPath + "csvData\\");
            if (!dir.exists()) {
                dir.mkdir();
            }
            fileName = rootPath + "csvData\\" + (new Random().nextInt(100000) + 100000) + ".csv";
            // 初始化FileWriter
            fileWriter = new FileWriter(fileName);
            // 初始化 CSVPrinter
            csvFilePrinter = new CSVPrinter(fileWriter, csvFileFormat);
            // 创建CSV文件头
            csvFilePrinter.printRecord(FILE_HEADER);

            // 写入csv
            for (Point point : points) {
                List<Object> record = new ArrayList<Object>();
                record.add(point.getTitle());
                record.add(point.getAddress());
                record.add(point.getLongitude());
                record.add(point.getLatitude());
                record.add(point.getCoordType());

                csvFilePrinter.printRecord(record);
            }
            log.info("CSV文件创建成功: " + fileName);

        } catch (Exception e) {
            e.printStackTrace();
            log.error(e.getMessage());
        } finally {
            try {
                fileWriter.flush();
                fileWriter.close();
                csvFilePrinter.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        return fileName;
    }
}
