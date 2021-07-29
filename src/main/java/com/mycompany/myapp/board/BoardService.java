package com.mycompany.myapp.board;

import java.util.List;
import java.util.Map;

import com.mycompany.myapp.user.UserDTO;

public interface BoardService {

	int getTotalCount(PagingDTO paging);

	List<BoardDTO> selectBoardAll(PagingDTO paging);

	int updatehits(Integer num);

	BoardDTO selectBoardByNum(Integer num);

	Integer selectBoardNumMax(BoardDTO board);
	
	int insertBoard(BoardDTO board);
	
	int deleteBoard(int num);

	int updateBoard(BoardDTO board);
	
	// 답변형(계층형) 게시판에서 답변글 달기
	int replyBoard(BoardDTO board); 
	BoardDTO selectRefLevSunbun(int num);
	int updateSunbun(BoardDTO parent);
	
	int getMyBoardTotal(PagingDTO paging);
	
	//댓글 
	List<CommentDTO> selectCommentAll(int num);
	int insertComment(CommentDTO comment);
	int updateComment(CommentDTO comment);
	int deleteComment(int cnum);


	List<BoardDTO> myBoardselectAll(PagingDTO paging);

	Integer selectCommentCNumMax(CommentDTO comment);

}
