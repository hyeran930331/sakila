package com.gd.sakila.restapi;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.gd.sakila.mapper.CityMapper;
import com.gd.sakila.mapper.CountryMapper;
import com.gd.sakila.vo.City;
import com.gd.sakila.vo.Country;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class RestApi {
	@Autowired CountryMapper countryMapper;
	@Autowired CityMapper cityMapper;

	@GetMapping("/country")
	public List<Country> country() {
		return countryMapper.selectCountry();
	}

	@GetMapping("/city")
	public List<City> city(@RequestParam(value = "countryId") int countryId) {
		log.debug(" countryId : "+countryId);
		return cityMapper.selectCity(countryId);
	}

}