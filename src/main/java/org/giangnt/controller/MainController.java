package org.giangnt.controller;

import org.giangnt.dao.CategoryDAO;
import org.giangnt.dao.ProductDAO;
import org.giangnt.entity.Category;
import org.giangnt.model.PaginationResult;
import org.giangnt.model.ProductInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;

@Controller
@Transactional
@EnableWebMvc
public class MainController {

    @Autowired
    private ProductDAO productDAO;

    @Autowired
    private CategoryDAO categoryDAO;

    @RequestMapping("/")
    public String home(HttpServletRequest request) {
        if(request.getServletContext().getAttribute("categories") == null) {
            categoryDAO.listCategory();
        }
        //get top 4 products each category
        ArrayList<PaginationResult<ProductInfo>> topProducts = new ArrayList<>();
        for(Category category : categoryDAO.listCategory()) {
            topProducts.add(categoryDAO.queryProducts(1, 4, 10, category.getId()));
        }
        request.getServletContext().setAttribute("topProducts", topProducts);

        return "index";
    }

    @RequestMapping("/productList")
    public String productListHandler(Model model,
           @RequestParam(value = "likeName", defaultValue = "") String likeName,
           @RequestParam(value = "page", defaultValue = "1") int page,
           @RequestParam(value = "cat", defaultValue = "") String cat) {
        final int maxResult = 9;
        final int maxNavigationPage = 10;
        PaginationResult<ProductInfo> rs;

        if(cat != null && cat.length() > 0) {
            rs = categoryDAO.queryProducts(page, maxResult, maxNavigationPage, cat);
        } else {
            rs = productDAO.queryProducts(page, maxResult, maxNavigationPage, likeName);
        }
        if(rs != null) {
            model.addAttribute("paginationProducts", rs);
        }
        return "productList";
    }

    //show product detail
    @RequestMapping(value = {"/productInfo"}, method = RequestMethod.GET)
    public String productInfoHandler(Model model, @RequestParam(value = "code", defaultValue = "") String code) {
        ProductInfo productInfo = null;
        if(code != null && code.length() > 0) {
            productInfo = productDAO.findProductInfo(code);
        }
        if(productInfo == null) {
            return "redirect:/productList";
        }
        model.addAttribute("productForm", productInfo);

        PaginationResult<ProductInfo> relativeProducts = categoryDAO.queryProducts(1, 4, 10, productInfo.getCategory().getId());
        model.addAttribute("relativeProducts", relativeProducts);

        return "productInfo";
    }
}
