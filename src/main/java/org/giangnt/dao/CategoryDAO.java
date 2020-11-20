package org.giangnt.dao;

import org.giangnt.entity.Category;
import org.giangnt.model.PaginationResult;
import org.giangnt.model.ProductInfo;

import java.util.List;

public interface CategoryDAO {

    public List<Category> listCategory();

    public PaginationResult<ProductInfo> queryProducts(int page, int maxResult,
                                                       int maxNavigationPage, String cat);
}
