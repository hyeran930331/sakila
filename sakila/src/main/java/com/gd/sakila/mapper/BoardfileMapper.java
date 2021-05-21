package com.gd.sakila.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gd.sakila.vo.Boardfile;

//Consider defining a bean of type 원인 -> @Mapper
@Mapper
public interface BoardfileMapper { //interface
	int insertBoardfile(Boardfile boardfile);
	List<Boardfile> selectBoardfileByBoardId (int boardId);
	int deleteBoardfileByBoardId(int boardId);
	int deleteBoardfileOne(int boardfileId);
}
