package com.babee.community.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;


@Component("infoVO")
public class InfoVO {
	private String info_title;
	private String info_img;
	private String member_id;
	private String info_content;
	private int articleNO;
	private String info_img_id;
	
	
	public String getInfo_content() {
		return info_content;
	}
	public void setInfo_content(String info_content) {
		this.info_content = info_content;
	}
	public String getInfo_title() {
		return info_title;
	}
	public void setInfo_title(String info_title) {
		this.info_title = info_title;
	}
	public String getInfo_img() {
		return info_img;
	}
	public void setInfo_img(String info_img) {
		this.info_img = info_img;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public int getArticleNO() {
		return articleNO;
	}
	public void setArticleNO(int articleNO) {
		this.articleNO = articleNO;
	}
	public String getInfo_img_id() {
		return info_img_id;
	}
	public void setInfo_img_id(String info_img_id) {
		this.info_img_id = info_img_id;
	}
	

	
	
}
