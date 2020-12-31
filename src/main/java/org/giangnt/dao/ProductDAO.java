package org.giangnt.dao;

import org.giangnt.entity.Product;
import org.giangnt.model.PaginationResult;
import org.giangnt.model.ProductInfo;

import javax.servlet.http.HttpServletRequest;

public interface ProductDAO {

    public Product findProduct(String code);

    public ProductInfo findProductInfo(String code);

    public void deleteProduct(String code);

    public void save(HttpServletRequest request, ProductInfo productInfo);

    //paginate all product
    public PaginationResult<ProductInfo> queryProducts(int page, int maxResult, int maxNavigationPage);

    //paginate search results prduct
    public PaginationResult<ProductInfo> queryProducts(int page, int maxResult, int maxNavigationPage, String likeName);
}
