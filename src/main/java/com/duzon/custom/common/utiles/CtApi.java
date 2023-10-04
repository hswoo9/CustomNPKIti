package com.duzon.custom.common.utiles;

import java.net.URI;
import java.util.HashMap;
import java.util.Map;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

public class CtApi {
	
	private static final Logger logger = LoggerFactory.getLogger(CtApi.class);
	
	private final String MESSAGE = "messenger/api/MessageSendInterLock";
	private final String COME_LEAVE = "attend/updateComeLeaveCustomize";
	private final String SCHEDULE = "schedule/MobileSchedule/InsertMtSchedule";
	private final String SCHEDULE_DEL = "schedule/MobileSchedule/DeleteMtSchedule";
	
	
	/**
	 * 2018. 8. 26.
	 * yh
	 * :api 호출
	 */
	private Map<String, Object> commonApi(String data, String api){
		
		RequestConfig.Builder requestBuilder = RequestConfig.custom();
	    HttpClientBuilder builder = HttpClientBuilder.create();
	    builder.setDefaultRequestConfig(requestBuilder.build());
	    HttpClient client = builder.build();
	    ObjectMapper mapper = new ObjectMapper();
	    String result = "";
	    
	    Gson gson = new Gson(); 
	 
	    StringEntity stringEntity;
	    
	    Map<String, Object> apiResult = new HashMap<String, Object>();
	    
		try {
			stringEntity = new StringEntity(data, "UTF-8");
		    
		    HttpPost httpost = new HttpPost(new URI("http://gw.sportsafety.or.kr/" + api));
		    httpost.addHeader("Content-Type", "application/json");
		    HttpResponse response;
		    httpost.setEntity(stringEntity);
		    
		    response = client.execute(httpost);
		    result = EntityUtils.toString(response.getEntity());
		    apiResult = mapper.readValue(result, new TypeReference<Map<String, Object>>() {});
		    Map<String, String> ap = gson.fromJson(EntityUtils.toString(response.getEntity()), new TypeToken<Map<String, String>>(){}.getType());
		    
		} catch (Exception e) {
			logger.debug(e + " : " +result);
		}
		
		apiResult = (Map<String, Object>) apiResult.get("result");
		
		return apiResult;
	}
	
	/**
	 * 2018. 8. 26.
	 * yh
	 * :쪽지 api호출
	 */
	public Map<String, Object> messageApi(String data) {
		
		return commonApi(data, MESSAGE);
		
	}

	/**
	 * 2018. 8. 29.
	 * yh
	 * :퇴근 api호출
	 */
	public Map<String, Object> comeLeaveApi(String data) {
		
		return commonApi(data, COME_LEAVE);
		
	}
	
	/**
		 * @MethodName : scheduleApi
		 * @author : gato
		 * @since : 2019. 4. 12.
		 * 설명 : 일정api호출
		 */
	public Map<String, Object> scheduleApi(String data) {
		
		return commonApi(data, SCHEDULE);
		
	}
	
	/**
	 * @MethodName : scheduleApi
	 * @author : gato
	 * @since : 2019. 4. 12.
	 * 설명 : 일정api호출
	 */
public Map<String, Object> scheduleDelApi(String data) {
	
	return commonApi(data, SCHEDULE_DEL);
	
}
	
	

}
