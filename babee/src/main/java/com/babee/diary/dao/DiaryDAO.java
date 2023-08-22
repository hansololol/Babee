package com.babee.diary.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

@Mapper
@Repository("diaryDAO")
public interface DiaryDAO {
	

	public int insertNewDiary(Map diaryMap) throws DataAccessException;
	
	
	
}
