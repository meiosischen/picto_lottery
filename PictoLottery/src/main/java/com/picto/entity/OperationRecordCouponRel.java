package com.picto.entity;

public class OperationRecordCouponRel {
    private Integer id;
    private Integer operationRecordId;
    private Integer couponId;
    
	public Integer getId() {
		return id;
	}
	
	public void setId(Integer id) {
		this.id = id;
	}
	
	public Integer getOperationRecordId() {
		return operationRecordId;
	}
	
	public void setOperationRecordId(Integer operationRecordId) {
		this.operationRecordId = operationRecordId;
	}
	
	public Integer getCouponId() {
		return couponId;
	}
	
	public void setCouponId(Integer couponId) {
		this.couponId = couponId;
	}
}
