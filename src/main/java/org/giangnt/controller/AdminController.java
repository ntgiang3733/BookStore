package org.giangnt.controller;

import org.giangnt.dao.AccountDAO;
import org.giangnt.dao.CategoryDAO;
import org.giangnt.dao.OrderDAO;
import org.giangnt.dao.ProductDAO;
import org.giangnt.entity.Account;
import org.giangnt.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
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
import java.util.List;

@Controller
@Transactional
@EnableWebMvc
public class AdminController {

    @Autowired
    private AccountDAO accountDAO;

    @Autowired
    private OrderDAO orderDAO;

    @Autowired
    private ProductDAO productDAO;

    @Autowired
    private CategoryDAO categoryDAO;

    @RequestMapping("/admin")
    public String admin() {
        return "admin";
    }

    //GET : show sign in page
    @RequestMapping(value = "/signin", method = RequestMethod.GET)
    public String signinHandler(Model model) {
        AccountInfo accountInfo = new AccountInfo();
        model.addAttribute("accountInfo", accountInfo);
        return "signin";
    }

    //GET : show sign up page
    @RequestMapping(value = "/signup", method = RequestMethod.GET)
    public String signupHandler(Model model) {
        AccountInfo accountInfo = new AccountInfo();
        model.addAttribute("accountInfo", accountInfo);
        return "signup";
    }

    //Post : register new account
    @RequestMapping(value = {"/signup"}, method = RequestMethod.POST)
    public String signupSaveHandler(Model model, @ModelAttribute("accountInfo") @Validated AccountInfo accountForm,
                                    BindingResult result, final RedirectAttributes redirectAttributes) {
        Account accountRegister = null;
        accountRegister = accountDAO.findAccount(accountForm.getUserName());
        if(accountRegister == null) {
            try {
                accountForm.setUserRole(Account.ROLE_EMPLOYEE);
                accountRegister = accountDAO.registerNewUserAccount(accountForm);
            } catch (Exception ex) {
                ex.printStackTrace();
                model.addAttribute("errorMessage", "Error " + ex.getMessage());
                return "index";
            }
        }
        return "redirect:/accountInfo";
    }

    //POST : create account
    @RequestMapping(value = {"/createAccount"}, method = RequestMethod.POST)
    public String createAccountSaveHandler(Model model,
            @ModelAttribute("accountInfo") @Validated AccountInfo accountForm,
            BindingResult result, final RedirectAttributes redirectAttributes) {
        Account accountRegister = null;
        accountRegister = accountDAO.findAccount(accountForm.getUserName());
        if (accountRegister == null)
            try {
                accountRegister = accountDAO.registerNewUserAccount(accountForm);
            } catch (Exception ex) {
                ex.printStackTrace();
                model.addAttribute("errorMessage", "Error " + ex.getMessage());
                return "createAccount";
            }
        return "redirect:/manageAccount";
    }

    //Get account info
    @RequestMapping(value = {"/accountInfo"}, method = RequestMethod.GET)
    public String accountInfo(Model model) {
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        AccountInfo accountInfo = null;
        accountInfo = accountDAO.findAccountInfo(userDetails.getUsername());
        model.addAttribute("accountInfo", accountInfo);
        return "accountInfo";
    }

    @RequestMapping(value = { "/accountInfo" }, method = RequestMethod.POST)
    @Transactional(propagation = Propagation.NEVER)
    public String accountInfoUpdate(Model model, @ModelAttribute("accountInfo") @Validated AccountInfo accountInfo) {
        try {
            System.out.println(accountInfo.getUserName() + "   " + accountInfo.getUserRole() + "  " + accountInfo.getName());
            accountDAO.saveAccountInfo(accountInfo);
        } catch (Exception e) {
            String message = e.getMessage();
            model.addAttribute("message", message);
        }
        return "redirect:/accountInfo";
    }



    //GET : show order list
    @RequestMapping(value = {"/orderList"}, method = RequestMethod.GET)
    public String orderList(Model model, @RequestParam(value = "page", defaultValue = "1") String pageStr) {
        int page = 1;
        try {
            page = Integer.parseInt(pageStr);
        } catch (Exception e) {

        }
        final int MAX_RESULT = 5;
        final int MAX_NAVIGATION_PAGE = 10;
        PaginationResult<OrderInfo> paginationResult = orderDAO.listOrderInfo(page, MAX_RESULT, MAX_NAVIGATION_PAGE);
        model.addAttribute("paginationResult", paginationResult);
        return "orderList";
    }

    // GET: show order info
    @RequestMapping(value = { "/order" }, method = RequestMethod.GET)
    public String orderViewHandler(Model model, @RequestParam("orderId") String orderId) {
        OrderInfo orderInfo = null;
        if (orderId != null) {
            orderInfo = this.orderDAO.getOrderInfo(orderId);
        }
        if (orderInfo == null)
            return "redirect:/orderList";

        List<OrderDetailInfo> details = this.orderDAO.listOrderDetailInfo(orderId);
        orderInfo.setDetails(details);

        model.addAttribute("orderInfo", orderInfo);
        return "order";

    }
//************************************PRODUCT MANAGER*****************************************************************************
    //GET : show product list
    @RequestMapping(value = {"/productManager"},method = RequestMethod.GET)
    public String productManager(Model model,
                                 @RequestParam(value = "likeName", defaultValue = "") String likeName,
                                 @RequestParam(value = "page", defaultValue = "1") int page,
                                 @RequestParam(value = "cat", defaultValue = "") String cat) {
        final int maxResult = 30;
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
        return "admin_productManager";
    }

    //GET : add/edit product page
    @RequestMapping(value = {"/productInfoManager"}, method = RequestMethod.GET)
    public String productInfoManager(Model model, @RequestParam(value = "code", defaultValue = "") String code) {
        ProductInfo productInfo = new ProductInfo();
        if(code != null && code.length() > 0) {
            productInfo = productDAO.findProductInfo(code);
        }
        model.addAttribute("productInfo", productInfo);
        return "admin_productInfoManager";
    }

    //POST : save product
    @RequestMapping(value = {"/productInfoManager"}, method = RequestMethod.POST)
    @Transactional(propagation = Propagation.NEVER)
    public String saveProductInfo(HttpServletRequest request, Model model,
                                  @ModelAttribute("productInfo") @Validated ProductInfo productInfo,
                                  BindingResult result, final RedirectAttributes redirectAttributes) {
        try {
            productDAO.save(request, productInfo);
        } catch (Exception e) {
            String message = e.getMessage();
            model.addAttribute("message", message);
            return "admin";
        }
        PaginationResult<ProductInfo> rs = productDAO.queryProducts(1, 30, 10, "");
        model.addAttribute("paginationProducts", rs);
        return "admin_productManager";
    }
    //DELETE : delete prd
    @RequestMapping(value = {"/deletePrd"}, method = RequestMethod.GET)
    public String deleteProduct(Model model, @RequestParam(value = "codeDelete", defaultValue = "") String codeDelete) {
        ProductInfo productInfo = new ProductInfo();
        if(codeDelete != null && codeDelete.length() > 0) {
            productDAO.deleteProduct(codeDelete);
        }
        PaginationResult<ProductInfo> rs = productDAO.queryProducts(1, 30, 10, "");
        model.addAttribute("paginationProducts", rs);
        return "admin_productManager";
    }
//************************************PRODUCT MANAGER*****************************************************************************





//************************************ACCOUNT MANAGER*****************************************************************************
    //GET : show acc list
    @RequestMapping(value = {"/accountManager"},method = RequestMethod.GET)
    public String accountManager(Model model) {
        PaginationResult<AccountInfo> rs = accountDAO.listAccountInfo(1,30,10);
        if(rs != null) {
            model.addAttribute("paginationAccounts", rs);
        }
        return "admin_accountManager";
    }


    //DELETE : delete acc
    @RequestMapping(value = {"/deleteAcc"}, method = RequestMethod.GET)
    public String deleteAccount(Model model, @RequestParam(value = "codeDelete", defaultValue = "") String codeDelete) {
        AccountInfo accountInfo = new AccountInfo();
        if(codeDelete != null && codeDelete.length() > 0) {
            accountDAO.deleteAccount(codeDelete);
        }
        PaginationResult<AccountInfo> rs = accountDAO.listAccountInfo(1,30,10);
        if(rs != null) {
            model.addAttribute("paginationAccounts", rs);
        }
        return "admin_accountManager";
    }
//************************************ACCOUNT MANAGER*****************************************************************************




//************************************ORDER MANAGER*****************************************************************************
    //GET : show order list
    @RequestMapping(value = {"/orderManager"},method = RequestMethod.GET)
    public String orderManager(Model model) {
        PaginationResult<OrderInfo> rs = orderDAO.listOrderInfo(1,30,10);
        if(rs != null) {
            model.addAttribute("paginationOrders", rs);
        }
        return "admin_orderManager";
    }


    //DELETE : delete order
    @RequestMapping(value = {"/deleteOrder"}, method = RequestMethod.GET)
    public String deleteOrder(Model model, @RequestParam(value = "codeDelete", defaultValue = "") String codeDelete) {
        OrderInfo orderInfo = new OrderInfo();
        if(codeDelete != null && codeDelete.length() > 0) {
            orderDAO.deleteOrder(codeDelete);
        }
        PaginationResult<OrderInfo> rs = orderDAO.listOrderInfo(1,30,10);
        if(rs != null) {
            model.addAttribute("paginationOrders", rs);
        }
        return "admin_orderManager";
    }
//************************************ORDER MANAGER*****************************************************************************
}
