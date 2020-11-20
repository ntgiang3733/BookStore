package org.giangnt.dao;

import org.giangnt.entity.Account;
import org.giangnt.model.AccountInfo;
import org.giangnt.model.PaginationResult;

public interface AccountDAO {

    public Account findAccount(String userName);

    public AccountInfo findAccountInfo(String userName);

    public Account registerNewUserAccount(AccountInfo accountForm);

    public PaginationResult<AccountInfo> listAccountInfo(int page, int maxResult, int maxNavigationPage);

    public void updateAccountStatus(Account account);

    public void saveAccountInfo(AccountInfo accountInfo);
}
