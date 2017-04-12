import org.junit.Test;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Created by steven on 2017/4/3.
 */
public class DateTest {

    @Test
    public void testList() {

        List<Integer> list = new ArrayList<Integer>();

        list.add(15);
        list.add(15);

    }

    @Test
    public void testArr() {

        int[] arr = new int[6];

        for (int anArr : arr) {
            System.out.println(anArr);
        }
    }

    @Test
    public void testDate() {

        Calendar cal = Calendar.getInstance();
//        System.out.println(cal.getTime());
//        cal.set(2016, 2, 30, 12, 20, 20);//2011-03-20 12:20:20
        cal.add(Calendar.MONTH, -1);//取前一个月的同一天
        cal.add(Calendar.MONTH, -1);//取前一个月的同一天
        Date date = cal.getTime();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String s = formatter.format(date);
        System.out.println(s);

    }
}
