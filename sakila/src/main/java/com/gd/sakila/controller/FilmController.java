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

import com.gd.sakila.service.CategoryService;
import com.gd.sakila.service.FilmService;
import com.gd.sakila.service.LanguageService;
import com.gd.sakila.vo.Category;
import com.gd.sakila.vo.FilmForm;
import com.gd.sakila.vo.Language;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin") //공통 매핑추가 post든 get이든~~
public class FilmController {
	@Autowired FilmService filmService;
	@Autowired CategoryService categoryService;
	@Autowired LanguageService laguageService;
	
	@GetMapping("/modifyFilm")
	public String modifyFilm (Model model
			, @RequestParam(value="filmId", required= true) int filmId) {
		log.debug("ⓒFilmControllerⓒ getFilmOne 실행"+filmId);
		

		Map<String,Object> map = filmService.getFilmOneForFilmId(filmId);
		log.debug("ⓒFilmControllerⓒ filmService.modifyFilm 실행 filmList : "+map.get("filmList"));
		List<Category> categoryList =categoryService.getCategoryList();
		log.debug("ⓒFilmControllerⓒ filmService.modifyFilm 실행 categoryList : "+categoryList);
		
		model.addAttribute("filmList",map.get("filmList")); //map으로 받아야되나
		//model.addAttribute("actorsList",map.get("actorsList")); 
		model.addAttribute("categoryList",categoryList);
		
		return "modifyFilm";
	}
	
	@PostMapping
	
	@GetMapping("/addFilm")
	public String addFilm (Model model) {
		List<Category> categoryList =categoryService.getCategoryList();
		List<Language> languageList =laguageService.getLanguageList();
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("languageList", languageList);
		return "addFilm";
	}
	@PostMapping("/addFilm")
	public String addFilm(FilmForm filmForm) { 
		//갑타입으로 매개변수의 이름과 도메인이 같으면 매핑
		//다르면  requestParam
		//참조타입 = 피드명과 도메인의 이 같으면 command type 
		int filmId = filmService.addFilm(filmForm);
		log.debug("1. addfilm Controller post param 확인" +filmForm.toString());
		categoryService.getCategoryList();//categoryService에
		laguageService.getLanguageList();
		return "redirect:/admin/getFilmOne?filmId="+filmId;
	}
	
	@GetMapping("/modifyFilmActor")
	public String getFilmActorListByFilm(Model model
										, @RequestParam(value="filmId") int filmId ) {
		List<Map<String,Object>> castingListByFilm = filmService.getFilmActorListByFilm(filmId);
		log.debug("resultmap size() :"+castingListByFilm.toString());
		
		model.addAttribute("castingListByFilm", castingListByFilm);
		model.addAttribute("filmId", filmId);

		return "modifyFilmActor";
	}
	@PostMapping("/modifyFilmActor")
	public String modifyFilmActor (Integer filmId
								, int[] actorId) {
		log.debug("\n1 film Id :"+filmId);
		log.debug("2 cast length :"+actorId.length);
		log.debug("2 cast :"+actorId);

		Map<String, Object> parmMap = new HashMap<>();
		parmMap.put("filmId", filmId);
		parmMap.put("actorIdArr", actorId);		
		
		filmService.modifyFilmActor(parmMap);
		
		return "redirect:/admin/getFilmOne?filmId="+filmId;
	}
	
	@GetMapping ("/getFilmList")
	public String getFilmList(Model model
							, @RequestParam(value="currentPage", defaultValue="1") int currentPage
							, @RequestParam(value="rowPerPage", defaultValue="10") int rowPerPage
							, @RequestParam(value="category",  required = false) String category
							, @RequestParam(value="price",  required = false) Double price
							, @RequestParam(value="searchTitle", required = false) String searchTitle
							, @RequestParam(value="searchActor", required = false) String searchActor
							, @RequestParam(value="rating", required = false) String rating) {
		log.debug(currentPage+"<--currentPage");
		log.debug(rowPerPage+"<--rowPerPage");
		log.debug(searchTitle+"<--searchTitle");
			
		Map<String,Object> map = filmService.getFilmList(currentPage, rowPerPage, category, price, searchTitle, searchActor, rating);
		log.debug("ⓒFilmControllerⓒ getFilmList 실행"); //성공
		log.debug("ⓒFilmControllerⓒ getFilmList 값 map.get(filmList) : "+ map.get("filmList").toString());

		model.addAttribute("currentPage",currentPage); //받은 그대로 보내기
		model.addAttribute("categoryList", map.get("categoryList")); //view에서 쓰려면 여기에서 보내줘야한다.
		model.addAttribute("lastPage", map.get("lastPage"));
		model.addAttribute("filmList", map.get("filmList"));
		return "getFilmList";
	}
	
	@GetMapping ("/getFilmOne")
	public String getFilmOne(Model model
							, @RequestParam(value="filmId", required=false) int filmId
							, @RequestParam(value="title", required=false) String title ) {
		log.debug("0 view에서 넘어온 param filmId 확인"+filmId);
		log.debug("0 view에서 넘어온 param firstName 확인"+title);

		
		Map<String,Object> resultMap = new HashMap<String,Object> ();
		
		if (title == null){
			resultMap = filmService.getFilmOneForFilmId(filmId);
			log.debug("5 seviece에서 받아온 resultMap확인"+resultMap.toString());
			model.addAttribute("filmId",filmId);
		}
		
		if (title != null){
			resultMap = filmService.getFilmOneForTitle(title);
			log.debug("5 seviece에서 받아온 resultMap확인"+resultMap.toString());
			model.addAttribute("filmId",resultMap.get("filmId"));
		}
		
		model.addAttribute("FilmInStockStore",resultMap.get("FilmInStockStore"));
		model.addAttribute("filmList",resultMap.get("filmList")); //map으로 받아야되나
		//model.addAttribute("actorsList",map.get("actorsList")); 
		model.addAttribute("categoryList",resultMap.get("categoryList")); 
		return "getFilmOne";
	}

}
