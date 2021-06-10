package com.gd.sakila.restapi;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.gd.sakila.mapper.CityMapper;
import com.gd.sakila.mapper.CountryMapper;
import com.gd.sakila.mapper.InventoryMapper;
import com.gd.sakila.mapper.StaffMapper;
import com.gd.sakila.vo.City;
import com.gd.sakila.vo.Country;
import com.gd.sakila.vo.Film;
import com.gd.sakila.vo.Staff;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class RestApi {
	@Autowired CountryMapper countryMapper;
	@Autowired CityMapper cityMapper;
	@Autowired InventoryMapper inventoryMapper;

	@GetMapping("/country")
	public List<Country> country() {
		log.debug(" countryList : "+countryMapper.selectCountry().toString());
		return countryMapper.selectCountry();
	}

	@GetMapping("/city")
	public List<City> city(@RequestParam(value = "countryId") int countryId) {
		log.debug(" countryId : "+countryId);
		log.debug(" city List : "+cityMapper.selectCity(countryId).toString());
		return cityMapper.selectCity(countryId);
	}
	
	@GetMapping("/inventory")
	public List<Map<String,Object>> inventory(@RequestParam(value = "inventoryId") int inventoryId){
		log.debug(" inventoryId : "+inventoryId);
		log.debug(" filmOne : "+ inventoryMapper.selectInventoryforRental(inventoryId));
		return inventoryMapper.selectInventoryforRental(inventoryId);
	}
}