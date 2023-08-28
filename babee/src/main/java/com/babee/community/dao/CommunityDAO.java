package com.babee.community.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.babee.community.vo.CommentVO;
import com.babee.community.vo.FreeboardVO;
import com.babee.community.vo.InfoVO;
import com.babee.community.vo.QnaVO;

@Mapper
@Repository("commnityDAO")
public interface CommunityDAO {
	public List selectALLFreeboardList(String member_id) throws DataAccessException;
	public void insertNewFreeboard(Map freeboardMap) throws DataAccessException;
	public void insertFreeboardImage(Map freeboardMap) throws DataAccessException;
	public FreeboardVO selectFreeboardDetail(String articleNO) throws Exception;

	public void updateFreeboard(Map freeboardMap) throws DataAccessException;
	public void updateFreeboardImage(Map freeboardMap) throws DataAccessException;
	

	public List selectAllComment(String articleNO)throws DataAccessException;
	public void insertCommnet(CommentVO commentVO)throws DataAccessException;
	public int updateViewCnt(String articleNO)throws DataAccessException;

	
	public void deleteFreeboard(Map freeboardMap) throws DataAccessException;
	public void deleteFreeboardImage(Map freeboardMap) throws DataAccessException;
	
	public void insertNewQna (QnaVO qnaVO)throws DataAccessException;
	public List selectMyQnaList(String member_id)throws DataAccessException;
	
	public void insertNewInfo(Map infoMap) throws DataAccessException;
	public void insertInfoImage(Map infoMap) throws DataAccessException;
	
	
	public List<InfoVO> selectALLInfoboardList(String member_id)throws DataAccessException;
	public InfoVO admininfoDetail(String articleNO)throws DataAccessException;
	public List selectAllinfo()throws DataAccessException;
	
	public void deleteInfoboardImage(String articleNO)throws DataAccessException;
	public void deleteInfoboard(String articleNO)throws DataAccessException;
	
	public void updateInfo(Map<String, Object> infoMap)throws DataAccessException;
	public void updateInfoImage(Map<String, Object> infoMap)throws DataAccessException;
	

}

