package com.mycompany.myapp.board;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import javax.servlet.http.HttpSession;

import lombok.Data;
/*자주 사용하는 페이징 처리 및 검색 기능을 모듈화하여 재사용할 수 있도록 처리하자.*/

@Data
public class PagingDTO {

		//페이징 처리 관련 프로퍼티
		private int cpage;//현재 보여줄 페이지 번호
		private int pageSize; //한 페이지 당 보여줄 목록 개수
		private int totalCount;//총 게시글 수
		private int pageCount; //페이지 수
		
		//DB에서 레코드를 끊어오기 위한 프로퍼티
		private int start;
		private int end;
		
		//페이징 블럭처리를 위한 프로퍼티
		private int pagingBlock;//한 블럭 당 보여줄 페이지 수
		private int prevBlock; //이전 
		private int nextBlock; //이후
		
		//검색 관련 프로퍼티
		private String findType; //검색 유형
		private String findKeyword;//검색어
		
		private String id;
		
		/**페이징 처리를 위해 연산을 수행하는 메소드*/
		public void init(HttpSession ses) {
			if(pageSize<0) {
				pageSize = 10; //기본값을 5개로
			}
			if(pageSize==0) {
				//파라미터로 넘어오는 pageSize가 없다면
				//세션에 저장된 pageSize가 있는지 찾아보자.
				Integer ps = (Integer)ses.getAttribute("pageSize");
				if(ps==null) {
					pageSize =10;
				}else {
					pageSize = ps;
				}
			}//if-------------
			ses.setAttribute("pageSize", pageSize);
			//세션에 pageSize를 저장하자.
			pageCount =(totalCount-1)/pageSize +1;
			if(cpage<=0) {
				cpage =1; //1페이지를 기본으로
			}
			if(cpage>pageCount) {
				cpage = pageCount;//마지막 페이지로 설정
			}

			start = (cpage-1) * pageSize;
			end = start + (pageSize +1);
			
			//페이징 블럭 연산-----
			prevBlock = (cpage-1)/pagingBlock * pagingBlock;
			nextBlock = prevBlock + (pagingBlock +1);
		}
		
		public String getPageNavi(String myctx, String loc, String userAgent) {
			findType = (findType==null)?"":findType;
			
			
			if(findKeyword==null) {
				findKeyword="";
			}else {
				if(userAgent.indexOf("MSIE")>-1 || userAgent.indexOf("Trident")>-1) {
					//IE
					try {
						findKeyword = URLEncoder.encode(findKeyword,"UTF-8");
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
				}
				
			}
			

			String qStr = "?pageSize=" + pageSize + "&findType=" + findType + "&findKeyword=" + findKeyword;
			// query string을 만들자.
			StringBuilder buf = new StringBuilder();
			buf.append("<ul class='pagination justify-content-center'>");
			if (prevBlock > 0) {
				// 이전 n개
				buf.append("<li class='page-item'>").append(
						"<a class='page-link' href='" + myctx + "/" + loc + qStr + "&cpage=" + prevBlock + "'>");
				buf.append("Prev").append("</a></li>");
			} // if----------------------

			for (int i = prevBlock + 1; i <= nextBlock - 1 && i <= pageCount; i++) {
				String css = "";
				if (i == cpage) {
					css = "active";
				} else {
					css = "";
				}

				buf.append("<li class='page-item " + css + "'>")
						.append("<a class='page-link' href='" + myctx + "/" + loc + qStr + "&cpage=" + i + "'>");
				buf.append(i).append("</a></li>");
			} // for------------------

			if (nextBlock <= pageCount) {
				// 이후 n개
				buf.append("<li class='page-item'>").append(
						"<a class='page-link' href='" + myctx + "/" + loc + qStr + "&cpage=" + nextBlock + "'>");
				buf.append("Next").append("</a></li>");
			} // if----------------------
			buf.append("</ul>");
			return buf.toString();
		}
		

	}//////////////////////////////////////////////







