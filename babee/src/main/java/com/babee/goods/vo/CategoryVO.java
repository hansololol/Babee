package com.babee.goods.vo;

import org.springframework.stereotype.Component;

@Component("categoryVO")
public class CategoryVO {
	private String main_category;
    private String middle_category;
    private String sub_category;
	public String getMain_category() {
		return main_category;
	}
	public void setMain_category(String main_category) {
		this.main_category = main_category;
	}
	public String getMiddle_category() {
		return middle_category;
	}
	public void setMiddle_category(String middle_category) {
		this.middle_category = middle_category;
	}
	public String getSub_category() {
		return sub_category;
	}
	public void setSub_category(String sub_category) {
		this.sub_category = sub_category;
	}
	

    
    
}
