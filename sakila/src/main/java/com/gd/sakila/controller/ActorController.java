package com.gd.sakila.controller;

import java.util.HashMap;
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

	@GetMapping("/getActorOne")
	public String getActorOne( Model model
								, @RequestParam(value="firstName") String firstName
								, @RequestParam(value="lastName") String lastName ) {
		log.debug("0 view에서 넘어온 param firstName 확인"+firstName);
		log.debug("0 view에서 넘어온 param lastName 확인"+lastName);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("firstName", firstName);
		map.put("lastName", lastName);
		log.debug("1 service로 보낸 map 확인: "+map.toString());
		
		Map<String,Object> resultMap = actorService.getActorOne(map);
		log.debug("5 service 에서 넘어온 row 확인 "+resultMap.toString());
		
		
		model.addAttribute("actorList", resultMap.get("actorList"));
		model.addAttribute("total", resultMap.get("total"));
		return "getActorOne";
	}
	
	@GetMapping("/addActor")
	public String addActor() {
		log.debug("0 view에서 넘어온 param 없음 "+"");
		return "addActor";
	}
	
	@PostMapping("/addActor")
	public String addActor(Model model
							, @RequestParam(value="firstName") String firstName
							, @RequestParam(value="lastName") String lastName
							, @RequestParam(value="filmLine", required=false) String filmLine) {
		log.debug("0 view에서 넘어온 param 확인 firstName"+firstName);
		log.debug("0 view에서 넘어온 param 확인 lastName"+lastName);
		log.debug("0 view에서 넘어온 param 확인 filmLine"+filmLine);
		
		int row = actorService.addActor(firstName, lastName, filmLine);
		log.debug("5 service 에서 넘어온 row 확인 "+row);
		
		return "redirect:/admin/getActorList"; //:/였다
	}

	@GetMapping("/getActorList")
	public String getActorList(Model model
							, @RequestParam(value="currentPage", defaultValue = "1") int currentPage
							, @RequestParam(value="rowPerPage", defaultValue="10") int rowPerPage
							, @RequestParam(value="searchWord", required=false) String searchWord) {
		log.debug("0 view에서 넘어온 param 확인:"+currentPage+"<--currentPage");
		log.debug("0 view에서 넘어온 param 확인:"+rowPerPage+"<--rowPerPage");
		log.debug("0 view에서 넘어온 param 확인:"+searchWord+"<--searchWord");
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("currentPage", currentPage);
		map.put("rowPerPage", rowPerPage);
		map.put("searchWord", searchWord);
		log.debug("1 servicedp map 확인: "+map.toString());
		
		Map<String,Object> resultMap = actorService.getActorList(map);
		log.debug("6 Servive에서 온 resultMap : "+resultMap.toString());
		
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("rowPerPage", rowPerPage);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("lastPage", resultMap.get("lastPage"));
		model.addAttribute("actorList", resultMap.get("actorList"));
		log.debug("7 view로 보낼 model : "+model.toString());
		return "getActorList"; //마지막에 ; 마침표!
	}
}
