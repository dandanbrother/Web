package com.example.Beans;

import java.util.HashMap;
import java.util.Map;

//返回类
public class Message {
	private int code;
	private String message;
	Map<String, Object> extend = new HashMap<>();

	public static Message sucess() {
		Message result = new Message();
		result.setCode(100);
		result.setMessage("Success");
		return result;
	}

	public static Message fail() {
		Message result = new Message();
		result.setCode(200);
		result.setMessage("Fail");
		return result;
	}

	public Message add(String key, Object value) {
		this.getExtend().put(key, value);
		return this;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public void setExtend(Map<String, Object> extend) {
		this.extend = extend;
	}

	public int getCode() {
		return code;
	}

	public String getMessage() {
		return message;
	}

	public Map<String, Object> getExtend() {
		return extend;
	}
}
