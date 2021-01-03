import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.xml.bind.annotation.adapters.XmlAdapter;

/**
 *Sets the simple date format display for the ticket information about the date
 */
public class DateTimeAdapter{

    public static final String DATE_FORMAT = "dd-MM-yyyy HH:mm:ss";

    private final DateFormat dateFormat = new SimpleDateFormat(DATE_FORMAT);
}