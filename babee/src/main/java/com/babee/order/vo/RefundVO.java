package com.babee.order.vo;

import org.springframework.stereotype.Component;

@Component("refundVO")
public class RefundVO {
	
		private String order_id;
		private String delivery_status;
		private String reason;
		private String goods_id;
		private String member_id;
		private String reason_option;
		public String getOrder_id() {
			return order_id;
		}
		public void setOrder_id(String order_id) {
			this.order_id = order_id;
		}
		public String getDelivery_status() {
			return delivery_status;
		}
		public void setDelivery_status(String delivery_status) {
			this.delivery_status = delivery_status;
		}
		public String getReason() {
			return reason;
		}
		public void setReason(String reason) {
			this.reason = reason;
		}
		public String getGoods_id() {
			return goods_id;
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
		public String getReason_option() {
			return reason_option;
		}
		public void setReason_option(String reason_option) {
			this.reason_option = reason_option;
		}

		
		
	


	}


