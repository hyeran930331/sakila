package com.gd.sakila.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.sakila.service.ActorService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class ActorController {
	@Autowired ActorService actorService;

	@GetMapping("/addActor")
	public String addActor() {
		System.out.println("<--addActor 실행");
		return "addActor";
	}
	
	@PostMapping("/addActor")
	public String addActor(Model model
							, @RequestParam(value="firstName", required = true)String firstName
							, @RequestParam(value="lastName", required=true) String lastName
							, @RequestParam(value="filmLine", required=false) String filmLine) {
		System.out.println(firstName+"<--firstName");
		System.out.println(lastName+"<--lastName");
		System.out.println(filmLine+"<--filmLine");
		
		int row = actorService.addActor(firstName, lastName, filmLine);
		
		return "redirect:/admin/getActorList"; //:/였다
	}

	@GetMapping("/getActorList")
	public String getActorList(Model model
							, @RequestParam(value="currentPage", defaultValue = "1") int currentPage
							, @RequestParam(value="rowPerPage", defaultValue="10") int rowPerPage
							, @RequestParam(value="searchWord", required=false) String searchWord) {
		System.out.println(currentPage+"<--currentPage");
		System.out.println(rowPerPage+"<--rowPerPage");
		System.out.println(searchWord+"<--searchWord");
		
		Map<String,Object> map = actorService.getActorInfoList(currentPage, rowPerPage, searchWord);
		
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("rowPerPage", rowPerPage);
		model.addAttribute("lastPage", map.get("lastPage"));
		model.addAttribute("actorList", map.get("actorList"));
		return "getActorList"; //마지막에 ; 마침표!
	}
}
