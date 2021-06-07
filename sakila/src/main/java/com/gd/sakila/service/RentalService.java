package com.gd.sakila.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;


@Service
@Slf4j
public class RentalService {
@Autowired RentalMapper rentalMapper;

	public void modifyReturnDate(Map<String, Object> paramMap) {
		log.debug("3 콘트롤러에서 온 paramMap 확인 : "+ paramMap);
		log.debug("4 매버포 보낼 paramMap 확인 : "+ paramMap.toString());
		int cnt = rentalMapper.updateRental(paramMap);
		log.debug("5 매퍼에서 온 cnt 확인 : "+ cnt);
	}

}
