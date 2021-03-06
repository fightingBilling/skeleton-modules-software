package com.fenghua.auto.order.backend.vo;

import java.io.Serializable;
import java.util.List;

import com.fenghua.auto.order.backend.domain.OrderHeader;
import com.fenghua.auto.order.backend.domain.OrderItem;
import com.fenghua.auto.order.backend.domain.OrderTransport;
import com.fenghua.auto.user.intf.dto.SellerDTO;
/**
 * 子订单VO
 * @author zhangfr
 *
 */
import com.fenghua.auto.user.intf.dto.UserDTO;
public class OrderHeaderVO extends OrderHeader implements Serializable {
	private static final long serialVersionUID = 4444356751234218641L;
	/**
	 * 买家
	 */
	private UserDTO buyer;
	/**
	 * 卖家
	 */
	private SellerDTO sellerDTO;
	/**
	 * 物流信息
	 */
	private OrderTransport orderTransport;
	/**
	 * 订单明细
	 */
	private List<OrderItem> orderItems;
	public UserDTO getBuyer() {
		return buyer;
	}
	public void setBuyer(UserDTO buyer) {
		this.buyer = buyer;
	}
	public SellerDTO getSellerDTO() {
		return sellerDTO;
	}
	public void setSellerDTO(SellerDTO sellerDTO) {
		this.sellerDTO = sellerDTO;
	}
	public OrderTransport getOrderTransport() {
		return orderTransport;
	}
	public void setOrderTransport(OrderTransport orderTransport) {
		this.orderTransport = orderTransport;
	}
	
	public List<OrderItem> getOrderItems() {
		return orderItems;
	}
	public void setOrderItems(List<OrderItem> orderItems) {
		this.orderItems = orderItems;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
