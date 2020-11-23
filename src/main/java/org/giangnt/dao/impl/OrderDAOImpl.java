package org.giangnt.dao.impl;

import com.sun.org.apache.xpath.internal.operations.Or;
import org.giangnt.dao.OrderDAO;
import org.giangnt.dao.ProductDAO;
import org.giangnt.entity.Order;
import org.giangnt.entity.OrderDetail;
import org.giangnt.entity.Product;
import org.giangnt.model.*;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Transactional
public class OrderDAOImpl implements OrderDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Autowired
    private ProductDAO productDAO;

    //get max order number
    private int getMaxOrderNumber() {
        String sql = "Select max(o.orderNum) from " + Order.class.getName() + " o ";
        Session session = sessionFactory.getCurrentSession();
        @SuppressWarnings("unchecked")
        Query<Number> query = session.createQuery(sql);
        Integer value = (Integer) query.uniqueResult();
        return value == null ? 0 : value;
    }

    @Override
    public void saveOrder(CartInfo cartInfo) {

        //save order
        Session session = sessionFactory.getCurrentSession();
        int orderNum = getMaxOrderNumber() + 1;
        Order order = new Order();

        order.setId(UUID.randomUUID().toString());
        order.setAmount(cartInfo.getAmountTotal());
        order.setOrderDate(new Date());
        order.setOrderNum(orderNum);

        CustomerInfo customerInfo = cartInfo.getCustomerInfo();
        order.setCustomerAddress(customerInfo.getAddress());
        order.setCustomerEmail(customerInfo.getEmail());
        order.setCustomerName(customerInfo.getName());
        order.setCustomerPhone(customerInfo.getPhone());

        session.persist(order);

        //save orderdetail
        List<CartLineInfo> lines = cartInfo.getCartLines();
        for (CartLineInfo cartLineInfo : lines) {
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setId(UUID.randomUUID().toString());
            orderDetail.setOrder(order);
            orderDetail.setAmount(cartLineInfo.getAmount());
            orderDetail.setPrice(cartLineInfo.getProductInfo().getPrice());
            orderDetail.setQuanity(cartLineInfo.getQuantity());

            Product product = productDAO.findProduct(cartLineInfo.getProductInfo().getCode());
            orderDetail.setProduct(product);

            session.persist(orderDetail);
        }

        //set order num to notify to user
        cartInfo.setOrderNum(orderNum);
    }

    @Override
    public PaginationResult<OrderInfo> listOrderInfo(int page, int maxResult, int maxNavigationPage) {

        String sql = "Select new " + OrderInfo.class.getName() + "(ord.id, ord.orderDate, ord.orderNum, ord.amount, "
                + "ord.customerName, ord.customerAddress, ord.customerEmail, ord.customerPhone) from "
                + Order.class.getName() + " ord order by ord.orderNum desc";
        Session session = this.sessionFactory.getCurrentSession();
        Query<?> query = session.createQuery(sql);
        return new PaginationResult<OrderInfo>(query, page, maxResult, maxNavigationPage);
    }

    private Order findOrder(String orderId) {
        Session session = sessionFactory.getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Order> query = builder.createQuery(Order.class);
        Root<Order> root = query.from(Order.class);
        query.select(root);
        query.where(builder.equal(root.get("id"), orderId));
        return (Order) session.createQuery(query).uniqueResult();
    }

    @Override
    public OrderDetail findOrderDetail(String orderDetailId) {
        Session session = sessionFactory.getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<OrderDetail> query = builder.createQuery(OrderDetail.class);
        Root<OrderDetail> root = query.from(OrderDetail.class);
        query.select(root);
        query.where(builder.equal(root.get("id"), orderDetailId));
        return (OrderDetail) session.createQuery(query).uniqueResult();
    }

    @Override
    public OrderInfo getOrderInfo(String orderId) {
        Order order = this.findOrder(orderId);
        if (order == null) {
            return null;
        }
        return new OrderInfo(order);
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<OrderDetailInfo> listOrderDetailInfo(String orderId) {
        String sql = "Select new " + OrderDetailInfo.class.getName()
                + "(d.id, d.product.code, d.product.name , d.quanity,d.price,d.amount) "
                + " from " + OrderDetail.class.getName() + " d "
                + " where d.order.id = :orderId ";

        Session session = this.sessionFactory.getCurrentSession();

        Query<?> query = session.createQuery(sql);
        query.setParameter("orderId", orderId);

        return (List<OrderDetailInfo>) query.list();
    }
}
