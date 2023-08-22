package com.babee.mypage.vo;

import org.springframework.stereotype.Component;

@Component("wishVO")
public class WishVO {
	private int articleNO;
	private String member_id;
	private int goods_id;
	private String goods_title;
	private int goods_price;
	private String goods_image_name1;
	
	
	
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
	public int getGoods_id() {
		return goods_id;
	}
	public void setGoods_id(int goods_id) {
		this.goods_id = goods_id;
	}
	
	public String getGoods_title() {
		return goods_title;
	}
	public void setGoods_title(String goods_title) {
		this.goods_title = goods_title;
	}
	public int getGoods_price() {
		return goods_price;
	}
	public void setGoods_price(int goods_price) {
		this.goods_price = goods_price;
	}
	public String getGoods_image_name1() {
		return goods_image_name1;
	}
	public void setGoods_image_name1(String goods_image_name1) {
		this.goods_image_name1 = goods_image_name1;
	}
	
	
	
}
