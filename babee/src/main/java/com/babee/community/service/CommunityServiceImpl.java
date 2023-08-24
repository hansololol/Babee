package com.babee.community.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.babee.community.dao.CommunityDAO;
import com.babee.community.vo.CommentVO;
import com.babee.community.vo.FreeboardVO;


@Service("commnityService")
@Transactional(propagation=Propagation.REQUIRED)
public class CommunityServiceImpl implements CommunityService  {
	@Autowired
	private CommunityDAO communityDAO;
	@Autowired
	private FreeboardVO freeboardVO;
	
	@Override
	public List<FreeboardVO> selectFreeboard(String member_id) throws Exception{
		return communityDAO.selectALLFreeboardList(member_id);
	}
	
	@Override
	public void addFreeboard(Map freeboardMap) throws DataAccessException {
		communityDAO.insertNewFreeboard(freeboardMap);
		communityDAO.insertFreeboardImage(freeboardMap);
		
	}
	
	
	@Override
	public Map freeboardDetail(String articleNO) throws Exception {
		Map freeboardMap = new HashMap();
		
		int free_view_count =  communityDAO.updateViewCnt(articleNO);
		
		FreeboardVO freeboardVO = communityDAO.selectFreeboardDetail(articleNO);
		freeboardVO.setFree_view_count(free_view_count);
		freeboardMap.put("freeboardVO", freeboardVO);
		
		return freeboardMap;
	}

	@Override
	public List selectComment(String articleNO) throws Exception {
		return communityDAO.selectAllComment(articleNO);
	}
	
	@Override
	public void addComment(CommentVO comentVO) throws Exception {
		communityDAO.insertCommnet(comentVO);
	}
	

	/*
	 * @Override public void modDiary(Map diaryMap) throws DataAccessException {
	 * diaryDAO.updateDiary(diaryMap); diaryDAO.updateDiaryImage(diaryMap); }
	 */ 
}
