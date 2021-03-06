package com.gd.sakila.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.sakila.mapper.AddressMapper;
import com.gd.sakila.mapper.StaffMapper;
import com.gd.sakila.vo.Address;
import com.gd.sakila.vo.Board;
import com.gd.sakila.vo.Page;
import com.gd.sakila.vo.Staff;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class StaffService {
	@Autowired StaffMapper staffMapper; //@Autowired가 없으면 --> nullpointException
	@Autowired AddressMapper addressMapper;
	public Staff login(Staff staff) {
		log.debug("ⓢStaffServiceⓢ login() param staff :"+staff);
		return staffMapper.selectStaffByLogin(staff); //null or staff반환
	}
	
	public HashMap<String, Object> getStaffList(int currentPage, int rowPerPage, String searchWord) {
		log.debug("ⓢStaffServiceⓢ getStaffList() param rowPerPage:"+rowPerPage); //출력성공
		//전체 갯수구하기
		int total = staffMapper.selectStaffListForCount(searchWord);
		
		int lastPage= (int)(Math.ceil((double)total / rowPerPage));
		
		
		//페이징
		Page page = new Page();
		page.setBeginRow((currentPage-1)*rowPerPage);
		page.setRowPerPage(rowPerPage);
		page.setSearchWord(searchWord);
		log.debug("ⓢStaffServiceⓢ getStaffList() param Page:"+page.toString()); //출력성공
		
		List<Object> staffList = staffMapper.selectStaffList(page); // Page
		log.debug("ⓢStaffServiceⓢ getStaffList() staffList :"+staffList); 
		log.debug("ⓢStaffServiceⓢ getStaffList() staffList :"+staffList.toString());
		
		HashMap<String,Object> map = new HashMap<String, Object>();
		map.put("staffList", staffList);
		map.put("lastPage", lastPage);
		return map;
	}
	
	public List<Staff> getStaffList(int storeId){
		log.debug("2 param확인 : "+ storeId);
		log.debug("3 매퍼에게 줄 param확인 : "+ storeId);
		List<Staff> staffList = staffMapper.selectStaff(storeId);
		log.debug("4 매퍼에게 받은 값 확인 : "+ staffList.toString());
		return staffList;
	}

	public int addStaff(Staff staff, Address address) {
		log.debug("2 param확인 : "+ staff.toString());
		log.debug("2 param확인 : "+ address.toString());
		addressMapper.insertAddress(address);
		int row = staffMapper.insertStaff(staff);
		return row;
	}
}
