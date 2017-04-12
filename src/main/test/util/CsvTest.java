package util;

import cn.edu.zucc.shijf.util.CsvUtil;
import org.junit.Test;

/**
 * Created by steven on 2017/3/23.
 */
public class CsvTest {

    @Test
    public void writerCsv() {
        CsvUtil.writeCsvFile("C:\\Users\\steve\\Desktop", null);
    }
}
