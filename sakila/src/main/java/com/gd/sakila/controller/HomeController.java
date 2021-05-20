package com.gd.sakila.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.gd.sakila.service.StaffService;
import com.gd.sakila.vo.Staff;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class HomeController {
	@Autowired StaffService staffService;
	
	@PostMapping({"/login"})
	public String login(HttpSession session, Staff staff) { //servlet 세션을 직접사용. 컨트롤러 메서드의 매개변수는 DI대상
		log.debug ("login() parm staff "+staff.toString());
		
		Staff loginStaff = staffService.login(staff);

		if (loginStaff != null) { //로그인 성공
			log.debug ("login() loginStaff "+loginStaff.toString());
		}
		session.setAttribute("loginStaff", loginStaff);
		return "redirect:/home"; //다시 자기자신으로
	}
	
	@GetMapping("/admin/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	@GetMapping({"/", "/home", "/index"})
	public String home() {
		//System.out.println("홈");
		log.debug("home"); //@Slf4j를 했기때문에 Logger log = 하지 않고도 사용가능.
		return "home";
	}
}
