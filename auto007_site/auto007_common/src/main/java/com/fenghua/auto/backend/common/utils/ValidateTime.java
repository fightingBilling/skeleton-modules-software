package com.fenghua.auto.backend.common.utils;

import java.util.Date;

public class ValidateTime {
	public static boolean validateTimeInvalid(Date newTime, Date oldTime, Long invalidTime) {
		if (newTime.getTime()-oldTime.getTime() > invalidTime) {
			return false;
		}
		return true;
	}
}
