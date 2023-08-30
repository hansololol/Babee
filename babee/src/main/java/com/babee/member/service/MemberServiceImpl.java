package com.babee.member.service;


import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.babee.member.dao.MemberDAO;
import com.babee.member.vo.MemberVO;


@Service("memberService")
@Transactional(propagation=Propagation.REQUIRED)
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberDAO memberDAO;
	
	@Override
	public MemberVO login(Map  loginMap) throws Exception{
		return memberDAO.login(loginMap);
	}
	
	@Override
	public MemberVO findMyId(Map findMap) throws Exception{
		return memberDAO.findMyId(findMap);
	}
	@Override
	public MemberVO findMyPw(Map findMap) throws Exception{
		MemberVO memberVO = memberDAO.findMyPw(findMap);
		memberDAO.updatePwd(findMap);
		return memberVO;
	}
	@Override
	public MemberVO findMyPw_kakao(Map findMap) throws Exception{
		MemberVO memberVO = memberDAO.findMyPw(findMap);
		
		return memberVO;
	}
	
	@Override
	public void addMember(MemberVO memberVO) throws Exception{
		System.out.println("여기까지 오는지 확인 service");
		memberDAO.insertNewMember(memberVO);
	}
	
	@Override
	public String overlapped(String id) throws Exception{
		return memberDAO.selectOverlappedID(id);
	}
	
	@Override
	public void delMember(String id) throws Exception{
		memberDAO.deleteMember(id);
	}
	
	//회원수정 추가
	@Override
	public void modMember(MemberVO memberVO) throws Exception{
		memberDAO.modMember(memberVO);

	}
}
