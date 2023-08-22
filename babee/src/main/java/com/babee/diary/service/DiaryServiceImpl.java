package com.babee.diary.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.babee.diary.dao.DiaryDAO;


@Service("diaryService")
@Transactional(propagation=Propagation.REQUIRED)
public class DiaryServiceImpl implements DiaryService  {
	@Autowired
	private DiaryDAO diaryDAO;
	
	
	@Override
	public int addDiary(Map diaryMap) throws DataAccessException {
		return diaryDAO.insertNewDiary(diaryMap);
	}
}
