package com.gd.sakila.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.sakila.mapper.AddressMapper;
import com.gd.sakila.mapper.CityMapper;
import com.gd.sakila.mapper.CountryMapper;
import com.gd.sakila.mapper.CustomerMapper;
import com.gd.sakila.vo.Address;
import com.gd.sakila.vo.City;
import com.gd.sakila.vo.Country;
import com.gd.sakila.vo.Customer;

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
	@Autowired AddressMapper addressMapper;
	
	public Map<String,Object> getCustomerList (Map<String,Object> paramMap) {
		log.debug("2. 콘트롤러에서 온 paramMap확인"+paramMap.toString());
		//paramMap에서 curentPage, rowPerPage, searchWord, storeId 받아옴
		int total = customerMapper.selectCustomerTotal(paramMap);
		int lastPage = (int)(Math.ceil(total/(int)paramMap.get("rowPerPage")));
		int beginRow = ( ( (int)(paramMap.get("currentPage")) -1) * (int)(paramMap.get("rowPerPage")) );
		
		
		//map에서 beginRow rowPerPage, searchWord, storeId 줘야함
		paramMap.put("beginRow", beginRow);
		log.debug("3. 매퍼에 줄 paramMap확인"+paramMap.toString());
		
		List<Map<String,Object>> customerList = customerMapper.selectCustomerList(paramMap);
		log.debug("4. 매퍼에서 받은 List 확인"+paramMap.toString());
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("lastPage", lastPage);
		resultMap.put("customerList", customerList);
		return resultMap;
	}

	public void modifyCustomerActiveByScheduler() {
		// TODO Auto-generated method stub
	}

	public Map<String, Object> getCustomerOne(int customerId) {
		log.debug("2. 콘트롤러에서 온 int 확인"+customerId);
		List<Map<String,Object>> customerOne = customerMapper.selectCustomerOne(customerId);
		log.debug("3. 매퍼에서 받은 List 확인"+customerOne.toString());
		List<Map<String,Object>> rentalList = customerMapper.selectRentalListByCustomer(customerId);
		log.debug("4. 매퍼에서 받은 List 확인"+rentalList.toString());
		Map<String,Object> paramMap = new HashMap<String,Object>();
		int total = customerMapper.selectCustomerTotal(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("customerOne", customerOne);
		resultMap.put("rentalList", rentalList);
		resultMap.put("total", total);
		return resultMap;
	}

	public int addCustomer(Customer customer,Address address) {
		log.debug("2. 콘트롤러에서 온 param확인" +customer);
		log.debug("2. 콘트롤러에서 온 param확인" +address);
		
		addressMapper.insertAddress(address);
		int row = customerMapper.insertCustomer(customer);
		log.debug("3. 콘트롤러에 보낼 row 확인 : "+ row);
		return row;
	}
}
