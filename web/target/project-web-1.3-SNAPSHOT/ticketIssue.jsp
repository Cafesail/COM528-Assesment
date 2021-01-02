<%-- 
    Document   : ticketIssue
    Created on : 28-Dec-2020, 14:46:39
    Author     : johngimiliaris
--%>




<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.lang.*"%>
<%@page import="org.solent.com528.project.model.dao.PriceCalculatorDAO"%>
<%@page import="org.solent.com528.project.model.dto.TicketMachine"%>
<%@page import="org.solent.com528.project.model.dao.TicketMachineDAO"%>
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


<%
    // used to place error message at top of page 
    String errorMessage = "";
    String message = "";

    // used to set html header autoload time. This automatically refreshes the page
    // Set refresh, autoload time every 20 seconds
    response.setIntHeader("Refresh", 20);

    // accessing service 
    ServiceFacade serviceFacade = (ServiceFacade) WebObjectFactory.getServiceFacade();
    StationDAO stationDAO = serviceFacade.getStationDAO();
    TicketMachineDAO ticketMachineDAO = serviceFacade.getTicketMachineDAO();
    PriceCalculatorDAO priceCalculatorDAO = serviceFacade.getPriceCalculatorDAO();
    Set<Integer> zones = stationDAO.getAllZones();
    List<Station> stationList = new ArrayList<Station>();
    
   SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy"); 

    // accessing request parameters
    String actionStr = request.getParameter("action");
    String stationName = request.getParameter("stationName");
    String zoneStr = request.getParameter("zone");
    
    String ticketMachineUUID = request.getParameter("ticketMachineUuid");

    Integer zone = 0;
    if (zoneStr != null) {
        zone = Integer.parseInt(zoneStr);
    } else {
        if (!zones.isEmpty()) {
            zone = zones.iterator().next();
        }
    }
    
//    //ticket machine information
//        //TicketMachine ticketMachine = null;
//    TicketMachine ticketMachine = ticketMachineDAO.findByUuid(ticketMachineUUID);
//    String ticketMachineInfo = ticketMachine.toString();
    
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
    
    Double peakPricePerZone = 5.10;

    Double offpeakPricePerZone = 3.10;
    Double ticketPrice = peakPricePerZone * zonesTravelled;
    
//    Date validTo = new Date();

    Date currentDate = new Date();
    Calendar c = Calendar.getInstance();
    c.setTime(currentDate);
    
    String validTo = c.getTime().toString();
    
    String testDate = validTo.toString();
    
    

    
    //TODO: DELETE THIS JUST FOR CHECK USE
    String tstat = targetStation.toString();
 
   
    
    // return station list for zone
    if (zoneStr == null || zoneStr.isEmpty()) {
        stationList = stationDAO.findAll();
    } else {
        try {
            stationList = stationDAO.findByZone(zone);
        } catch (Exception ex) {
            errorMessage = ex.getMessage();
        }
    }
    

    // basic error checking before making a call
    if (actionStr == null || actionStr.isEmpty()) {
        // just display list
    
    } else {
        errorMessage = "ERROR: page called for unknown action";
    }

%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Get Your Ticket</title>
    </head>
    <body>
        
        

        <H1>Ticket Issue</H1>
        <p>The time is: <%= new Date().toString()%> (note page is auto refreshed every 20 seconds)</p>
       <!-- <p>Selected Machine: </p> -->
        <h3>You Are at Station: <%= startStation%></h3>
        <p><%= startZone%></p>
        <p><%= zonesTravelled%></p>
        <p><%= testDate%></p>
    
        <p>GoTo station is: <%= targetZone%></p>
        
        
        <!<!--TODO: DELETE THIS  -->
 
        <p>The station we are going to: <%= tstat%></p>
        <!-- print error message if there is one -->
        <div style="color:red;"><%=errorMessage%></div>
        <div style="color:green;"><%=message%></div>

        <p>The time is: <%= new Date().toString()%> (note page is auto refreshed every 20 seconds)</p>

        
    </body>
</html>
