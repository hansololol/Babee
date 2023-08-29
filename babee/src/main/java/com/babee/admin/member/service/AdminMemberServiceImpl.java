package com.babee.admin.member.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.babee.admin.member.dao.AdminMemberDAO;
import com.babee.community.vo.FreeboardVO;
import com.babee.member.vo.MemberVO;
import com.babee.seller.vo.SellerVO;


@Service("adminMemberService")
@Transactional(propagation=Propagation.REQUIRED)
public class AdminMemberServiceImpl implements AdminMemberService {
	@Autowired
	private AdminMemberDAO adminMemberDAO;
	
	public ArrayList<MemberVO> listMember(HashMap condMap) throws Exception{
		return adminMemberDAO.listMember(condMap);
	}

	public MemberVO memberDetail(String member_id) throws Exception{
		 return adminMemberDAO.memberDetail(member_id);
	}
	
	public void  modifyMemberInfo(HashMap memberMap) throws Exception{
		 String member_id=(String)memberMap.get("member_id");
		 adminMemberDAO.modifyMemberInfo(memberMap);
	}
	
	//사업자 관리
	@Override
	public List<SellerVO> sellerManageList(Map sellerMap) throws Exception{
		return adminMemberDAO.sellerManageList(sellerMap);
	}
	
	@Override
	public List<SellerVO> sellerManageWait(Map sellerMap) throws Exception{
		return adminMemberDAO.sellerManageWait(sellerMap);
	}
}
