package com.mycompany.myapp.lineup;

import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.Map;

import org.springframework.expression.ParseException;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.mycompany.common.SearchParam;
import com.mycompany.myapp.store.StoreDTO;

public interface LineupService {

	int countWaiting(SearchParam param);

	int enroll(LineupDTO lineup, String msg) throws ParseException, InvalidKeyException, JsonProcessingException, UnsupportedEncodingException, NoSuchAlgorithmException, URISyntaxException;

	List<LineupDTO> getLineupAll(SearchParam param);

	int visitTeam(Map<String, Object> param) throws ParseException, InvalidKeyException, JsonProcessingException, UnsupportedEncodingException, NoSuchAlgorithmException, URISyntaxException;

	boolean isMyLineup(int userIdx, int idx);

	int oneclick(int idx, String dateTime, int approval, String userMsg) throws ParseException, InvalidKeyException, JsonProcessingException, UnsupportedEncodingException, NoSuchAlgorithmException, URISyntaxException;

	

}
