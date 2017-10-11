package com.vimaan.service;
import com.vimaan.model.Account;
import com.vimaan.model.User;
/**
 * Created by IT Division on 10-10-2017.
 */
public interface AccountService {

    Account getAccount(User user);
}
