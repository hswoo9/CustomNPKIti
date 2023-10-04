package com.duzon.custom.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

public class DateTimeUtil {
	
	/**
	 * 원하는 날짜 패턴으로 변경
	 * @param regDate 변경할 날짜
	 * @param pattern 변경할 패턴
	 * @return
	 */
	public static String getDateTimeByPattern(Date regDate, String pattern) {
		if (regDate == null) return null;
		
		SimpleDateFormat formatter = new SimpleDateFormat(pattern, Locale.KOREA);
		return formatter.format(regDate);
	}
	
	public static Date strToDateTime(String strDate, String pattern) throws ParseException {
		if (strDate == null || "".equals(strDate)) return null;

		SimpleDateFormat formatter = new SimpleDateFormat(pattern);

		return formatter.parse(strDate);
	}
	
	/**
	 * 년월에 해당하는 달력 리턴
	 * @param year 년
	 * @param month 월
	 * @return
	 */
	public static Object[][] getCalendar(int year, int month) {
		Calendar cal = Calendar.getInstance();
		cal.set(year, month-1, 1);
		int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		int firstDay = cal.get(Calendar.DAY_OF_WEEK);
		Object temp[][] = new Object[6][7];
		int daycount = 1;
		for (int i = 0; i < 6; i++) { 
			for (int j = 0; j < 7; j++) {
				if (firstDay - 1 > 0 || daycount > lastDay) {
					temp[i][j] = "";
					firstDay--;
					continue;
				} else {
					temp[i][j] = String.valueOf(daycount);
				}
				daycount++;
			}
		}
		
		return temp;
	}
		
	/**
	 * 요일 리턴
	 * @param year 년
	 * @param month 월
	 * @param day 일
	 * @return
	 */
	public static String getDayOfWeek(int year,int month,int day){
		String[] weeks = {"일요일","월요일","화요일","수요일","목요일","금요일","토요일"};
		Calendar cal = Calendar.getInstance();
		cal.set(year,month-1,day);
		int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
		return weeks[dayOfWeek-1];
	}
}
