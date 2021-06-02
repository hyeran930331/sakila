package com.gd.sakila.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.sakila.vo.Customer;

@Mapper
/*
 * 스프링의 component-scanning 기술이 이 클래스를 어플리케이션 컨텍스트에 빈으로 등록하게 된다.
 * @Component = 어노테이션을 사용해도 상관없다.
 */
public interface CustomerMapper {
	int UpdateCustomerActiveByScheduler();
	List<Map<String,Object>> selectCustomerList (Map<String,Object> map);
	Integer selectCustomerTotal (Map<String,Object> map);
	List<Map<String,Object>> selectRentalListByCustomer(int customerId);
	List<Map<String,Object>> selectCustomerOne (int customerId);
	int insertCustomer(Customer customer);
}
