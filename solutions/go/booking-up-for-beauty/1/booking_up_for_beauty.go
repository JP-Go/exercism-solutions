package booking

import "time"

const (
    scheduleDateFormat = "1/2/2006 15:04:05"
    hasPassedDateFormat = "January 2, 2006 15:04:05"
    isAfternoonAppointmentDateFormat = "Monday, January 2, 2006 15:04:05"
	appointmentDescriptionDateFormat = "Monday, January 2, 2006, at 15:04."
)

// Schedule returns a time.Time from a string containing a date.
func Schedule(date string) time.Time {
	t,err := time.Parse(scheduleDateFormat,date)
    if err != nil {
        panic("Invalid date passed")
    }
    return t
}

// HasPassed returns whether a date has passed.
func HasPassed(date string) bool {
	t, err := time.Parse(hasPassedDateFormat, date)
    if err != nil {
        panic("Invalid date passed")
    }
    return t.Before(time.Now()) 
}

// IsAfternoonAppointment returns whether a time is in the afternoon.
func IsAfternoonAppointment(date string) bool {
	t,err := time.Parse(isAfternoonAppointmentDateFormat,date)
    if err != nil {
        panic("Invalid date passed")
    }
	return t.Hour() >= 12 && t.Hour() < 18 
}

// Description returns a formatted string of the appointment time.
func Description(date string) string {
	t, err := time.Parse(scheduleDateFormat, date)
    if err != nil {
        panic("Invalid date passed")
    }
	return "You have an appointment on " + t.Format(appointmentDescriptionDateFormat)
}

// AnniversaryDate returns a Time with this year's anniversary.
func AnniversaryDate() time.Time {
	return time.Date(time.Now().Year(),time.September,int(15),int(0),int(0),int(0),int(0),time.UTC)

}
