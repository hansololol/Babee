package com.babee.diary.service;

import java.util.Map;

import org.springframework.dao.DataAccessException;

public interface DiaryService {
	public int addDiary(Map diaryMap) throws DataAccessException;
}
