package com.babee.cart.vo;


import org.springframework.stereotype.Component;

@Component("cartVO")
public class CartVO {
	private int cart_id;
	private int goods_id;
	private String member_id;
	private int cart_goods_qty;
	private String cart_image_name;
	public String getGoods_option1() {
		return goods_option1;
	}

	public void setGoods_option1(String goods_option1) {
		this.goods_option1 = goods_option1;
	}

	public String getGoods_option2() {
		return goods_option2;
	}

	public void setGoods_option2(String goods_option2) {
		this.goods_option2 = goods_option2;
	}

	public String getGoods_option3() {
		return goods_option3;
	}

	public void setGoods_option3(String goods_option3) {
		this.goods_option3 = goods_option3;
	}

	public String getGoods_option4() {
		return goods_option4;
	}

	public void setGoods_option4(String goods_option4) {
		this.goods_option4 = goods_option4;
	}

	public String getGoods_option5() {
		return goods_option5;
	}

	public void setGoods_option5(String goods_option5) {
		this.goods_option5 = goods_option5;
	}
	private String creDate;
	private String goods_option;
	private String goods_option1;
	private String goods_option2;
	private String goods_option3;
	private String goods_option4;
	private String goods_option5;
	
	
	private String goods_title;
  	private int goods_price;
  	private int goods_delivery_price;
  	
  	
  	@Override
	public String toString() {
		return "CartVO [cart_id=" + cart_id + ", goods_id=" + goods_id + ", member_id=" + member_id
				+ ", cart_goods_qty=" + cart_goods_qty + ", creDate=" + creDate + ", goods_option=" + goods_option
				+ ", goods_title=" + goods_title + ", goods_price=" + goods_price + ", goods_delivery_price="
				+ goods_delivery_price + "]";
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

	public int getGoods_delivery_price() {
		return goods_delivery_price;
	}

	public void setGoods_delivery_price(int goods_delivery_price) {
		this.goods_delivery_price = goods_delivery_price;
	}

	public int getCart_goods_qty() {
		return cart_goods_qty;
	}

	public void setCart_goods_qty(int cart_goods_qty) {
		this.cart_goods_qty = cart_goods_qty;
	}

	public int getCart_id() {
		return cart_id;
	}
	
	public String getGoods_option() {
		return goods_option;
	}

	public void setGoods_option(String goods_option) {
		this.goods_option = goods_option;
	}

	public void setCart_id(int cart_id) {
		this.cart_id = cart_id;
	}
	
	
	public int getGoods_id() {
		return goods_id;
	}
	public void setGoods_id(int goods_id) {
		this.goods_id = goods_id;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	
	

	public String getCreDate() {
		return creDate;
	}
	public void setCreDate(String creDate) {
		this.creDate = creDate;
	}

	public String getCart_image_name() {
		return cart_image_name;
	}

	public void setCart_image_name(String cart_image_name) {
		this.cart_image_name = cart_image_name;
	}
	
	
	

}
