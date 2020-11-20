package org.giangnt.authentication;

import org.giangnt.dao.AccountDAO;
import org.giangnt.entity.Account;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class MyDBAuthenticationService implements UserDetailsService {

    @Autowired
    private AccountDAO accountDAO;

    @Override
    public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
        Account account = accountDAO.findAccount(userName);
        if (account == null) {
            throw new UsernameNotFoundException("User " + userName + " was not found int the database");
        }
        String role = account.getUserRole();
        List<GrantedAuthority> grantedAuthorityList = new ArrayList<GrantedAuthority>();
        GrantedAuthority authority = new SimpleGrantedAuthority("ROLE_" + role);
        grantedAuthorityList.add(authority);
        UserDetails userDetails = User.withUsername(account.getUserName()).password("{noop}" + account.getPassword()).roles(role).build();

        return userDetails;
    }
}
