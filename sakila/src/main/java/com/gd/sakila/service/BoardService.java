package com.gd.sakila.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.gd.sakila.mapper.BoardMapper;
import com.gd.sakila.mapper.BoardfileMapper;
import com.gd.sakila.mapper.CommentMapper;
import com.gd.sakila.vo.Board;
import com.gd.sakila.vo.BoardForm;
import com.gd.sakila.vo.Boardfile;
import com.gd.sakila.vo.Comment;
import com.gd.sakila.vo.Page;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional //try catch, 자동 rollback
public class BoardService {
	@Autowired	BoardMapper boardMapper;
	@Autowired BoardfileMapper boardfileMapper;
	@Autowired CommentMapper commentMapper;
	
	//수정
	public int modifyBoard(Board board){
		log.debug("▶▶▶▶▶▶ modifyBoard param: "+ board.toString());
		return boardMapper.updateBoard(board);
	}
	
	//삭제
	public int removeBoard(Board board) {
		log.debug("▶▶▶▶▶▶ removeBoard param: "+ board.toString());
		//1게시글 삭제
		int boardRow = boardMapper.deleteBoard(board);
		
		if (boardRow == 0) { //지운게 없으면
			return 0; // 강제 종료.
		}
		
		//2 게시글 삭제 (FK 외래키 지정이 없기때문에),
		//2-1 댓글삭제 (board_id 외래키 noAction)
		int commentRow = commentMapper.deleteCommentByBoard(board.getBoardId()); //게시글삭제시
		log.debug("▶▶▶▶▶▶ removeBoard commentMapper: "+ commentRow);

		/* board_id 외래키 CasCast
		if (boardRow == 0) {
			//강제로 예외(try, catch를 강제안하는 오류)를 발생시켜, @Transactional에 걸러서 rollback 되도록
			throw new RuntimeException(); 
		}
		*/
		
		//2-2 파일도 삭제(물리적 파일 삭제)
		List<Boardfile> boardfileList = boardfileMapper.selectBoardfileByBoardId(board.getBoardId());
		if(boardfileList != null) {
			for(Boardfile f : boardfileList) {
				File temp = new File("");
				//프로젝트 폴더에 빈파일temp가 만들어진다.
				String path = temp.getAbsolutePath();
				//temp의 위치를 저장한다.
				File file = new File(path+"\\src\\main\\webapp\\resource\\"+f.getBoardfileName());
				file.delete();
			}
		}
		//2-2 파일도 삭제(파일 table의 행을 삭제)
		int boardfileRow = boardfileMapper.deleteBoardfileByBoardId(board.getBoardId());

		log.debug("▶▶▶▶▶▶removeBoard deleteBoard: "+ boardRow);
		return commentRow+boardRow;
	}
	
	//추가
	public void addBoard(BoardForm boardForm) {
		log.debug("▶▶▶▶▶▶addBoard param: "+ boardForm); //이건 왜toString()안쓰지?
		//1. 받아온 boardForm에서 private board추출
		Board board =boardForm.getBoard();
		log.debug("▶▶▶▶▶▶ board : " + board.getBoardId());
		// board추출값을 가지고 insertBoard를 만듦.
		boardMapper.insertBoard(board);
		log.debug("▶▶▶▶▶▶ board : " + board.getBoardId());
		
		//2. 파일 리스트
		List<MultipartFile> list = boardForm.getBoardfile();
		if (list != null) {
			for(MultipartFile f : list) { //리스트를 가져와서 반복한다.
				Boardfile boardfile = new Boardfile(); //
				boardfile.setBoardId(board.getBoardId()); //롬북덕분에 getBoardId자동
				// test.txt / test.TXT 대소문자 구분 -> newname.txt
				String originalFilename = f.getOriginalFilename(); //원래파일의 이름을 가진다. ex kang.hye.txt
				int p = originalFilename.lastIndexOf("."); // 배열의 요소"."가 가장 왼쪽에 있는 자릿수. ex kang.hye"." = 8
				//인덱스. 기본값은 +Infinity입니다. fromIndex >= str.length인 경우 모든 문자열을 탐색합니다. 
				//fromIndex < 0인 경우엔 0을 지정한 것과 동일합니다.
				//'abab'.lastIndexOf('ab', 2)는 0이 아니고 2를 반환합니다. fromIndex는 탐색의 시작점만 제한하기 때문입니다.
				String ext = originalFilename.substring(p).toLowerCase(); //숫자 p 뒤에서부터 잘라서~ 소문자 넣기 ex= ".txt" 확장자
				String prename = UUID.randomUUID().toString().replace("-"," "); //API UUID = 겹칠수 없는 문자열x = 유효아이디
				
				String filename = prename+ext;
				boardfile.setBoardfileName(filename); //중복
				boardfile.setBoardfileSize(f.getSize());
				boardfile.setBoardfileType(f.getContentType());
				//2-1.
				//boardfileMapper.insertBoardfile(boardfile);
				
				
				//2-2.파일 저장
				try {
					File temp = new File("");
					//프로젝트 폴더에 빈파일temp가 만들어진다.
					String path = temp.getAbsolutePath();
					//temp의 위치를 저장한다.
					f.transferTo( new File(path+"\\src\\main\\webapp\\resource\\"+filename));
				} catch (Exception e) {
					throw new RuntimeException();
				}
			}
		}
		
	}
	
	//상세보기+댓글목록
	public Map<String, Object> getBoardOne(int boardId){
		log.debug("▶▶▶▶▶▶ getBoardOne param: "+ boardId);
		//상세보기
		Map<String, Object> boardMap = boardMapper.selectBoardOne(boardId);
		log.debug("▶▶▶▶▶▶ boardMap: "+ boardMap);
		//파일목록
		List<Boardfile> boardfileList = boardfileMapper.selectBoardfileByBoardId(boardId);
		
		//댓글목록
		List<Comment> commentList = commentMapper.selectCommentListByBoard(boardId);
	    log.debug("commentList size() : "+ commentList.size());
	    
	    
	    int boardTotal = boardMapper.selectBoardTotal(null);
	    		
	    Map<String, Object> map = new HashMap<>();
	      map.put("boardMap", boardMap);
	      map.put("boardfileList", boardfileList);
	      map.put("commentList", commentList);
	      map.put("boardTotal", boardTotal);
	      return map;
	}
	
	
	public Map<String, Object> getBoardList(int currentPage, int rowPerPage, String searchWord) {
		//1 전체갯수 구하기 (feat.검색어)
		int boardTotal = boardMapper.selectBoardTotal(searchWord); // searchWord
		/*
		int lastPage = boardTotal / rowPerPage;
		if(boardTotal % rowPerPage != 0) {
			lastPage++;
		}
		*/
		int lastPage = (int)(Math.ceil((double)boardTotal / rowPerPage));
		
		//2 페이징
		Page page = new Page();
		page.setBeginRow((currentPage-1)*rowPerPage);
		page.setRowPerPage(rowPerPage);
		page.setSearchWord(searchWord);
		List<Board> boardList = boardMapper.selectBoardList(page); // Page
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("lastPage", lastPage);
		map.put("boardList", boardList);
		return map;
	}
}