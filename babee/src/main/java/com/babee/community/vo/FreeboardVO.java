package com.babee.community.vo;

import java.sql.Timestamp;

import org.springframework.stereotype.Component;


@Component("freeboardVO")
public class FreeboardVO {
	private int articleNO;
	private String free_title;
	private String member_id;
	private Timestamp free_writeDate;
	private String free_content;
	private int free_view_count;
	private String free_img;
	private String free_img_id;
	
	private int commentCnt;
	
	
	public int getCommentCnt() {
		return commentCnt;
	}
	public void setCommentCnt(int commentCnt) {
		this.commentCnt = commentCnt;
	}
	public int getArticleNO() {
		return articleNO;
	}
	public void setArticleNO(int articleNO) {
		this.articleNO = articleNO;
	}
	public String getFree_title() {
		return free_title;
	}
	public void setFree_title(String free_title) {
		this.free_title = free_title;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	
	public String getFree_content() {
		return free_content;
	}
	public void setFree_content(String free_content) {
		this.free_content = free_content;
	}
	public int getFree_view_count() {
		return free_view_count;
	}
	public void setFree_view_count(int free_view_count) {
		this.free_view_count = free_view_count;
	}
	public String getFree_img() {
		return free_img;
	}
	public void setFree_img(String free_img) {
		this.free_img = free_img;
	}
	public String getFree_img_id() {
		return free_img_id;
	}
	public void setFree_img_id(String free_img_id) {
		this.free_img_id = free_img_id;
	}
	public Timestamp getFree_writeDate() {
		return free_writeDate;
	}
	public void setFree_writeDate(Timestamp free_writeDate) {
		this.free_writeDate = free_writeDate;
	}

	
	
	
	
}
