package com.gd.sakila.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.sakila.mapper.CustomerMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j //log.debug를 위해서
@Transactional 
@Service
/*
 * 스프링의 component-scanning 기술이 이 클래스를 어플리케이션 컨텍스트에 빈으로 등록하게 되는 
 * @Component = 어노테이션을 사용해도 상관없다.
 * 
@Service 어노테이션을 사용함으로써 해당 클래스가 서비스 레이어 클래스라는 것을 명확하게 할 수 있다.
현재는 @Repository 어노테이션 처럼 추가적인 behavior는 없지만, 추후에 추가될 예정이다.
- 서비스 객체임을 명시. Classpath스캔을 통해 자동으로 감지됨.
 */
public class CustomerService {
	@Autowired CustomerMapper customerMapper;
	
	public void modifyCustomerActiveByScheduler() {
		log.debug("ⓢCustomerServiceⓢ: modifyCustomerActiveByScheduler() 실행");
		int row = customerMapper.UpdateCustomerActiveByScheduler();
		log.debug("ⓢCustomerServiceⓢ: 실행결과 "+row);
	}
}
