package com.babee.community.service;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.babee.community.vo.CommentVO;
import com.babee.community.vo.FreeboardVO;

public interface CommunityService {
	public List<FreeboardVO> selectFreeboard(String member_id) throws Exception;
	public void addFreeboard(Map freeboardMap) throws DataAccessException;
	public Map freeboardDetail(String articleNO) throws Exception;
	//public void modDiary(Map diaryMap) throws DataAccessException;
	

	public List selectComment(String articleNO) throws Exception;
	public void addComment(CommentVO commentVO)throws Exception;
}
