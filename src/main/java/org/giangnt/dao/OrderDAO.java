package org.giangnt.dao;

import org.giangnt.entity.OrderDetail;
import org.giangnt.model.CartInfo;
import org.giangnt.model.OrderDetailInfo;
import org.giangnt.model.OrderInfo;
import org.giangnt.model.PaginationResult;

import java.util.List;

public interface OrderDAO {

    public void saveOrder(CartInfo cartInfo);

    public PaginationResult<OrderInfo> listOrderInfo(int page, int maxResult, int maxNavigationPage);

    public OrderInfo getOrderInfo(String orderId);

    public void deleteOrder(String orderId);

    public List<OrderDetailInfo> listOrderDetailInfo(String orderId);

    public OrderDetail findOrderDetail(String orderDetailId);
}
