package com.gd.sakila.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gd.sakila.vo.Address;
import com.gd.sakila.vo.City;
import com.gd.sakila.vo.Country;
import com.gd.sakila.vo.Page;

@Mapper //
public interface CountryMapper {
	List<Country> selectCountryList(Page page);
	int selectCountryTotal();
	int insertCountry(String country);
	
	List<Country> selectCountry();

}