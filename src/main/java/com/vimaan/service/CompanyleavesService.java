package com.vimaan.service;

import com.vimaan.model.Companyleaves;

import java.util.List;
/**
 * Created by IT Division on 13-10-2017.
 */
public interface CompanyleavesService {

    Companyleaves getCompanyleaves(Companyleaves companyleaves);

    void addCompanyleaves(Companyleaves companyleaves);

    Companyleaves checkFinancialyear(Companyleaves companyleaves);

    List getCompanyLeavesList();

    int deleteFinancialyear(String year);
}
