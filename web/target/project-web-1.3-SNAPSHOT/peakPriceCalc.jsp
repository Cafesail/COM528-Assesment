<%@page import="org.solent.com528.project.model.service.ServiceObjectFactory"%>
<%@page import="org.solent.com528.project.model.dao.DAOFactory"%>
<%@page import="org.solent.com528.project.model.dao.PriceCalculatorDAO"%>
<%@page import="org.solent.com528.project.impl.web.WebObjectFactory"%>
<%@page import="org.solent.com528.project.model.service.ServiceFacade"%>
<%@page import="java.util.UUID"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">


<%
 
    ServiceFacade serviceFacade = (ServiceFacade) WebObjectFactory.getServiceFacade();
    PriceCalculatorDAO priceCalculatorDAO = WebObjectFactory.getPriceCalculatorDAO();
    

    Double offPeak = 3.10;
    Double peak = 5.10;
    
    priceCalculatorDAO.setOffpeakPricePerZone(offPeak);
    priceCalculatorDAO.setPeakPricePerZone(peak);
    Double pperofzone = priceCalculatorDAO.getOffpeakPricePerZone();
    
    

    
%>
    



<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        
        <p>Price will be: <%=priceCalculatorDAO.getOffpeakPricePerZone()%></p>
    </body>
</html>
