package com.spring.web.controller;

import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController {

	//@ExceptionHandler 애터테이션을 등록한 @Controller, @RestContoller에만 적용 가능
	@ExceptionHandler(NullPointerException.class)
	public Object nullExcept(Exception e) {
		System.err.println(e.getClass());
		return "myService";
	}
}
