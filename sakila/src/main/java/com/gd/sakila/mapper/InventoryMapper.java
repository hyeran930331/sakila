package com.gd.sakila.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.sakila.vo.Film;

@Mapper
public interface InventoryMapper {
	List<Map<String, Object>> selectInventoryList(Map<String,Object> map);
	int selectInventoryTotal(Map<String,Object> map);
	List<Map<String,Object>> selectInventoryOne (int inventoryId);
	int insertInventory(Map<String, Object> paramMap);
	List<Map<String,Object>> selectInventoryforRental(int inventoryId);
}
