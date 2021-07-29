package com.mycompany.myapp.board;

import java.util.List;
import java.util.Map;

import com.mycompany.myapp.user.UserDTO;

public interface BoardMapper {

	int getTotalCount(PagingDTO paging);

	List<BoardDTO> selectBoardAll(PagingDTO paging);

	int updatehits(Integer num);

	BoardDTO selectBoardByNum(Integer num);

	int insertBoard(BoardDTO board);
	
	int deleteBoard(int num);

	int updateBoard(BoardDTO board);

	BoardDTO selectreferLevSunbun(Integer num);

	int updateSunbun(BoardDTO parent);

	int replyBoard(BoardDTO board);

	Integer selectBoardNumMax(BoardDTO board);

	List<CommentDTO> selectCommentAll(int num);

	int insertComment(CommentDTO comment);

	int updateComment(CommentDTO comment);

	int deleteComment(int cnum);
	
	int getMyBoardTotal(PagingDTO paging);

	Integer selectCommentCNumMax(CommentDTO comment);

	
}
