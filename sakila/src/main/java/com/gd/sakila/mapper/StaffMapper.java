package com.gd.sakila.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.gd.sakila.vo.Staff;

/*
 * @componetn, Repository Service Controller --> 
 * Bean --> 
 * 스프링.겟빈(클래스타입) = autoWired 자동와이어링 = 디펜던시 인젝션
 * 
 * @Mapper : mybatis의 애노테이션 ==> @ㄲ
 */

@Mapper //mapper.xml을 찾아서 -> 매서드명과 mapper의 아이디명이 같으면 합쳐서 메서드를 오버라이딩
public interface StaffMapper { //class 아니고 interface
	Staff selectStaffByLogin(Staff staff);
}
