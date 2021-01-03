package org.solent.com528.project.clientservice.impl;

import org.solent.com528.project.model.dto.Ticket;

public abstract class TicketEncoder {

    public static String encodeTicket(Ticket ticket) {
        //throw new UnsupportedOperationException("Not supported yet.");
        return(TicketEncoderImpl.encodeTicket(ticket));
    }

    public static boolean validateTicket(String encodedTicket) {
        //throw new UnsupportedOperationException("Not supported yet.");
        return(TicketEncoderImpl.validateTicket(encodedTicket));
    }
}
