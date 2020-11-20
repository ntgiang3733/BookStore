package org.giangnt.controller;

import org.giangnt.dao.AccountDAO;
import org.giangnt.entity.Account;
import org.giangnt.model.AccountInfo;
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
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@Transactional
@EnableWebMvc
public class AdminController {

    @Autowired
    private AccountDAO accountDAO;

    //Post : register new account
    @RequestMapping(value = {"/signup"}, method = RequestMethod.POST)
    public String signupSaveHandler(Model model, @ModelAttribute("accountInfo") @Validated AccountInfo accountForm,
                                    BindingResult result, final RedirectAttributes redirectAttributes) {
        Account accountRegister = null;
        accountRegister = accountDAO.findAccount(accountForm.getUserName());
        if(accountRegister == null) {
            try {
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
}
