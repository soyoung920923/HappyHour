package com.mycompany.myapp.lineup;

import java.util.List;
import java.util.Map;

import com.mycompany.common.SearchParam;
import com.mycompany.myapp.store.StoreDTO;

public interface LineupMapper {

	int countWaiting(SearchParam param);

	int insertLineup(LineupDTO lineup);

	int updateLineup(LineupDTO lineup);

	int getTotalCount(SearchParam param);

	List<LineupDTO> getLineupAll(SearchParam param);

	int visitTeam(Map<String, Object> param);

	LineupDTO nowTeam(Map<String, Object> param);

	int updateSmsId(LineupDTO lineup);	

}
