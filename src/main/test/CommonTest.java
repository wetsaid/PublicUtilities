import cn.edu.zucc.shijf.model.Point;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.junit.Test;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by steven on 2017/3/22.
 */
public class CommonTest {

    @Test
    public void testJSON() {
        String str = "{}";
        JSONObject object = JSON.parseObject(str);
//        int i = object.getIntValue("status");
        System.out.println("i: " + object.containsKey("status"));
//        if (0 == object.getIntValue("status"))
//            System.out.println(object.getIntValue("status"));
//        else
//            System.out.println("err");
    }

    private String str = "before";
    private String str2 = "before";
    String string = new String("sssss");

    Point p = new Point();

    private void setStr(String str, String string) {
        str = "after";
        string = "bbbbbb";
        System.out.println("tttttttttt" + string);
//        string = new String("new");
    }

    private void setP(Point p) {
        p.setTitle("title");
    }

    @Test
    public void testP() {
        setP(p);
        System.out.println(p.getTitle());
    }

    @Test
    public void testStr() {
        setStr(str, string);
        System.out.println(str);
        System.out.println(string);
    }

    @Test
    public void testDate() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss");

        long l = System.currentTimeMillis();
        Date date = new Date(l);
        System.out.println(sdf.format(date));
    }
}
