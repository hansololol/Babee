package com.babee.diary.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

@Mapper
@Repository("diaryDAO")
public interface DiaryDAO {
	public List selectALLDiaryList(String member_id) throws DataAccessException;
	public void insertNewDiary(Map diaryMap) throws DataAccessException;
	public void insertDiaryImage(Map diaryMap) throws DataAccessException;
	
	
}
