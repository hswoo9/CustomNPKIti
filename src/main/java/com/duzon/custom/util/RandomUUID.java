package com.duzon.custom.util;

import java.util.UUID;

public class RandomUUID {
	public static String getRandomString() {
		return UUID.randomUUID().toString().replace("-", "");
	}
}
