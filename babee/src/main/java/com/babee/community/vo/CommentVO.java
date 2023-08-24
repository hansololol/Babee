package com.babee.community.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;


@Component("commentVO")
public class CommentVO {
	private int articleNO;
	private int free_commentNO;
	private String member_id;
	private String free_comment;
	public int getArticleNO() {
		return articleNO;
	}
	public void setArticleNO(int articleNO) {
		this.articleNO = articleNO;
	}
	public int getFree_commentNO() {
		return free_commentNO;
	}
	public void setFree_commentNO(int free_commentNO) {
		this.free_commentNO = free_commentNO;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getFree_comment() {
		return free_comment;
	}
	public void setFree_comment(String free_comment) {
		this.free_comment = free_comment;
	}
	public String getSeller_id() {
		return seller_id;
	}
	public void setSeller_id(String seller_id) {
		this.seller_id = seller_id;
	}
	public Date getFree_commentDate() {
		return free_commentDate;
	}
	public void setFree_commentDate(Date free_commentDate) {
		this.free_commentDate = free_commentDate;
	}
	private String seller_id;
	private Date free_commentDate;
	
	}
