package com.rsy.rxf.util;

import com.rsy.rxf.springmvc.exception.BusinessException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * Created by zhc on 2017/3/28.
 */
public class AgeUtils {
    private static final Logger LOGGER = LoggerFactory.getLogger(AgeUtils.class);

    /**
     * 根据年月日计算年龄,birthTimeString:"1994-11-14"
     *
     * @param birthTimeString
     * @return
     */
    private static int getAgeFromBirthTime(String birthTimeString) {
        // 先截取到字符串中的年、月、日
        String strs[] = birthTimeString.trim().split("-");
        int selectYear = Integer.parseInt(strs[0]);
        int selectMonth = Integer.parseInt(strs[1]);
        int selectDay = Integer.parseInt(strs[2]);
        // 得到当前时间的年、月、日
        Calendar cal = Calendar.getInstance();
        int yearNow = cal.get(Calendar.YEAR);
        int monthNow = cal.get(Calendar.MONTH) + 1;
        int dayNow = cal.get(Calendar.DATE);

        // 用当前年月日减去生日年月日
        int yearMinus = yearNow - selectYear;
        int monthMinus = monthNow - selectMonth;
        int dayMinus = dayNow - selectDay;

        // 先大致赋值
        int age = yearMinus;
        // 选了未来的年份
        if (yearMinus < 0) {
            age = 0;
        }
        // 同年的，要么为1，要么为0
        else if (yearMinus == 0) {
            // 选了未来的月份
            if (monthMinus < 0) {
                age = 0;
            }
            // 同月份的
            else if (monthMinus == 0) {
                // 选了未来的日期
                if (dayMinus < 0) {
                    age = 0;
                } else if (dayMinus >= 0) {
                    age = 1;
                }
            } else if (monthMinus > 0) {
                age = 1;
            }
        } else if (yearMinus > 0) {
            // 当前月>生日月
            if (monthMinus < 0) {

            }
            // 同月份的，再根据日期计算年龄
            else if (monthMinus == 0) {
                if (dayMinus < 0) {
                } else if (dayMinus >= 0) {
                    age = age + 1;
                }
            } else if (monthMinus > 0) {
                age = age + 1;
            }
        }
        return age;
    }

    /**
     * 根据时间戳计算年龄
     *
     * @param birthTimeLong
     * @return
     */
    public static Integer getAgeFromBirthTime(long birthTimeLong) {
        try {
            Date date = new Date(birthTimeLong * 1000L);
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            String birthTimeString = format.format(date);
            return getAgeFromBirthTime(birthTimeString);
        } catch (Exception e) {
            LOGGER.error("根据时间戳计算年龄异常：", e);
        }
        return null;
    }

    /**
     * add by aberson xie in order to simple date calculator
     *
     * @param birthTimeLong  生日时间戳
     * @return 计算的年龄
     */
    public static Integer getAgeByBirthTime(long birthTimeLong) {
        try {
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(new Date());
            int endYear = calendar.get(Calendar.YEAR);
            calendar.setTime(new Date(birthTimeLong * 1000L));
            int startYear = calendar.get(Calendar.YEAR);
            if (startYear > endYear) {
                throw new BusinessException("时间有误");
            }
            return endYear - startYear;
        } catch (Exception e) {
            LOGGER.error("根据时间戳计算年龄异常：", e);
        }
        return null;
    }

    /**
     * 测试时间
     * 
     * @param args
     * @throws ParseException
     */
    public static void main(String[] args) throws ParseException {
        String agestr = "1998-01-01";
        Date birth = org.apache.commons.lang3.time.DateUtils.parseDate(agestr, "yyyy-MM-dd");
        System.out.println(getAgeByBirthTime(birth.getTime() / 1000));
    }
}
