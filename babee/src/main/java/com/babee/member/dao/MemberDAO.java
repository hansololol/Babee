package com.babee.member.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.babee.member.vo.MemberVO;



@Mapper
@Repository("memberDAO")
public interface MemberDAO {
	public MemberVO login(Map loginMap) throws DataAccessException;
	public void insertNewMember(MemberVO memberVO) throws DataAccessException;
	public String selectOverlappedID(String id) throws DataAccessException;
	public void deleteMember(String id) throws DataAccessException;
	public MemberVO findMyId(Map findMap) throws DataAccessException;
	public MemberVO findMyPw(Map findMap) throws DataAccessException;

	public void modMember(MemberVO memberVO)throws DataAccessException;
	public void updatePwd(Map findMap)throws DataAccessException;
	
}
