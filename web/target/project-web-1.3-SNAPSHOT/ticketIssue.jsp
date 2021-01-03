


<%@page import="org.solent.com528.project.clientservice.impl.TicketEncoder"%>
<%@page import="org.solent.com528.project.model.dto.Ticket"%>
<%-- 
    Document   : ticketIssue
    Created on : 28-Dec-2020, 14:46:39
    Author     : johngimiliaris
--%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">


<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.lang.*"%>
<%@page import="org.solent.com528.project.model.dao.PriceCalculatorDAO"%>
<%@page import="org.solent.com528.project.model.dto.TicketMachine"%>
<%@page import="org.solent.com528.project.model.dao.TicketMachineDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Date"%>
<%@page import="org.solent.com528.project.impl.web.WebObjectFactory"%>
<%@page import="org.solent.com528.project.model.service.ServiceFacade"%>
<%@page import="org.solent.com528.project.model.dao.StationDAO"%>
<%@page import="org.solent.com528.project.model.dto.Station"%>



<%
    // used to place error message at top of page 
    String errorMessage = "";
    String message = "";

    // accessing service 
    ServiceFacade serviceFacade = (ServiceFacade) WebObjectFactory.getServiceFacade();
    StationDAO stationDAO = serviceFacade.getStationDAO();
    TicketMachineDAO ticketMachineDAO = serviceFacade.getTicketMachineDAO();
    PriceCalculatorDAO priceCalculatorDAO = serviceFacade.getPriceCalculatorDAO();
    Set<Integer> zones = stationDAO.getAllZones();
    List<Station> stationList = new ArrayList<Station>();
    
    //config the date object
    String DATE_FORMAT = "dd-MM-yyyy HH:mm:ss";
    DateFormat df = new SimpleDateFormat(DATE_FORMAT);
    
    // accessing request parameters
    String actionStr = request.getParameter("action");
    String stationName = request.getParameter("stationName");
    String zoneStr = request.getParameter("zone");
    
    String ticketMachineUUID = request.getParameter("ticketMachineUuid");

    //Station Names
    String goTostation = request.getParameter("stationName");
    String startStation = request.getParameter("startStatName");
    
    //Go to station Object Initiation
    Station targetStation = null;
    targetStation = stationDAO.findByName(goTostation);

    //Start Station Object
    int targetZone = targetStation.getZone();
    int startZone = stationDAO.findByName(startStation).getZone();
    
    int zonesTravelled = targetZone-startZone;
    
    if (zonesTravelled<0) {
        zonesTravelled = zonesTravelled *-1;
    }
    
    //Date info
    String validFromStr = "";
    validFromStr = df.format(new Date());
    
    String validToStr = "";
    validToStr = df.format(new Date(new Date().getTime() + 1000 * 60 * 60 * 24));
    
    Date validFrom = df.parse(validFromStr);
    Date validTo = df.parse(validToStr);
    
    //Setting the Prices
    Double pperofzone = 0.0;
    try {
        pperofzone = priceCalculatorDAO.getOffpeakPricePerZone();
        
    } catch (Exception ex) {
        errorMessage = ex.getMessage();
    }
   
    //create ticket
    Ticket ticket = new Ticket();
    ticket.setCost(pperofzone);
    ticket.setIssueDate(validFrom);
    ticket.setStartStation(startStation);
    ticket.setZones(zonesTravelled);
    ticket.setValidTo(validTo);
  
    //encode ticket
    String encodedTicket = "";
    encodedTicket = TicketEncoder.encodeTicket(ticket);

    
    
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Get Your Ticket</title>
    </head>
    <body>
        
        

        <H1>Ticket Issue</H1>
        <p>The time is: <%= new Date().toString()%></p>
       <!-- <p>Selected Machine: </p> -->
        <h3>You Are at Station: <%= startStation%></h3>
        <p><%= startZone%></p>
        <p><%= encodedTicket%></p>
        <p>Valid From: <%= validFrom.toString()%></p>
        <p>Valid To <%= validTo.toString()%></p>
        <p>The off peak price is: <%=pperofzone%></p>
    
        <p>GoTo station is: <%= targetZone%></p>
        
        
        <!<!--TODO: DELETE THIS  -->
 
        <p>The station you are going to: <%= goTostation%></p>
        <!-- print error message if there is one -->
        <div style="color:red;"><%=errorMessage%></div>
        <div style="color:green;"><%=message%></div>
        
        <h1>Your Ticket</h1>
        <textarea id="ticketTextArea" rows="10" cols="120"><%=encodedTicket%></textarea>

    

        
    </body>
</html>
