package com.gd.sakila.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.sakila.mapper.ActorMapper;
import com.gd.sakila.vo.Actor;
import com.gd.sakila.vo.Page;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Transactional
@Service
public class ActorService {
	@Autowired ActorMapper actorMapper;
	
	
	public Map<String,Object> getActorInfoList(int currentPage, int rowPerPage, String searchWord){
		Page page = new Page();
		int beginRow = ((currentPage-1)*rowPerPage);
		int total = (actorMapper.selectActorForCount(searchWord));
		log.debug("ⓢActorServiceⓢ Param total : "+ total);
		int lastPage = (int)(Math.ceil((double)total / rowPerPage));
		page.setBeginRow(beginRow);
		page.setRowPerPage(rowPerPage);
		page.setSearchWord(searchWord);
		log.debug("ⓢActorServiceⓢ Param : "+ page);
		
		List<Map<String, Object>> actorList = actorMapper.selectActorInfoList(page);
		log.debug("ⓢActorServiceⓢ actorMapper.selectActorInfoList(page) : "+ actorList); //여기까지 출력
		log.debug("ⓢActorServiceⓢ actorMapper.selectActorInfoList(page) : "+ actorList.toString()); //여기까지 출력
		
		HashMap<String,Object> resultMap = new HashMap<> ();
		resultMap.put("lastPage", lastPage);
		resultMap.put("actorList", actorList);
		return resultMap;
	}



	public int addActor(String firstName, String lastName, String filmList) {
		// TODO Auto-generated method stub
		Actor actor = new Actor ();
		actor.setFirstName(firstName);
		actor.setLastName(lastName);
		//우선 필름 생략
		int row = actorMapper.insertActor(actor);
		return row;
	}

}
