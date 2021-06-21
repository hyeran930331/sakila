package com.gd.sakila.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gd.sakila.service.BoardfileService;
import com.gd.sakila.vo.Boardfile;

@Controller
@RequestMapping("/admin")
public class BoardfileController { 
	@Autowired private BoardfileService boardfileService;
	
	@GetMapping("/removeBoardfile")
	public String removeBoardfile(Boardfile boardfile) {
		//글쓴이가 아니더라도 삭제가 가능.
		//1 물리적 파일삭제
		
		//2 db삭제
		int row =boardfileService.removeBoardfileOne(boardfile);
		return "redirect:/admin/getBoardOne?boardId="+boardfile.getBoardId();
	}
}
