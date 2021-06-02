package com.gd.sakila.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.sakila.service.StaffService;
import com.gd.sakila.vo.Staff;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin") //공통 매핑추가 post든 get이든~~
public class StaffController {
	@Autowired StaffService staffService;
	
	@GetMapping("/addStaff")
	public String addStaff() {
		System.out.println("<--addStaff 실행");
		return "addStaff";
	}
	@PostMapping("/addStaff")
	public String addStaff(Staff staff) {
		log.debug("0 param확인 : "+ staff.toString());
		int row = staffService.addStaff(staff);
		log.debug("3. service에서 받은 값 확인 row : "+row);
		return "redirect:/admin/getStaffList";
	}
	
	@GetMapping("/getStaffList")
	public String getBoardList(Model model
								, @RequestParam(value="currentPage", defaultValue="1") int currentPage
								, @RequestParam(value="rowPerPage", defaultValue="10") int rowPerPage
								, @RequestParam(value="searchWord", required = false) String searchWord
								) {
		System.out.println(currentPage+"<--currentPage");
		System.out.println(rowPerPage+"<--rowPerPage");
		System.out.println(searchWord+"<--searchWord");
		
		HashMap<String,Object> map = staffService.getStaffList(currentPage, rowPerPage, searchWord);
		//model.addAttribute를 이용해서, 넘길 데이터의 이름과 값을 넣는다. 그러면, 스프링은 그 값을 뷰쪽으로 넘겨준다.
		System.out.println(map.get("lastPage").toString()+"<--lastPage");
		System.out.println(map.get("staffList").toString()+"<--staffList");
		
		model.addAttribute("currentPage",currentPage); 
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("lastPage", map.get("lastPage"));
		model.addAttribute("staffList", map.get("staffList"));
		
		return "getStaffList";
	}
}
