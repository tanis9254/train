package com.rsy.rxf.util;


import org.apache.commons.lang3.time.DateFormatUtils;

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

/**
 * @author: fei.yao
 * @date: 2018/12/25
 * @modified by:
 */
public class DateUtils {

    /**
     * 获取当前时间的YYYY-MM-DD HH:mm:ss格式
     *
     * @return
     */
    public static String getTime() {
        return DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss");
    }

    /**
     * 获取当前时间的后i天
     *
     * @param i
     * @return
     */
    public static String getAddDay(int i) {
        String currentTime = getTime();
        GregorianCalendar gCal = new GregorianCalendar(
                Integer.parseInt(currentTime.substring(0, 4)),
                Integer.parseInt(currentTime.substring(5, 7)) - 1,
                Integer.parseInt(currentTime.substring(8, 10)));
        gCal.add(GregorianCalendar.DATE, i);
        return DateFormatUtils.format(gCal.getTime(), "yyyy-MM-dd");
    }

    /**
     * 获取当前时间的后i天
     * 精确到秒
     *
     * @param i
     * @return
     */
    public static String getAddDayTime(int i) {
        Date date = new Date(System.currentTimeMillis() + i * 24 * 60 * 60 * 1000);
        return DateFormatUtils.format(date, "yyyy-MM-dd HH:mm:ss");
    }

    /**
     * 获取当前时间的+多少秒
     * 精确到秒
     *
     * @param i
     * @return
     */
    public static String getAddDaySecond(int i) {
        Date date = new Date(System.currentTimeMillis() + i * 1000);
        return DateFormatUtils.format(date, "yyyy-MM-dd HH:mm:ss");
    }

    /**
     * 获取时间的年月日
     *
     * @param date 时间，为空，则为当前时间
     * @return
     */
    public static int[] getYearAndMonthAndDay(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date == null ? new Date() : date);
        return new int[]{
                calendar.get(Calendar.YEAR),
                calendar.get(Calendar.MONTH) + 1,
                calendar.get(Calendar.DAY_OF_MONTH)
        };
    }

    /**
     * 获取凌晨时间,即时分秒均为凌晨
     *
     * @return
     */
    public static Date getEarlyDate(Date date) {
        return org.apache.commons.lang3.time.DateUtils.setMilliseconds(
                org.apache.commons.lang3.time.DateUtils.setSeconds(
                        org.apache.commons.lang3.time.DateUtils.setMinutes(
                                org.apache.commons.lang3.time.DateUtils.setHours(
                                        date == null ? new Date() : date,
                                        0),
                                0),
                        0),
                0);
    }
}
