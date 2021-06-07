package com.gd.sakila.controller;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PaymentMapper {

	int updatePaymentAmount(Map<String, Object> paramMap);

}
