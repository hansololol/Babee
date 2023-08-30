package com.babee.mypage.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;

import com.babee.goods.vo.GoodsVO;

@Component("reviewVO")
public class ReviewVO {
	private String member_id;
	private String goods_id;
	private int goods_star; 
	private String review_title;
	private String review_content;
	private String review_img;
	private Date review_writeDate;
	private String review_img_id;
	private GoodsVO goodsVO;
	
	
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getGoods_id() {
		return goods_id;
	}
	public void setGoods_id(String goods_id) {
		this.goods_id = goods_id;
	}
	public int getGoods_star() {
		return goods_star;
	}
	public void setGoods_star(int goods_star) {
		this.goods_star = goods_star;
	}
	public String getReview_title() {
		return review_title;
	}
	public void setReview_title(String review_title) {
		this.review_title = review_title;
	}
	public String getReview_content() {
		return review_content;
	}
	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}
	public String getReview_img() {
		return review_img;
	}
	public void setReview_img(String review_img) {
		this.review_img = review_img;
	}
	public Date getReview_writeDate() {
		return review_writeDate;
	}
	public void setReview_writeDate(Date review_writeDate) {
		this.review_writeDate = review_writeDate;
	}
	public String getReview_img_id() {
		return review_img_id;
	}
	public void setReview_img_id(String review_img_id) {
		this.review_img_id = review_img_id;
	}
	public GoodsVO getGoodsVO() {
		return goodsVO;
	}
	public void setGoodsVO(GoodsVO goodsVO) {
		this.goodsVO = goodsVO;
	}
}
