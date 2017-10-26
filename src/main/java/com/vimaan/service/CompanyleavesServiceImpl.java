package com.vimaan.service;

import com.vimaan.model.Companyleaves;
import com.vimaan.dao.CompanyleavesDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.sql.DataSource;
import java.util.List;
/**
 * Created by IT Division on 13-10-2017.
 */
@Service
@Transactional
public class CompanyleavesServiceImpl implements CompanyleavesService{

    @Autowired
    DataSource datasource;

    @Autowired
    CompanyleavesDao companyleavesDao;

    public Companyleaves getCompanyleaves(Companyleaves companyleaves) {
        Companyleaves companyleaves1 = companyleavesDao.getCompanyleaves(companyleaves);
        return companyleaves1;
    }

    public void addCompanyleaves(Companyleaves companyleaves) {
        companyleavesDao.addCompanyleaves(companyleaves);
    }

    public Companyleaves checkFinancialyear(Companyleaves companyleaves) {

        Companyleaves companyleaves1 = companyleavesDao.checkFinancialyear(companyleaves);
        return companyleaves1;
    }

    public List getCompanyLeavesList(){
        return companyleavesDao.companyleaves();
    }
}
