package com.babee.community.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;


@Component("qnaVO")
public class QnaVO {
	private int articleNO;
	private String member_id;
	private String qna_title;
	private String qna_content;
	private Date qna_writeDate;
	private String qna_answer;
	public int getArticleNO() {
		return articleNO;
	}
	public void setArticleNO(int articleNO) {
		this.articleNO = articleNO;
	}

	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getQna_content() {
		return qna_content;
	}
	public void setQna_content(String qna_content) {
		this.qna_content = qna_content;
	}
	public String getQna_title() {
		return qna_title;
	}
	public void setQna_title(String qna_title) {
		this.qna_title = qna_title;
	}
	public Date getQna_writeDate() {
		return qna_writeDate;
	}
	public void setQna_writeDate(Date qna_writeDate) {
		this.qna_writeDate = qna_writeDate;
	}
	public String getQna_answer() {
		return qna_answer;
	}
	public void setQna_answer(String qna_answer) {
		this.qna_answer = qna_answer;
	}
	
	
	

	
	
	
	
}
