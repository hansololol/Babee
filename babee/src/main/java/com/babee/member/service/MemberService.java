package com.babee.member.service;

import java.util.Map;

import com.babee.member.vo.MemberVO;


public interface MemberService {
	public MemberVO login(Map  loginMap) throws Exception;
	public void addMember(MemberVO memberVO) throws Exception;
	public String overlapped(String id) throws Exception;
	public void delMember(String id) throws Exception;
	//회원수정 추가
	public void modMember(MemberVO memberVO) throws Exception;
	public MemberVO findMyId(Map findMap) throws Exception;
	public MemberVO findMyPw(Map findMap) throws Exception;
	public MemberVO findMyPw_kakao(Map findMap) throws Exception;
}
