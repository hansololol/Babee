package com.babee.diary.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.babee.diary.dao.DiaryDAO;
import com.babee.diary.vo.DiaryVO;


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
}
