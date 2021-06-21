package com.gd.sakila.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.sakila.service.CountryService;
import com.gd.sakila.service.CustomerService;
import com.gd.sakila.vo.Address;
import com.gd.sakila.vo.City;
import com.gd.sakila.vo.Country;
import com.gd.sakila.vo.Customer;

import lombok.extern.slf4j.Slf4j;

@Slf4j
/*
 * DB에 엑세스하는 여러 연산을 하나의 트랜잭션으로 처리하여 오류가 발생한 경우 롤백을 도와주는것
 * (timeout=초)단위로 시간을 정할수도 있다
 */
@Controller
/*
 *  * 스프링의 component-scanning 기술이 이 클래스를 어플리케이션 컨텍스트에 빈으로 등록하게 되는 
 * @Component = 어노테이션을 사용해도 상관없다.
 * 하지만, @Controller 어노테이션을 사용함으로써 @RequestMapping 등의 추가적인 어노테이션을 사용할 수 있게 된다.
 * 
- 컨트롤러 객체임을 명시. Classpath 스캔을 통해 자동으로 감지된다.


실제 프로젝트에서 @Component가 필요한 비슷한 상황들을 직면하곤 한다.
하지만, 대부분의 상황에서 우리는 @Repository, @Service, @Controller 어노테이션을 사용하는게 좋다.
@Component 어노테이션은 Controller, Service, Dao 세가지 카테고리 이외의 클래스에만 사용해야 한다. ???
 */
@RequestMapping("/admin")
public class CustomerController {
	@Autowired CustomerService customerService;
	
	@GetMapping("/addCustomer")
	public String addCustomer() {
		log.debug("1. 콘트롤러 시작");
		return "addCustomer";
	}
	@PostMapping("/addCustomer")
	public String addCustomer(Model model
							,Customer customer
							,Address address){
		log.debug(".1. 콘트롤러에서 보낼 paramMap 확인 : "+customer);
		log.debug(".1. 콘트롤러에서 보낼 paramMap 확인 : "+address);
		
		int row = customerService.addCustomer(customer, address);
		log.debug("3. 서비스에서 받은 row 확인 : "+row);
		
		return "redirect:/admin/getCustomerList";
	}
	
	@GetMapping("/getCustomerOne")
	public String getCustomerOne(Model model
								,@RequestParam(value="customerId", required = true) Integer customerId) {
		log.debug("1. 콘트롤러에서 보낼 paramMap 확인 customerId"+customerId);
		
		Map<String,Object> resultMap = customerService.getCustomerOne(customerId);
		log.debug("5. 서비스에서 보낸 resultMap 확인"+resultMap);
		
		model.addAttribute("customerOne", resultMap.get("customerOne"));
		model.addAttribute("rentalList", resultMap.get("rentalList"));
		model.addAttribute("total", resultMap.get("total"));
		return "getCustomerOne";
	}
	
	@GetMapping("/getCustomerList")
	public String getCustomerList(Model model
								 ,@RequestParam(value="currentPage", defaultValue ="1") int currentPage
								 ,@RequestParam(value="rowPerPage", defaultValue="10") int rowPerPage
								 ,@RequestParam(value="searchWord", required = false) String searchWord
								 ,@RequestParam(value="storeId",  required = false) Integer storeId) {
		log.debug("0. 콘트롤러에서 보낼 requestParam 확인 currentPage"+currentPage);
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("currentPage", currentPage);
		paramMap.put("rowPerPage", rowPerPage);
		paramMap.put("searchWord", searchWord);
		paramMap.put("storeId", storeId);
		log.debug("1. 콘트롤러에서 보낼 paramMap 확인"+paramMap);
		
		Map<String,Object> resultMap = customerService.getCustomerList(paramMap);
		log.debug("5. 서비스에서 보낸 resultMap 확인"+resultMap);
		
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("storeId", storeId);
		model.addAttribute("lastPage", resultMap.get("lastPage"));
		model.addAttribute("customerList", resultMap.get("customerList"));
		log.debug("6. 뷰로 보내기");
		return "/getCustomerList";
	}
}
