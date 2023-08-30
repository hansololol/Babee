package com.babee.seller.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("sellerVO")
public class SellerVO {

	private String seller_id;
	private String seller_pw;
	private String seller_name;
	private String seller_tel1;
	private String seller_tel2;
	private String seller_tel3;
	private String seller_hp1;
	private String seller_hp2;
	private String seller_hp3;
	private String seller_email;
	
	private String seller_roadAddr;
	private String seller_jibunAddr;
	private String seller_namujiAddr;
	private String seller_zipcode;
	private Date seller_joinDate;
	private String seller_bank_num;
	private String seller_bank_name;
	private String seller_bank_com;
	private String seller_company;
	private String seller_company_info;
	private String seller_img1;

	private Date seller_confirmDate;
	private String seller_status;
	private String seller_refuse;
	
	private String member_id;
	private String member_pw;
	private String baby_age;
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
	public String getSeller_name() {
		return seller_name;
	}
	public void setSeller_name(String seller_name) {
		this.seller_name = seller_name;
	}
	public String getSeller_tel1() {
		return seller_tel1;
	}
	public void setSeller_tel1(String seller_tel1) {
		this.seller_tel1 = seller_tel1;
	}
	public String getSeller_tel2() {
		return seller_tel2;
	}
	public void setSeller_tel2(String seller_tel2) {
		this.seller_tel2 = seller_tel2;
	}
	public String getSeller_tel3() {
		return seller_tel3;
	}
	public void setSeller_tel3(String seller_tel3) {
		this.seller_tel3 = seller_tel3;
	}
	public String getSeller_hp1() {
		return seller_hp1;
	}
	public void setSeller_hp1(String seller_hp1) {
		this.seller_hp1 = seller_hp1;
	}
	public String getSeller_hp2() {
		return seller_hp2;
	}
	public void setSeller_hp2(String seller_hp2) {
		this.seller_hp2 = seller_hp2;
	}
	public String getSeller_hp3() {
		return seller_hp3;
	}
	public void setSeller_hp3(String seller_hp3) {
		this.seller_hp3 = seller_hp3;
	}

	public String getSeller_zipcode() {
		return seller_zipcode;
	}
	public void setSeller_zipcode(String seller_zipcode) {
		this.seller_zipcode = seller_zipcode;
	}
	public Date getSeller_joinDate() {
		return seller_joinDate;
	}
	public void setSeller_joinDate(Date seller_joinDate) {
		this.seller_joinDate = seller_joinDate;
	}
	public String getSeller_bank_num() {
		return seller_bank_num;
	}
	public void setSeller_bank_num(String seller_bank_num) {
		this.seller_bank_num = seller_bank_num;
	}
	public String getSeller_bank_name() {
		return seller_bank_name;
	}
	public void setSeller_bank_name(String seller_bank_name) {
		this.seller_bank_name = seller_bank_name;
	}
	public String getSeller_bank_com() {
		return seller_bank_com;
	}
	public void setSeller_bank_com(String seller_bank_com) {
		this.seller_bank_com = seller_bank_com;
	}
	public String getSeller_company() {
		return seller_company;
	}
	public void setSeller_company(String seller_company) {
		this.seller_company = seller_company;
	}
	public String getSeller_company_info() {
		return seller_company_info;
	}
	public void setSeller_company_info(String seller_company_info) {
		this.seller_company_info = seller_company_info;
	}
	public String getSeller_img1() {
		return seller_img1;
	}
	public void setSeller_img1(String seller_img1) {
		this.seller_img1 = seller_img1;
	}

	public Date getSeller_confirmDate() {
		return seller_confirmDate;
	}
	public void setSeller_confirmDate(Date seller_confirmDate) {
		this.seller_confirmDate = seller_confirmDate;
	}
	public String getSeller_status() {
		return seller_status;
	}
	public void setSeller_status(String seller_status) {
		this.seller_status = seller_status;
	}
	
	public String getSeller_refuse() {
		return seller_refuse;
	}
	public void setSeller_refuse(String seller_refuse) {
		this.seller_refuse = seller_refuse;
	}
	public String getSeller_email() {
		return seller_email;
	}
	public void setSeller_email(String seller_email) {
		this.seller_email = seller_email;
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
	public String getSeller_roadAddr() {
		return seller_roadAddr;
	}
	public void setSeller_roadAddr(String seller_roadAddr) {
		this.seller_roadAddr = seller_roadAddr;
	}
	public String getSeller_jibunAddr() {
		return seller_jibunAddr;
	}
	public void setSeller_jibunAddr(String seller_jibunAddr) {
		this.seller_jibunAddr = seller_jibunAddr;
	}
	public String getSeller_namujiAddr() {
		return seller_namujiAddr;
	}
	public void setSeller_namujiAddr(String seller_namujiAddr) {
		this.seller_namujiAddr = seller_namujiAddr;
	}
	public String getBaby_age() {
		return baby_age;
	}
	public void setBaby_age(String baby_age) {
		this.baby_age = baby_age;
	}
	
	
}
