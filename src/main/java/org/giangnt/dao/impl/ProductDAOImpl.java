package org.giangnt.dao.impl;

import org.giangnt.dao.ProductDAO;
import org.giangnt.entity.Category;
import org.giangnt.entity.Product;
import org.giangnt.model.PaginationResult;
import org.giangnt.model.ProductInfo;
import org.giangnt.util.Commons;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;

@Transactional
public class ProductDAOImpl implements ProductDAO {

    @Autowired
    SessionFactory sessionFactory;

    @Override
    public Product findProduct(String code) {
        Session session = sessionFactory.getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Product> query = builder.createQuery(Product.class);
        Root<Product> root = query.from(Product.class);
        query.select(root).where(builder.equal(root.get("code"), code));
        return session.createQuery(query).uniqueResult();
    }

    @Override
    public ProductInfo findProductInfo(String code) {
        Product product = this.findProduct(code);
        return product == null ? null : new ProductInfo(product);
    }

    @Override
    public void save(HttpServletRequest request, ProductInfo productInfo) {
        String code = productInfo.getCode();
        System.out.println("3");

        Product product = null;
        boolean isNew = false;
        if(code != null) {
            product = this.findProduct(code);
            System.out.println("4");
        }

        if(product == null) {
            System.out.println("5");
            isNew = true;
            product = new Product();
            product.setCreateDate(new Date());
            Category category = new Category();
            category.setId("C01");
            category.setName("English Book");
            product.setCategory(category);
            product.setImage(null);
            product.setCode(code);
        }


        product.setName(productInfo.getName());
        product.setPrice(productInfo.getPrice());
        product.setDateUpdated(new Date());


//        if(productInfo.getFileDatas()[0] != null) {
//            byte[] image = productInfo.getFileDatas()[0].getBytes();
//            if(image.length > 0) {
//                product.setImage(image);
//            }
//        }
//        Commons.doUploadImage(request, productInfo);
//        System.out.println(product);
        if(isNew) {
            this.sessionFactory.getCurrentSession().persist(product);
        }
//        this.sessionFactory.getCurrentSession().delete(product);
        this.sessionFactory.getCurrentSession().flush();
    }

    @Override
    public void deleteProduct(String code) {
        this.sessionFactory.getCurrentSession().delete(findProduct(code));
    }

    @Override
    public PaginationResult<ProductInfo> queryProducts(int page, int maxResult, int maxNavigationPage) {
        return queryProducts(page, maxResult, maxNavigationPage, null);
    }

    @Override
    public PaginationResult<ProductInfo> queryProducts(int page, int maxResult, int maxNavigationPage, String likeName) {
        String sql = "Select new " + ProductInfo.class.getName() + "(p.code, p.name, p.price, c.id, c.name) from "
                 + Product.class.getName() + " p," + Category.class.getName() + " c"
                 + " Where p.category = c.id";
        if(likeName != null && likeName.length() > 0) {
            sql += " and lower(p.name) like :likeName ";
        }
        sql += " order by p.code asc, p.createDate desc ";
        System.out.println(sql);
        Session session = sessionFactory.getCurrentSession();
        Query<?> query = session.createQuery(sql);
        if(likeName != null && likeName.length() > 0) {
            query.setParameter("likeName", "%" + likeName.toLowerCase() + "%");
        }
        return new PaginationResult<>(query, page, maxResult, maxNavigationPage);
    }
}
