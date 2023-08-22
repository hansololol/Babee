package com.babee.diary.service;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.babee.diary.vo.DiaryVO;

public interface DiaryService {
	public List<DiaryVO> selectDiary(String member_id) throws Exception;
	public void addDiary(Map diaryMap) throws DataAccessException;
}
