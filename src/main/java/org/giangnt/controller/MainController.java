package org.giangnt.controller;

import org.giangnt.dao.CategoryDAO;
import org.giangnt.dao.OrderDAO;
import org.giangnt.dao.ProductDAO;
import org.giangnt.entity.Category;
import org.giangnt.entity.Product;
import org.giangnt.model.CartInfo;
import org.giangnt.model.CustomerInfo;
import org.giangnt.model.PaginationResult;
import org.giangnt.model.ProductInfo;
import org.giangnt.util.Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@Controller
@Transactional
@EnableWebMvc
public class MainController {

    @Autowired
    private ProductDAO productDAO;

    @Autowired
    private CategoryDAO categoryDAO;

    @Autowired
    private OrderDAO orderDAO;

    //home page
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

        return "1index";
    }

    //get product list
    @RequestMapping("/productList")
    public String productListHandler(Model model,
           @RequestParam(value = "likeName", defaultValue = "") String likeName,
           @RequestParam(value = "page", defaultValue = "1") int page,
           @RequestParam(value = "cat", defaultValue = "") String cat) {
        final int maxResult = 12;
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
        return "1productList";
    }

    //GET : show product detail
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

        return "1productInfo";
    }

    //buy product
    @RequestMapping("/buyProduct")
    public String listProductHandler(HttpServletRequest request, Model model,
                                     @RequestParam(value = "code", defaultValue = "") String code) {
        Product product = null;
        if (code != null && code.length() > 0) {
            product = productDAO.findProduct(code);
        }

        if (product != null) {
            CartInfo cartInfo = Utils.getCartInfoSession(request);
            ProductInfo productInfo = new ProductInfo(product);
            cartInfo.addProduct(productInfo, 1);
        }
        return "redirect:/shoppingCart";
    }

    //POST : buy product
    @RequestMapping(value = {"/productInfo"}, method = RequestMethod.POST)
    public String productBuyHandler(Model model, @RequestParam(value = "code", defaultValue = "") String code) {
        return "redirect:/buyProduct?code=" + code;
    }

    //GET : show cart
    @RequestMapping(value = {"/shoppingCart"}, method = RequestMethod.GET)
    public String shoppingCartHandler(HttpServletRequest request, Model model) {
        //get list product in current session
        CartInfo myCart = Utils.getCartInfoSession(request);
        model.addAttribute("cartForm", myCart);
        return "1shoppingCart";
    }

    //POST : update product quantity in cart
    @RequestMapping(value = {"shoppingCart"}, method = RequestMethod.POST)
    public String shoppingCartUpdateQuantityHandler(HttpServletRequest request, Model model,
                                                    @ModelAttribute("cartForm") CartInfo cartForm) {
        CartInfo myCart = Utils.getCartInfoSession(request);
        myCart.updateQuantity(cartForm);
        return "redirect:/shoppingCart";
    }

    //remove product in cart
    @RequestMapping({"/shoppingCartRemoveProduct"})
    public String removeProductHandler(HttpServletRequest request, Model model,
                                       @RequestParam(value = "code", defaultValue = "") String code) {
        Product product = null;
        if (code != null && code.length() > 0) {
            product = productDAO.findProduct(code);
        }
        if(product != null) {
            CartInfo cartInfo = Utils.getCartInfoSession(request);
            ProductInfo productInfo = new ProductInfo(product);
            cartInfo.removeProduct(productInfo);
        }
        return "redirect:/shoppingCart";
    }


    //GET : input customer info
    @RequestMapping(value = {"/shoppingCartCustomer"}, method = RequestMethod.GET)
    public String shoppingCartCustomerForm(HttpServletRequest request, Model model) {
        CartInfo cartInfo = Utils.getCartInfoSession(request);
        if (cartInfo.isEmpty()){
            return "redirect:/shoppingCart";
        }
        CustomerInfo customerInfo = cartInfo.getCustomerInfo();
        if (customerInfo == null) {
            customerInfo = new CustomerInfo();
        }
        model.addAttribute("customerForm", customerInfo);
        model.addAttribute("cartForm", Utils.getCartInfoSession(request));
        return "1shoppingCartCustomer";
    }

    //POST save customer info
    @RequestMapping(value = {"shoppingCartCustomer"}, method = RequestMethod.POST)
    public String shoppingCartCustomerSave(HttpServletRequest request, Model model,
                                           @ModelAttribute("customerForm") @Validated CustomerInfo customerForm,
                                           BindingResult result, final RedirectAttributes redirectAttributes) {
        //save customer info
        customerForm.setValid(true);
        CartInfo cartInfo = Utils.getCartInfoSession(request);
        cartInfo.setCustomerInfo(customerForm);

        //confirm & save order
        //check cart
        if (cartInfo.isEmpty()) {
            return "redirect:/shoppingCart";
        } else if (!cartInfo.isValidCustomer()) {
            return "redirect:/shoppingCartCustomer";
        }

        try {
            orderDAO.saveOrder(cartInfo);
            System.out.println("save order success");
        } catch (Exception e) {
            return "/";
        }

        Utils.removeCartInSession(request);
        Utils.storeLastOrderedCartInSession(request, cartInfo);

        return "1index";
    }

    //GET : check confirmation
    @RequestMapping(value = {"shoppingCartConfirmation"}, method = RequestMethod.GET)
    public String shoppingCartConfirmationCheck(HttpServletRequest request, Model model) {
        CartInfo cartInfo = Utils.getCartInfoSession(request);
        if (cartInfo.isEmpty()) {
            return "redirect:/shoppingCart";
        } else if (!cartInfo.isValidCustomer()) {
            return "redirect:/shoppingCartCustomer";
        }
        return "shoppingCartConfirmation";
    }

    //POST : post and save order
    @RequestMapping(value = {"/shoppingCartConfirmation"}, method = RequestMethod.POST)
    @Transactional(propagation = Propagation.NEVER)
    public String shoppingCartConfirmationSave(HttpServletRequest request, Model model) {
        CartInfo cartInfo = Utils.getCartInfoSession(request);
        if (cartInfo.isEmpty()) {
            return "redirect:/shoppingCart";
        } else if (!cartInfo.isValidCustomer()) {
            return "redirect:/shoppingCartCustomer";
        }
        try {
            orderDAO.saveOrder(cartInfo);
        }catch (Exception e) {
            return "shoppingCartConfirmation";
        }
        Utils.removeCartInSession(request);
        Utils.storeLastOrderedCartInSession(request, cartInfo);
        return "shoppingCartFinalize";
    }


    @RequestMapping(value = {"/productImage"}, method = RequestMethod.GET)
    public void productImage(HttpServletRequest request, HttpServletResponse response, Model model,
                             @RequestParam("code") String code) throws IOException {
        Product product = null;
        if (code != null) {
            product = this.productDAO.findProduct(code);
        }
        if(product != null && product.getImage() != null) {
            response.setContentType("image/jpeg, image/jpg, image/png, image/gif");
            response.getOutputStream().write(product.getImage());
        }
        response.getOutputStream().close();
    }

}
