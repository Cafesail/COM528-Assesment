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
    Set<Integer> zones = stationDAO.getAllZones();
    List<Station> stationList = new ArrayList<Station>();

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
    
    //ticket machine information
    TicketMachine ticketMachine = null;
    ticketMachine = ticketMachineDAO.findByUuid(ticketMachineUUID);
    String ticketMachineInfo = ticketMachine.toString();
    
    //startStation information
    Station startStation = ticketMachine.getStation();
    String startStationName = startStation.getName();
   
    

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
        <title>Ticket Machine</title>
    </head>
    <body>
        

        
        
        <H1>Welcome Passenger</H1>
        <H2><%= startStationName%></H2>
        <h3>Select the station you want to go to</H3>
        <p>Selected Machine: <%= ticketMachineInfo%></p>
        <!-- print error message if there is one -->
        <div style="color:red;"><%=errorMessage%></div>
        <div style="color:green;"><%=message%></div>

        <p>The time is: <%= new Date().toString()%> (note page is auto refreshed every 20 seconds)</p>

        <form action="./stationList.jsp" method="get">
            <button type="submit" >Show All Zones</button>
        </form> 
        
            
            

      
        <p>Stations in <%= (zoneStr == null) ? "All Zones" : "Zone&nbsp;" + zoneStr%></p>

        <table border="1">
            <tr>
                <th>Station Name</th>
                <th>Station Zone</th>
            </tr>
            <%
                for (Station station : stationList) {
            %>
            <tr>
                <td size="36" ><%=station.getName()%></td>
                <td size="36" >Zone&nbsp;<%=station.getZone()%></td>
                <td>
                    <form action="./ticketIssue.jsp" method="get">
                        <input type="hidden" name="stationName" value="<%=station.getName()%>">
                        
                        <input type="hidden" name="startStatName" value="<%=startStationName%>">
                        <input type="hidden" name="zone" value="<%= zone%>">
                    
                        <button type="submit" >Select Station</button>
                    </form> 
                </td>
                
            </tr>
            <%
                }
            %>
        </table> 
    </body>
</html>
