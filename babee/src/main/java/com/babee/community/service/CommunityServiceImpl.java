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
import com.babee.community.vo.InfoVO;
import com.babee.community.vo.QnaVO;


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
		
		FreeboardVO freeboardVO = communityDAO.selectFreeboardDetail(articleNO);

		int free_view_count =  communityDAO.updateViewCnt(articleNO);
		
		if(free_view_count != 0) {
		freeboardVO.setFree_view_count(free_view_count);
		} else {
			freeboardVO.setFree_view_count(1);
		}
		
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
	
	@Override
	public void delFreeboard(Map freeboardMap) throws Exception {
		communityDAO.deleteFreeboard(freeboardMap);
		communityDAO.deleteFreeboardImage(freeboardMap);
		
	}
	
	@Override
	public void addQan(QnaVO qnaVO) throws Exception {
		communityDAO.insertNewQna(qnaVO);
		
	}
	
	@Override
	public List<QnaVO> selectMyQnaList(String member_id) throws Exception{
		return communityDAO.selectMyQnaList(member_id);
	}
	
	
	@Override
	public void modFreeboard(Map freeboardMap) throws DataAccessException {
		communityDAO.updateFreeboard(freeboardMap);
		communityDAO.updateFreeboardImage(freeboardMap);
	}
	  
	
	@Override
	public void addInfo(Map infoMap) throws DataAccessException {
		communityDAO.insertNewInfo(infoMap);
		communityDAO.insertInfoImage(infoMap);
		
	}
	
	@Override
	public List<InfoVO> selectInfoboard(String member_id) throws Exception{
		return communityDAO.selectALLInfoboardList(member_id);
	}
	
	@Override
	public Map admininfoDetail(String articleNO) throws Exception {
		Map infodMap = new HashMap();
		InfoVO infoVO = communityDAO.admininfoDetail(articleNO);
		infodMap.put("infoVO", infoVO);
		
		return infodMap;
	}
	
	@Override
	public List selectAllinfo() throws Exception{
		return communityDAO.selectAllinfo();
	}
	
	@Override
	public void delInfoboard(String articleNO) throws Exception {
		communityDAO.deleteInfoboard(articleNO);
		communityDAO.deleteInfoboardImage(articleNO);
		
	}
	
	@Override
	public void modInfo(Map<String, Object> infoMap) throws Exception{
		 communityDAO.updateInfo(infoMap); 
		 communityDAO.updateInfoImage(infoMap); 

	}

	@Override
	public void adminDelFreeboard(String articleNO) {
		communityDAO.adminDelFreeboard(articleNO);
		communityDAO.adminDelFreeboardImage(articleNO);
	}

	@Override
	public Map freeboardDetail2(String articleNO) throws Exception {
		
			Map freeboardMap = new HashMap();
		
		FreeboardVO freeboardVO = communityDAO.selectFreeboardDetail(articleNO);

		/*
		 * int free_view_count = communityDAO.updateViewCnt(articleNO);
		 * 
		 * if(free_view_count != 0) { freeboardVO.setFree_view_count(free_view_count); }
		 * else { freeboardVO.setFree_view_count(1); }
		 */
		
		freeboardMap.put("freeboardVO", freeboardVO);
		
		return freeboardMap;				
	}



	
}
