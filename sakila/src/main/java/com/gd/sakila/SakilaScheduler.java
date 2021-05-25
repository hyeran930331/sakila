package com.gd.sakila;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.gd.sakila.service.CustomerService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
//@component : 개발자가 직접 작성한 class를 bean으로 등록하기 위해 사용
public class SakilaScheduler {
	@Autowired CustomerService customerService;
	 
	@Scheduled (cron = "0 0 0 1 * *")
	//0초 0분 0시 1일 매일 매년
	//cron 1초(0-59) 2분(0-59) 3시간(0-23) 4일(1-31) 5월(1-DEC) 6요일(0-SAT) 7년(생략-2099)
	//cron *모든수 ?사용안함 1-5기간 ,시간지정 /반복간격 L마지막기간에 동작
	//스케줄러 메서드는 void반환, 매개변수 0 -> 당연한거 아닌지...
	public void modifyCustomerActive() {
		customerService.modifyCustomerActiveByScheduler();
		log.debug("★★★★★ modifyCustomerActive 실행");
	}
}
