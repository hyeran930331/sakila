package com.gd.sakila.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.sakila.mapper.CategoryMapper;
import com.gd.sakila.mapper.FilmMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Transactional
@Service
public class FilmService {
	@Autowired FilmMapper filmMapper;
	@Autowired CategoryMapper categoryMapper;
	
	public List<Map<String,Object>> getFilmActorListByFilm(int filmId){
		log.debug("ⓢFilmServiceⓢ param확인 filmId :"+ filmId);
		
		List<Map<String,Object>> Filmlist = filmMapper.selectFilmActorListByFilm(filmId);
		log.debug("ⓢFilmServiceⓢ map확인:"+ Filmlist.size());
		
		return Filmlist;
	}
	
	public Map<String, Object> getFilmList(int currentPage, int rowPerPage, String category, Double price, String title, String actor, String rating) {
		/*map으로 받으면 한번에 할수 있지만... controller에서는 최대한 정보처리를 안하기 위해서... 서비스에서 복붙+ctrl f 찾아바꾸기 하는걸로 흙흑*/
		log.debug("ⓢFilmServiceⓢ param확인 currentPage :"+ currentPage);
		log.debug("ⓢFilmServiceⓢ param확인 rowPerPage :"+ rowPerPage);
		log.debug("ⓢFilmServiceⓢ param확인 category :"+ category);
		log.debug("ⓢFilmServiceⓢ param확인 price :"+ price);
		log.debug("ⓢFilmServiceⓢ param확인 title :"+ title);
		log.debug("ⓢFilmServiceⓢ param확인 actor :"+ actor);
		log.debug("ⓢFilmServiceⓢ param확인 rating :"+ rating);
		
		//선택하지 않고 검색했을때 버그수정
		if(category != null && category.equals("")) {
			category = null;
		}
		if(price != null && price == 0) {
			price = null;
		}	
		if(rating != null && rating.equals("")) {
			rating = null;
		}	
		
		HashMap<String, Object> paramMap = new HashMap<>();
		paramMap.put("category", category);
		paramMap.put("price", price);
		paramMap.put("title", title);
		paramMap.put("actor", actor);
		paramMap.put("rating", rating);
		paramMap.put("currentPage", currentPage);
		paramMap.put("rowPerPage", rowPerPage);
		
		log.debug("ⓢFilmServiceⓢ +paramMap확인 currentPage :"+paramMap.get("currentPage"));
		log.debug("ⓢFilmServiceⓢ +paramMap확인 rowPerPage :"+paramMap.get("rowPerPage"));
		log.debug("ⓢFilmServiceⓢ +paramMap확인 category :"+paramMap.get("category"));
		log.debug("ⓢFilmServiceⓢ +paramMap확인 price :"+paramMap.get("price"));
		log.debug("ⓢFilmServiceⓢ +paramMap확인 title :"+paramMap.get("title"));
		log.debug("ⓢFilmServiceⓢ +paramMap확인 actor :"+paramMap.get("actor"));
		log.debug("ⓢFilmServiceⓢ +paramMap확인 rating :"+paramMap.get("rating"));
		
		//페이징
		int total = filmMapper.selectStaffListForCount(paramMap);//전체 갯수구하기
		log.debug("ⓢStaffServiceⓢ getFilmList() filmMapper.selectStaffListForCount:"+total);
		int lastPage= (int)(Math.ceil((double)total / rowPerPage));//마지막 페이지구하기
		int beginRow = ((currentPage-1)*rowPerPage); 
		//현재페이지가 rowPage의 어디에 있는지.
		//ex 1페이지면 0부터 10개 9페이지면 80부터~10개
		log.debug("ⓢStaffServiceⓢ getFilmList() param BeginRow:"+beginRow);
		
		paramMap.put("beginRow",beginRow);
		
		List<Map<String, Object>> filmList = filmMapper.selectFilmList(paramMap);
		log.debug("ⓢFilmServiceⓢ filmMapper.selectFilmList :"+ filmList.toString());
		
		List<String> categoryList = categoryMapper.selectCategoryNameList();
		log.debug("ⓢFilmServiceⓢ categoryMapper.selectCategoryNameList :"+ categoryList.toString());
			
		Map<String, Object> returnMap = new HashMap<>();
		returnMap.put("filmList", filmList);
		returnMap.put("lastPage", lastPage);
		returnMap.put("categoryList", categoryList);
		
		return returnMap;
	}
	
	//Map <- film , 재고량 filmCount
	public Map<String, Object> getFilmOne(int FID){
		log.debug("ⓢFilmServiceⓢ getFilmOne() param FID:"+FID); //파라미터 확인
		List<Integer> FilmInStockStore = new ArrayList<Integer>(); //재고를 저장할 리스트 초기화
		
		List<Integer> StoreNum = filmMapper.selectStoreForCount(); //스토어 번호를 불러오는 mapper
		for ( int num : StoreNum) { //스토어 번호가 있으면
			int count = 0; // 카운트를 초기화 하고
			
			FilmInStockStore.add(filmMapper.selectFilmInStock(FID,num,count).get(count)); //재고에 넣는다(재고를 불러오는 mapper에서 저장한 count를)
		}
		System.out.println("ⓢFilmServiceⓢ  getFilmOne FilmInStockStore:"+FilmInStockStore);//재고 리스트 확인
	
		
		Map<String, Object> filmList = filmMapper.selectFilmOne(FID); //필름정보를 저장하는 리스트 = mapper
		log.debug("ⓢFilmServiceⓢ getFilmOne()  filmMapper.selectFilmOne :"+ filmList); //필름리스트 확인
		
		Map<String,Object> returnMap = new HashMap<String, Object>();
		returnMap.put("FilmInStockStore", FilmInStockStore);
		returnMap.put("filmList", filmList);

		return returnMap;
	}

	public void modifyFilmActor(Map<String, Object> map) {
		log.debug("ⓢFilmServiceⓢ FilmService.modifyFilmActor 매개변수 map:" +map);
		
		int deleteRow = filmMapper.deleteFilmActor((int)map.get("filmId"));
		log.debug("ⓢFilmServiceⓢ FilmService.modifyFilmActor deleteRow:" + deleteRow);
		//전체 삭제
		
		if(map.get("actorId") != null) { //전체 배우 아이지가 null이 아니면,
			for(int a : (int[])map.get("actorId") ) {
				log.debug("ⓢFilmServiceⓢ FilmService.modifyFilmActor  actorId:" + a);
				
				Map<String,Object> paramMap = new HashMap<String, Object>();
				paramMap.put("actorId", a);
				paramMap.put("filmId", map.get("filmId"));
				
				int insertRow = filmMapper.insertFilmActor(paramMap);
				log.debug("ⓢFilmServiceⓢ FilmService.modifyFilmActor  actorId insert?:" + insertRow);
			}
		}
	}
}
