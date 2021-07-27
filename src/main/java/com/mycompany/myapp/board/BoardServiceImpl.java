package com.mycompany.myapp.board;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.myapp.user.UserDTO;

@Service("boardService")
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardMapper boardMapper;

	@Override
	public int getTotalCount(PagingDTO paging) {
		return boardMapper.getTotalCount(paging);
	}
	
	@Override
	public List<BoardDTO> selectBoardAll(PagingDTO paging) {		
		return boardMapper.selectBoardAll(paging);
	}

	@Override
	public int updatehits(Integer num) {
		return boardMapper.updatehits(num);
	}

	@Override
	public BoardDTO selectBoardByNum(Integer num) {
		return boardMapper.selectBoardByNum(num);
	}

	@Override
	public int insertBoard(BoardDTO board) {
		return boardMapper.insertBoard(board);
	}
	
	@Override
	public int deleteBoard(int num) {
		return boardMapper.deleteBoard(num);
	}

	@Override
	public int updateBoard(BoardDTO board) {
		return boardMapper.updateBoard(board);
	}

	@Override
	public int replyBoard(BoardDTO board) {
		
		BoardDTO parent = boardMapper.selectreferLevSunbun(board.getNum());
		
		int n1 = boardMapper.updateSunbun(parent); 
		
		board.setRefer(parent.getRefer());
		board.setLevel(parent.getLevel()+1); //부모 lev+1 
		board.setSunbun(parent.getSunbun()+1); // 부모 sunbun+1 
		int n = boardMapper.replyBoard(board);
		
		return n;
	}

	@Override
	public BoardDTO selectRefLevSunbun(int idx) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateSunbun(BoardDTO parent) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Integer selectBoardNumMax(BoardDTO board) {
		return boardMapper.selectBoardNumMax(board);
	}

	@Override
	public List<CommentDTO> selectCommentAll(int num) {
		return boardMapper.selectCommentAll(num);
	}

	@Override
	public int insertComment(CommentDTO comment) {
		return boardMapper.insertComment(comment);
	}

	@Override
	public int updateComment(CommentDTO comment) {
		return boardMapper.updateComment(comment);
	}

	@Override
	public int deleteComment(CommentDTO comment) {
		return boardMapper.deleteComment(comment);
	}

	@Override
	public int getMyBoardTotal(PagingDTO paging) {
		return boardMapper.getMyBoardTotal(paging);
	}

	@Override
	public List<BoardDTO> myBoardselectAll(PagingDTO paging) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Integer selectCommentCNumMax(CommentDTO comment) {
		return boardMapper.selectCommentCNumMax(comment);
	}
	

	
}
