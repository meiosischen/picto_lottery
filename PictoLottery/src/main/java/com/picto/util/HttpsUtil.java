package com.picto.util;

import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;

public class HttpsUtil {
	/**
	 * https get request
	 * @param url
	 * @param charset
	 * @return
	 * @throws IOException
	 */
	public static String get(String url, String charset) throws IOException {
		InputStream is = null;
		try {
			URL urlGet = new URL(url);
			HttpURLConnection http = (HttpURLConnection) urlGet.openConnection();
			http.setRequestMethod("GET");
			http.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			http.setDoOutput(true);
			http.setDoInput(true);
			System.setProperty("sun.net.client.defaultConnectTimeout", "30000");
			System.setProperty("sun.net.client.defaultReadTimeout", "30000");
			http.connect();
			is = http.getInputStream();
			int size = is.available();
			byte[] buf = new byte[size];
			is.read(buf);
			return new String(buf, charset);
		} finally {
			if (null != is) {
				is.close();
			}
		}
	}
}
