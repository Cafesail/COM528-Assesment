<%@page import="org.solent.com528.project.model.dto.Ticket"%>
<%@page import="org.solent.com528.project.clientservice.impl.TicketEncoder"%>
<%@page import="java.util.UUID"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Date"%>
<%@page import="org.solent.com528.project.impl.web.WebObjectFactory"%>
<%@page import="org.solent.com528.project.model.service.ServiceFacade"%>
<%@page import="org.solent.com528.project.model.dao.StationDAO"%>
<%@page import="org.solent.com528.project.model.dto.Station"%>
<%@page import="org.solent.com528.project.model.dao.TicketMachineDAO"%>
<%@page import="org.solent.com528.project.model.dto.TicketMachine"%>


<%
    // used to place error message at top of page 
    String errorMessage = "";
    String message = "";

    ServiceFacade serviceFacade = (ServiceFacade) WebObjectFactory.getServiceFacade();
    StationDAO stationDAO = serviceFacade.getStationDAO();
    TicketMachineDAO ticketMachineDAO = serviceFacade.getTicketMachineDAO();

    // accessing request parameters

    String stationName = request.getParameter("stationName");
    
    String ticketStr = request.getParameter("ticketStr");
    if (ticketStr == null || ticketStr.isEmpty() ) {
        ticketStr = "";
    }
    
    boolean gateOpen = false;
    
    gateOpen = TicketEncoder.validateTicket(ticketStr);
    String sysResponse = "";
    if (gateOpen == true){
        sysResponse = "enter";
    }
    else {
        sysResponse = "poulo";
    }
    


    
    
    
    
    

 

%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gate at station:  <%= stationName%></title>
    </head>
    <body>

        <H1>Station <%=stationName%></H1>
        <!-- print error message if there is one -->
        <div style="color:red;"><%=errorMessage%></div>
        <div style="color:green;"><%=message%></div>
        
        <form action="./gate.jsp"  method="post" >
            <table>
               
                <tr>
                    <td>Ticket Data:</td>
                    <td><textarea name="ticketStr" rows="10" cols="120"></textarea></td>
                </tr>
            </table>
            <button type="submit" >Open Gate</button>
        </form> 
        
        
        <H1><%=sysResponse%></H1>

        
        
    </body>
</html>
