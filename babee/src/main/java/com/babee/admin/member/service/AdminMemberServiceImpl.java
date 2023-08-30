package com.babee.admin.member.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.babee.admin.member.dao.AdminMemberDAO;
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
	
	//사업자
	@Override
	public List<SellerVO> sellerManageList(Map sellerMap) throws Exception{
		return adminMemberDAO.sellerManageList(sellerMap);
	}
	
	@Override
	public Map sellerDetail(String seller_id) throws Exception {
		Map sellerMap = new HashMap();
		SellerVO sellerVO = adminMemberDAO.sellerDetail(seller_id);
		sellerMap.put("sellerVO", sellerVO);
		
		return sellerMap;
	}
	
	@Override
	public List<SellerVO> sellerManageWait(Map sellerMap) throws Exception{
		return adminMemberDAO.sellerManageWait(sellerMap);
	}
	
	@Override
	public Map sellerWaitDetail(String seller_id) throws Exception {
		Map sellerMap = new HashMap();
		SellerVO sellerVO = adminMemberDAO.sellerWaitDetail(seller_id);
		sellerMap.put("sellerVO", sellerVO);
		
		return sellerMap;
	}
	
	@Override
	public void sellerRegister(Map sellerMap) throws DataAccessException {
		adminMemberDAO.sellerRegister(sellerMap);
	}
	@Override
	public void sellerRefuse(Map sellerMap) throws DataAccessException {
		adminMemberDAO.sellerRefuse(sellerMap);
	}
	@Override
	public void removeSeller(Map sellerMap) throws Exception {
		adminMemberDAO.deleteSeller(sellerMap);
	}
}
 