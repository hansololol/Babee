package com.babee.admin.member.service;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.babee.member.vo.MemberVO;
import com.babee.seller.vo.SellerVO;



public interface AdminMemberService {
	public ArrayList<MemberVO> listMember(HashMap condMap) throws Exception;
	public MemberVO memberDetail(String member_id) throws Exception;
	public void  modifyMemberInfo(HashMap memberMap) throws Exception;
	
	//사업자
	public List<SellerVO> sellerManageList(Map sellerMap) throws Exception;
	public Map sellerDetail(String seller_id) throws Exception;
	public List<SellerVO> sellerManageWait(Map sellerMap) throws Exception;
	public Map sellerWaitDetail(String seller_id) throws Exception;
	public void sellerRegister(Map sellerMap) throws Exception;
	public void sellerRefuse(Map sellerMap) throws Exception;
	public void removeSeller(Map sellerMap) throws Exception;
	
}
 