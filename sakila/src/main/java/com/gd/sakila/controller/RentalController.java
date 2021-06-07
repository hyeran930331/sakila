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

import com.gd.sakila.service.RentalService;
import com.gd.sakila.service.StaffService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class RentalController {
	@Autowired RentalService rentalService;
	@Autowired StaffService staffService;
	
	@GetMapping("/modifyReturnDate")
	public String modifyReturnDate( @RequestParam(value="inventoryId") int inventoryId) {
		log.debug("0 뷰에서 가져오 param확인 inventoryId : "+inventoryId);

		Map<String, Object> map = new HashMap<>();
		map.put("inventoryId", inventoryId);
		log.debug("1 서비스로 보낼 map확인 inventoryId : "+inventoryId);
		
		rentalService.modifyReturnDate(map);
		log.debug("5 서비스에서온 result 없음 : ");
		
		return "redirect:/admin/getInventoryList?inventoryId="+inventoryId;
	}
}