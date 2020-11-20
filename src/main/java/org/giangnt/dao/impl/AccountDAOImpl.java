package org.giangnt.dao.impl;

import org.giangnt.dao.AccountDAO;
import org.giangnt.entity.Account;
import org.giangnt.model.AccountInfo;
import org.giangnt.model.PaginationResult;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.Date;

@Transactional
public class AccountDAOImpl implements AccountDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public Account findAccount(String userName) {
        Session sess = sessionFactory.getCurrentSession();
        CriteriaBuilder builder = sess.getCriteriaBuilder();
        CriteriaQuery<Account> query = builder.createQuery(Account.class);
        Root<Account> root = query.from(Account.class);
        query.select(root);
        query.where(builder.equal(root.get("userName"), userName));
        Object tmp = sess.createQuery(query).uniqueResult();
        return (Account) tmp;
    }

    @Override
    public AccountInfo findAccountInfo(String userName) {
        Account account = this.findAccount(userName);
        if(account == null) {
            return null;
        }
        return new AccountInfo(account);
    }

    @Override
    public Account registerNewUserAccount(AccountInfo accountForm) {
        Account account = new Account();

        account.setUserName(accountForm.getUserName());
        account.setActive(true);
        account.setAddress(accountForm.getAddress());
        account.setEmail(accountForm.getEmail());
        account.setName(accountForm.getName());
        account.setPassword(accountForm.getPassword());
        account.setPhoneNumber(accountForm.getPhoneNumber());
        account.setUserRole(accountForm.getUserRole());
        account.setDateCreate(new Date());
        account.setDateUpdated(new Date());

        this.sessionFactory.getCurrentSession().persist(account);
        this.sessionFactory.getCurrentSession().flush();

        return findAccount(account.getUserName());
    }

    @Override
    public PaginationResult<AccountInfo> listAccountInfo(int page, int maxResult, int maxNavigationPage) {
        String sql = "Select new " + AccountInfo.class.getName()
                + "(acc.userName, acc.active, acc.password, acc.userRole, acc.name, acc.email,"
                + " acc.phoneNumber, acc.address,acc.dateCreate,acc.dateUpdated) from "
                + Account.class.getName() + " acc order by acc.dateCreate desc, acc.userName asc";
        Session session = this.sessionFactory.getCurrentSession();
        Query<?> query = session.createQuery(sql);
        return new PaginationResult<>(query, page, maxResult, maxNavigationPage);
    }

    @Override
    public void updateAccountStatus(Account account) {
        if (account.isActive()) {
            account.setActive(false);
        } else {
            account.setActive(true);
        }
        account.setDateUpdated(new Date());
        this.sessionFactory.getCurrentSession().saveOrUpdate(account);
    }

    @Override
    public void saveAccountInfo(AccountInfo accountInfo) {
        String userName = accountInfo.getUserName();
        System.out.println("1 " + accountInfo);
        Account account = null;
        if (userName!=null && userName.length()>0) {
            account = this.findAccount("employee1");
            System.out.println("2 " + account.getName());
        }

        account.setDateUpdated(new Date());
        account.setEmail(accountInfo.getEmail());
        account.setAddress(accountInfo.getAddress());
        account.setName(accountInfo.getName());
        account.setPassword(accountInfo.getPassword());
        account.setUserRole(accountInfo.getUserRole());
        account.setPhoneNumber(accountInfo.getPhoneNumber());
//        System.out.println("3 " + account.getName());
        this.sessionFactory.getCurrentSession().flush();
//        System.out.println("4 " + account.getName());
    }
}
