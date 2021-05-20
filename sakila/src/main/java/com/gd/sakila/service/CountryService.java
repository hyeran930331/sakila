package com.gd.sakila.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.sakila.mapper.CountryMapper;
import com.gd.sakila.vo.Country;
import com.gd.sakila.vo.Page;

@Service
@Transactional
public class CountryService {
	@Autowired 
	private CountryMapper countryMapper;	
	public Map<String, Object> getCountryList(int currentPage, int rowPerPage) {
		Page pageParam = new Page();
		// 1.컨트롤러에서 넘겨져 온 값parameter매개값들을 가공. beginRow 구하기
		int beginRow = (currentPage-1) * rowPerPage;
		pageParam.setBeginRow(beginRow);
		pageParam.setRowPerPage(rowPerPage);
		
		// 2.Dao호출
		List<Country> list = countryMapper.selectCountryList(pageParam);
		System.out.println(list.size());
		int total = countryMapper.selectCountryTotal();
		
		// 3.dao의 반환값을 가공
		int lastPage = total / rowPerPage;
		if (lastPage% rowPerPage !=0) {
			lastPage +=1;
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("lastPage", lastPage);
		return map;
	}
}