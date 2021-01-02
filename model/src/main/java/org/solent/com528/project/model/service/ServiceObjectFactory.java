package org.solent.com528.project.model.service;

import org.solent.com528.project.model.dao.PriceCalculatorDAO;

public interface ServiceObjectFactory {

    public void shutDown();

    public ServiceFacade getServiceFacade();
    public PriceCalculatorDAO getPriceCalculatorDAO();
}
