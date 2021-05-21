package com.gd.sakila.service;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.gd.sakila.mapper.BoardfileMapper;
import com.gd.sakila.vo.Boardfile;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class BoardfileService {
	@Autowired BoardfileMapper boardfileMapper;
	
	public int removeBoardfileOne(Boardfile boardfile) {
		log.debug("ⓢBoardfileServiceⓢ removeBoardfileOne param"+ boardfile);
		
		//물리적파일 삭제
		File temp = new File("");
		//프로젝트 폴더에 빈파일temp가 만들어진다.
		String path = temp.getAbsolutePath();
		//temp의 위치를 저장한다.
		File file = new File(path+"\\src\\main\\webapp\\resource\\"+boardfile.getBoardfileName());
		if(file.exists()) {
			log.debug("ⓢBoardfileServiceⓢ file.exists()=true");
			file.delete();
		}
		//db 삭제
		int row = boardfileMapper.deleteBoardfileOne(boardfile.getBoardfileId());
		log.debug("ⓢBoardfileServiceⓢ deleteBoardfileOne 삭제성공1, 삭제실패0"+ row);
		
		return row;
	}

	public int addBoardfile(MultipartFile multipartFile, int boardId) {
		System.out.println("ⓢBoardfileServiceⓢ addBoardfile : "+multipartFile +"\t"+boardId);
					
		//1물리적파일 저장
		File temp = new File("");
		//프로젝트 폴더에 빈파일temp가 만들어진다.
		String path = temp.getAbsolutePath()+"\\src\\main\\webapp\\resource\\";
		//.확장자
		int p = multipartFile.getOriginalFilename().lastIndexOf(".");
		String ext = multipartFile.getOriginalFilename().substring(p);
		//확장자를 제외한 파일이름
		String prename = UUID.randomUUID().toString().replace("-", "");
		
		//temp의 위치를 저장한다.
		File file = new File(path+prename+ext);		
		try {
			multipartFile.transferTo(file); //mufiparttime안에 파일을 빈파일에 복사
		} catch (Exception e) {
			throw new RuntimeException();
		}
		
		//2db 저장
		Boardfile boardfile = new Boardfile();
		boardfile.setBoardfileId(boardId);
		boardfile.setBoardfileName(multipartFile.getOriginalFilename());
		boardfile.setBoardfileType(multipartFile.getContentType());
		boardfile.setBoardfileSize(multipartFile.getSize());

		int row = boardfileMapper.insertBoardfile(boardfile);
		log.debug("ⓢBoardfileServiceⓢ addBoardfile DB 성공1, 실패0"+ row);
		return row;
	}
}
