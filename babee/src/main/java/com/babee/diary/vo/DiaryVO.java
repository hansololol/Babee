package com.babee.diary.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;


@Component("diaryVO")
public class DiaryVO {
	private int dir_no;
	private String member_id;
	private String member_name;
	private String dir_title;
	private String dir_main_img;
	private String baby_condition;
	private String dir_content;
	private Date dir_writeDate;
	
	
	
	public int getDir_no() {
		return dir_no;
	}
	public void setDir_no(int dir_no) {
		this.dir_no = dir_no;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	public String getDir_title() {
		return dir_title;
	}
	public void setDir_title(String dir_title) {
		this.dir_title = dir_title;
	}
	public String getDir_main_img() {
		return dir_main_img;
	}
	public void setDir_main_img(String dir_main_img) {
		this.dir_main_img = dir_main_img;
	}
	public String getBaby_condition() {
		return baby_condition;
	}
	public void setBaby_condition(String baby_condition) {
		this.baby_condition = baby_condition;
	}
	public String getDir_content() {
		return dir_content;
	}
	public void setDir_content(String dir_content) {
		this.dir_content = dir_content;
	}
	public Date getDir_writeDate() {
		return dir_writeDate;
	}
	public void setDir_writeDate(Date dir_writeDate) {
		this.dir_writeDate = dir_writeDate;
	}
	
	
}
