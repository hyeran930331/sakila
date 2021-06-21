package com.gd.sakila.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.sakila.vo.Actor;
import com.gd.sakila.vo.Page;

@Mapper
public interface ActorMapper {
	int insertActor(Actor actor);
	List<Map<String,Object>> selectActorList(Page page);
	int selectActorForCount(String searchWord);
	List<Map<String,Object>> selectActorOne(Map<String, Object> paramMap);
}
