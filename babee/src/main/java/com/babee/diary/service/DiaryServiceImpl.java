package com.babee.diary.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.babee.diary.dao.DiaryDAO;
import com.babee.diary.vo.DiaryVO;
import com.babee.goods.vo.GoodsVO;


@Service("diaryService")
@Transactional(propagation=Propagation.REQUIRED)
public class DiaryServiceImpl implements DiaryService  {
	@Autowired
	private DiaryDAO diaryDAO;
	@Autowired
	private DiaryVO diaryVO;
	
	@Override
	public List<DiaryVO> selectDiary(String member_id) throws Exception{
		return diaryDAO.selectALLDiaryList(member_id);
	}
	
	@Override
	public void addDiary(Map diaryMap) throws DataAccessException {
		diaryDAO.insertNewDiary(diaryMap);
		diaryDAO.insertDiaryImage(diaryMap);
	}
	
	@Override
	public Map diaryDetail(String dir_no) throws Exception {
		Map diaryMap=new HashMap();
		DiaryVO diaryVO = diaryDAO.selectDiaryDetail(dir_no);
		diaryMap.put("diaryVO", diaryVO);
		return diaryMap;
	}
	
	@Override
	public void modDiary(Map diaryMap) throws DataAccessException {
		diaryDAO.updateDiary(diaryMap);
		diaryDAO.updateDiaryImage(diaryMap);
	}
	
	@Override
	public void delDiary(Map diaryMap) throws Exception {
		diaryDAO.deleteDiary(diaryMap);
		diaryDAO.deleteDiaryImage(diaryMap);
		
	}

	@Override
	public List<DiaryVO> allDiaryList() throws Exception {
		return diaryDAO.allDiaryList();
	}
}
