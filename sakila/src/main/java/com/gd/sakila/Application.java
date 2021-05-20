package com.gd.sakila;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;

@ServletComponentScan //spring filter를 안쓰기 때문에 들어감.
@SpringBootApplication //
public class Application {

	public static void main(String[] args) {
		SpringApplication.run(Application.class, args); //@된 것들을 스캔해서 객체에 등록함.
	}

}
