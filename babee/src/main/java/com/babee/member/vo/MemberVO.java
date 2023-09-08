package com.babee.member.vo;


import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("memberVO")
public class MemberVO {
	
	private String member_id;
	private String member_pw;
	private String member_name;
	private String member_gender;
	private Date member_birth;
	private String member_tel1;
	private String member_tel2;
	private String member_tel3;
	private String member_hp1;
	private String member_hp2;
	private String member_hp3;
	
	private String member_email;


	private String member_zipcode;
	private String member_roadAddr;
	private String member_jibunAddr;
	private String member_namujiAddr;
	private Date member_joinDate;
	private Date member_delDate;
	private String member_status;
	private String baby_gender;
	private String baby_age;
	private String seller_id;
	private String seller_pw;
	
	
	public Date getMember_delDate() {
		return member_delDate;
	}
	public void setMember_delDate(Date member_delDate) {
		this.member_delDate = member_delDate;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getMember_pw() {
		return member_pw;
	}
	public void setMember_pw(String member_pw) {
		this.member_pw = member_pw;
	}
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	public String getMember_gender() {
		return member_gender;
	}
	public void setMember_gender(String member_gender) {
		this.member_gender = member_gender;
	}
	public Date getMember_birth() {
		return member_birth;
	}
	public void setMember_birth(Date member_birth) {
		this.member_birth = member_birth;
	}
	public String getMember_tel1() {
		return member_tel1;
	}
	public void setMember_tel1(String member_tel1) {
		this.member_tel1 = member_tel1;
	}
	public String getMember_tel2() {
		return member_tel2;
	}
	public void setMember_tel2(String member_tel2) {
		this.member_tel2 = member_tel2;
	}
	public String getMember_tel3() {
		return member_tel3;
	}
	public void setMember_tel3(String member_tel3) {
		this.member_tel3 = member_tel3;
	}
	public String getMember_hp1() {
		return member_hp1;
	}
	public void setMember_hp1(String member_hp1) {
		this.member_hp1 = member_hp1;
	}
	public String getMember_hp2() {
		return member_hp2;
	}
	public void setMember_hp2(String member_hp2) {
		this.member_hp2 = member_hp2;
	}
	public String getMember_hp3() {
		return member_hp3;
	}
	public void setMember_hp3(String member_hp3) {
		this.member_hp3 = member_hp3;
	}

	public String getMember_zipcode() {
		return member_zipcode;
	}
	public void setMember_zipcode(String member_zipcode) {
		this.member_zipcode = member_zipcode;
	}
	public String getMember_roadAddr() {
		return member_roadAddr;
	}
	public void setMember_roadAddr(String member_roadAddr) {
		this.member_roadAddr = member_roadAddr;
	}
	public String getMember_jibunAddr() {
		return member_jibunAddr;
	}
	public void setMember_jibunAddr(String member_jibunAddr) {
		this.member_jibunAddr = member_jibunAddr;
	}
	public String getMember_namujiAddr() {
		return member_namujiAddr;
	}
	public void setMember_namujiAddr(String member_namujiAddr) {
		this.member_namujiAddr = member_namujiAddr;
	}
	public Date getMember_joinDate() {
		return member_joinDate;
	}
	public void setMember_joinDate(Date member_joinDate) {
		this.member_joinDate = member_joinDate;
	}
	public String getMember_status() {
		return member_status;
	}
	public void setMember_status(String member_status) {
		this.member_status = member_status;
	}
	public String getBaby_gender() {
		return baby_gender;
	}
	public void setBaby_gender(String baby_gender) {
		this.baby_gender = baby_gender;
	}
	public String getBaby_age() {
		return baby_age;
	}
	public void setBaby_age(String baby_age) {
		this.baby_age = baby_age;
	}
	public String getMember_email() {
		return member_email;
	}
	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}
	public String getSeller_id() {
		return seller_id;
	}
	public void setSeller_id(String seller_id) {
		this.seller_id = seller_id;
	}
	public String getSeller_pw() {
		return seller_pw;
	}
	public void setSeller_pw(String seller_pw) {
		this.seller_pw = seller_pw;
	}
	
	
}

