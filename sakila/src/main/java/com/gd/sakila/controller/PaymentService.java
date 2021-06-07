package com.gd.sakila.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional
public class PaymentService {
	@Autowired PaymentMapper paymentMapper;

	public void modifyPaymentAmount(Map<String, Object> paramMap) {
		log.debug("3 콘트롤러에서 온 paramMap 확인 : "+paramMap);
		
		int cnt = paymentMapper.updatePaymentAmount(paramMap);
		log.debug("5 콘트롤러에 보낸 cnt 확인 : "+cnt);
	}
	
	
}
