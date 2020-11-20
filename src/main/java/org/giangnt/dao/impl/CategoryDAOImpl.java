package org.giangnt.dao.impl;

import org.giangnt.dao.CategoryDAO;
import org.giangnt.entity.Category;
import org.giangnt.entity.Product;
import org.giangnt.model.PaginationResult;
import org.giangnt.model.ProductInfo;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import javax.servlet.ServletContext;
import java.util.List;

@Transactional
public class CategoryDAOImpl implements CategoryDAO {

    @Autowired
    SessionFactory sessionFactory;

    @Autowired
    private ServletContext servletContext;

    @Override
    public List<Category> listCategory() {
        Session session = sessionFactory.getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Category> query = builder.createQuery(Category.class);
        Root<Category> root = query.from(Category.class);
        query.select(root);
        List<Category> rs = session.createQuery(query).getResultList();
        servletContext.setAttribute("categories", rs);
        return rs;
    }

    @Override
    public PaginationResult<ProductInfo> queryProducts(int page, int maxResult, int maxNavigationPage, String cat) {
        String sql = "Select new " + ProductInfo.class.getName() + "(p.code,p.name,p.price,c.id,c.name)" + " from "
                + Product.class.getName() + " p," + Category.class.getName() + " c";
        sql += " Where p.category = c.id";
        sql += " And p.category.id = :cat ";
        sql += " order by p.code asc, p.createDate desc ";
        System.out.println(sql);
        Session session = sessionFactory.getCurrentSession();
        Query<?> query = session.createQuery(sql);
        if (cat != null && cat.length() > 0) {
            query.setParameter("cat", cat);
        }
        return new PaginationResult<ProductInfo>(query, page, maxResult, maxNavigationPage);
    }
}
