package com.babee.admin.member.dao;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.babee.member.vo.MemberVO;
import com.babee.seller.vo.SellerVO;

@Mapper
@Repository("adminMemberDAO")
public interface AdminMemberDAO {
	public ArrayList<MemberVO> listMember(HashMap condMap) throws DataAccessException;
	public MemberVO memberDetail(String member_id) throws DataAccessException;
	public void modifyMemberInfo(HashMap memberMap) throws DataAccessException;
	
	//사업자 관리
	public List sellerManageList(Map sellerMap) throws DataAccessException;
	public SellerVO sellerDetail(String seller_id) throws DataAccessException;
	public List sellerManageWait(Map sellerMap) throws DataAccessException;
	public SellerVO sellerWaitDetail(String seller_id) throws DataAccessException;
	public void sellerRegister(Map sellerMap) throws DataAccessException;
	public void sellerRefuse(Map sellerMap) throws DataAccessException;
	public void deleteSeller(Map sellerMap) throws DataAccessException;
	
	//회원 관리
	public List memberManageList(Map memberMap) throws DataAccessException;
	public MemberVO memberManageDetail(String member_id) throws DataAccessException;
	public void deleteMember(Map memberMap) throws DataAccessException;
	
} 
