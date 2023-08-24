package com.babee.community.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.babee.community.vo.CommentVO;
import com.babee.community.vo.FreeboardVO;

@Mapper
@Repository("commnityDAO")
public interface CommunityDAO {
	public List selectALLFreeboardList(String member_id) throws DataAccessException;
	public void insertNewFreeboard(Map freeboardMap) throws DataAccessException;
	public void insertFreeboardImage(Map freeboardMap) throws DataAccessException;
	public FreeboardVO selectFreeboardDetail(String articleNO) throws Exception;

	//public void updateDiary(Map diaryMap) throws DataAccessException;
	//public void updateDiaryImage(Map diaryMap) throws DataAccessException;
	

	public List selectAllComment(String articleNO)throws DataAccessException;
	public void insertCommnet(CommentVO commentVO)throws DataAccessException;
	public int updateViewCnt(String articleNO)throws DataAccessException;

	
	public void deleteFreeboard(Map freeboardMap) throws DataAccessException;
	public void deleteFreeboardImage(Map freeboardMap) throws DataAccessException;
	
}
