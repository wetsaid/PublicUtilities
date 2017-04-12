package util;

import cn.edu.zucc.shijf.util.HttpRequest;
import org.junit.Test;

/**
 * Created by steven on 2017/3/22.
 */
public class HttpTest {

    @Test
    public void testWeather() {
        System.out.println(HttpRequest.getWeather("ip"));
    }

}
