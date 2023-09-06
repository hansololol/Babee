package com.babee.order.vo;


import java.sql.Date;

import org.springframework.stereotype.Component;

import com.babee.goods.vo.GoodsVO;

@Component("orderVO")
public class OrderVO {
	private String order_id;
	private String member_id;
	private String goods_id;
	private String goods_title;
	private int goods_price;
	private int total_goods_price;
	private int order_goods_qty;
	private int orderNO;
	private String recipient_name;
	private String recipient_hp;
	private String recipient_tel;
	private String deliveryAddr;
	private String deliveryMessage;
	private String trackingNum;
	private String payment_method;
	private String card_com_name;
	private Date payment_order_time;
	private String delivery_status;
	private int final_total_price;
	private String goods_option;
	private String goods_image_name;
	private GoodsVO goods;
	    private String tid; // 결제 고유 번호
	    private String cid; // 가맹점 코드
	    private String status; // 결제 상태
	    private String partner_order_id; // 가맹점 주문 번호
	    private String partner_user_id; // 가맹점 회원 ID
	    private String payment_method_type; // 결제 수단
	    private String item_code; // 상품 코드
	    private int quantity; // 상품 수량

	 
	public int getOrderNO() {
		return orderNO;
	}
	public void setOrderNO(int orderNO) {
		this.orderNO = orderNO;
	}
	public String getOrder_id() {
		return order_id;
	}
	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}
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
	public int getTotal_goods_price() {
		return total_goods_price;
	}
	public void setTotal_goods_price(int total_goods_price) {
		this.total_goods_price = total_goods_price;
	}
	public int getOrder_goods_qty() {
		return order_goods_qty;
	}
	public void setOrder_goods_qty(int order_goods_qty) {
		this.order_goods_qty = order_goods_qty;
	}
	public String getRecipient_hp() {
		return recipient_hp;
	}
	public void setRecipient_hp(String recipient_hp) {
		this.recipient_hp = recipient_hp;
	}
	public String getRecipient_tel() {
		return recipient_tel;
	}
	public void setRecipient_tel(String recipient_tel) {
		this.recipient_tel = recipient_tel;
	}
	public String getDeliveryAddr() {
		return deliveryAddr;
	}
	public void setDeliveryAddr(String deliveryAddr) {
		this.deliveryAddr = deliveryAddr;
	}
	public String getDeliveryMessage() {
		return deliveryMessage;
	}
	public void setDeliveryMessage(String deliveryMessage) {
		this.deliveryMessage = deliveryMessage;
	}
	public String getTrackingNum() {
		return trackingNum;
	}
	public void setTrackingNum(String trackingNum) {
		this.trackingNum = trackingNum;
	}
	public String getPayment_method() {
		return payment_method;
	}
	public void setPayment_method(String payment_method) {
		this.payment_method = payment_method;
	}
	public String getCard_com_name() {
		return card_com_name;
	}
	public void setCard_com_name(String card_com_name) {
		this.card_com_name = card_com_name;
	}
	public Date getPayment_order_time() {
		return payment_order_time;
	}
	public void setPayment_order_time(Date payment_order_time) {
		this.payment_order_time = payment_order_time;
	}
	public String getDelivery_status() {
		return delivery_status;
	}
	public void setDelivery_status(String delivery_status) {
		this.delivery_status = delivery_status;
	}
	public int getFinal_total_price() {
		return final_total_price;
	}
	public void setFinal_total_price(int final_total_price) {
		this.final_total_price = final_total_price;
	}
	public String getGoods_option() {
		return goods_option;
	}
	public void setGoods_option(String goods_option) {
		this.goods_option = goods_option;
	}
	public String getRecipient_name() {
		return recipient_name;
	}
	public void setRecipient_name(String recipient_name) {
		this.recipient_name = recipient_name;
	}
	public String getGoods_image_name() {
		return goods_image_name;
	}
	public void setGoods_image_name(String goods_image_name) {
		this.goods_image_name = goods_image_name;
	}
	public GoodsVO getGoods() {
		return goods;
	}
	public void setGoods(GoodsVO goods) {
		this.goods = goods;
	}
	
	
	//카카오페이 정보
	public String getAid() {
		return order_id;
	}
	public void setAid(String aid) {
		this.order_id = aid;
	}
	public String getTid() {
		return tid;
	}
	public void setTid(String tid) {
		this.tid = tid;
	}
	public String getCid() {
		return cid;
	}
	public void setCid(String cid) {
		this.cid = cid;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getPartner_order_id() {
		return partner_order_id;
	}
	public void setPartner_order_id(String partner_order_id) {
		this.partner_order_id = partner_order_id;
	}
	public String getPartner_user_id() {
		return partner_user_id;
	}
	public void setPartner_user_id(String partner_user_id) {
		this.partner_user_id = partner_user_id;
	}
	public String getPayment_method_type() {
		return payment_method_type;
	}
	public void setPayment_method_type(String payment_method_type) {
		this.payment_method_type = payment_method_type;
	}
	public String getItem_name() {
		return goods_title;
	}
	public void setItem_name(String item_name) {
		this.goods_title = item_name;
	}
	public String getItem_code() {
		return item_code;
	}
	public void setItem_code(String item_code) {
		this.item_code = item_code;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	
}
