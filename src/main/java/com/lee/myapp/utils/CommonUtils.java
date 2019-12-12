package com.lee.myapp.utils;

import java.text.DecimalFormat;
import java.util.Calendar;

public class CommonUtils {
	public static String CreateRandomNumber() {
		Calendar calendar = Calendar.getInstance();
		String subNum = "";
		
		String ymd = calendar.get(Calendar.YEAR) 
				+ new DecimalFormat("00").format(calendar.get(Calendar.MONTH) + 1)
				+ new DecimalFormat("00").format(calendar.get(Calendar.DATE));
		
		for(int i=1;i<=6;i++) {
			subNum += (int)(Math.random() * 10);
		}
		
		return ymd + "-" + subNum;
	}
}
