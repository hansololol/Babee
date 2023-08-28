package com.babee.community.service;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.babee.community.vo.CommentVO;
import com.babee.community.vo.FreeboardVO;
import com.babee.community.vo.InfoVO;
import com.babee.community.vo.QnaVO;

public interface CommunityService {
	public List<FreeboardVO> selectFreeboard(String member_id) throws Exception;
	public void addFreeboard(Map freeboardMap) throws DataAccessException;
	public Map freeboardDetail(String articleNO) throws Exception;
	//public void modDiary(Map diaryMap) throws DataAccessException;
	

	public List selectComment(String articleNO) throws Exception;
	public void addComment(CommentVO commentVO)throws Exception;
	public void delFreeboard(Map freeboardMap) throws Exception;
	
	public void addQan(QnaVO qnaVO) throws Exception;
	public List<QnaVO> selectMyQnaList(String member_id) throws Exception;
	
	public void addInfo(Map infoMap) throws DataAccessException;
	public List<InfoVO> selectInfoboard(String member_id) throws Exception;
	public Map admininfoDetail(String articleNO) throws Exception;
	public List selectAllinfo()throws Exception;
}
