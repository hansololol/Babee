package com.babee.goods.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("goodsQNA")
public class GoodsQNA {
	private int articleNO;
	private String goods_id;
	private String member_id;
	private String goods_qna_title;
	private String goods_qna_content;
	private Date goods_qna_writeDate;
	private String seller_id;
	private String goods_qna_answer;
	private String goods_qna_middle_title;
	public String getGoods_id() {
		return goods_id;
	}
	
	public int getArticleNO() {
		return articleNO;
	}

	public void setArticleNO(int articleNO) {
		this.articleNO = articleNO;
	}

	public void setGoods_id(String goods_id) {
		this.goods_id = goods_id;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	
	public String getSeller_id() {
		return seller_id;
	}
	public void setSeller_id(String seller_id) {
		this.seller_id = seller_id;
	}
	public String getGoods_qna_answer() {
		return goods_qna_answer;
	}
	public void setGoods_qna_answer(String goods_qna_answer) {
		this.goods_qna_answer = goods_qna_answer;
	}
	public String getGoods_qna_title() {
		return goods_qna_title;
	}
	public void setGoods_qna_title(String goods_qna_title) {
		this.goods_qna_title = goods_qna_title;
	}
	public String getGoods_qna_content() {
		return goods_qna_content;
	}
	public void setGoods_qna_content(String goods_qna_content) {
		this.goods_qna_content = goods_qna_content;
	}
	public Date getGoods_qna_writeDate() {
		return goods_qna_writeDate;
	}
	public void setGoods_qna_writeDate(Date goods_qna_writeDate) {
		this.goods_qna_writeDate = goods_qna_writeDate;
	}
	public String getGoods_qna_middle_title() {
		return goods_qna_middle_title;
	}
	public void setGoods_qna_middle_title(String goods_qna_middle_title) {
		this.goods_qna_middle_title = goods_qna_middle_title;
	}
}
