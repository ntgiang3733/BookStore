package org.giangnt.controller;

import org.giangnt.dao.AccountDAO;
import org.giangnt.dao.OrderDAO;
import org.giangnt.dao.ProductDAO;
import org.giangnt.entity.Account;
import org.giangnt.model.AccountInfo;
import org.giangnt.model.OrderDetailInfo;
import org.giangnt.model.OrderInfo;
import org.giangnt.model.PaginationResult;
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
}
