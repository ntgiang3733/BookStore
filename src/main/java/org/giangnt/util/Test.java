package org.giangnt.util;

import org.giangnt.dao.AccountDAO;
import org.giangnt.entity.Account;
import org.giangnt.entity.Product;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

public class Test {
    private static SessionFactory sessionFactory;

    public static void main(String[] args) {
        Session session = sessionFactory.getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Product> query = builder.createQuery(Product.class);
        Root<Product> root = query.from(Product.class);
        query.select(root);
        query.where(builder.equal(root.get("code"), "B001"));
        Product product = (Product) session.createQuery(query).uniqueResult();

        System.out.println(product.getName());
    }
}
