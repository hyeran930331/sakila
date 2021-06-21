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
	
	public Map<String,Object> getActorOne(Map<String,Object> paramMap){
		log.debug("2 controller에서 보낸 paramMap확인"+paramMap.toString());
		
		int total = (actorMapper.selectActorForCount(""));
		List<Map<String,Object>> actorList = actorMapper.selectActorOne(paramMap);
		log.debug("4 mapper에서 보낸 actorOme확인"+actorList.toString());
		
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		resultMap.put("total", total);
		resultMap.put("actorList", actorList);
		log.debug("5 controller에서 보낸 resultMap 확인 : "+ resultMap.toString()); //여기까지 출력
		return resultMap;
	}
	
	public Map<String,Object> getActorList(Map<String,Object> paramMap){
		log.debug("2 controller에서 보낸 paramMap확인"+paramMap.toString());
		if(paramMap.get("searchWord") != null && paramMap.get("searchWord").equals("")) {
			paramMap.put("searchWord",null);
		}
		log.debug("3 mapper로 보낼 map확인:"+paramMap.toString());
		
		int beginRow = (((int)paramMap.get("currentPage")-1)*(int)paramMap.get("rowPerPage"));
		int total = (actorMapper.selectActorForCount((String)paramMap.get("searchWord")));
		log.debug("4 mapper에서 온 total 확인: "+ total);
		int lastPage = (int)(Math.ceil((double)total / (int)paramMap.get("rowPerPage")));
		
		Page page = new Page();
		page.setBeginRow(beginRow);
		page.setRowPerPage((int)paramMap.get("rowPerPage"));
		page.setSearchWord((String)paramMap.get("searchWord"));
		log.debug("3 mapper로 보낼 Page 학인 : "+ page.toString());
		
		List<Map<String, Object>> actorList = actorMapper.selectActorList(page);
		log.debug("4 mapper에서 온 actorList 확인 : "+ actorList.toString()); //여기까지 출력
		
		HashMap<String,Object> resultMap = new HashMap<> ();
		resultMap.put("lastPage", lastPage);
		resultMap.put("actorList", actorList);
		log.debug("5 controller로 보낼 resultMap 확인 : "+ resultMap.toString()); //여기까지 출력
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
