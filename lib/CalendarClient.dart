import 'dart:developer';

import "package:googleapis_auth/auth_io.dart";
import 'package:googleapis/calendar/v3.dart';
import 'package:url_launcher/url_launcher.dart';

class CalendarClient {
  static const _scopes = const [CalendarApi.CalendarScope];

  insert(title, startTime, endTime) {
    var _clientID = new ClientId(
        "183256683678-407fpo1rk8qc736ctnhs28ohmndiqt14.apps.googleusercontent.com",
        "");
    clientViaUserConsent(_clientID, _scopes, prompt).then((AuthClient client) {
      var calendar = CalendarApi(client);
      calendar.calendarList.list().then((value) => print("VAL________$value"));

      String calendarId = "primary";
      Event event = Event(); // Create object of event

      EventDateTime start = new EventDateTime();
      start.dateTime = startTime;
      start.timeZone = "GMT+05:00";
      event.start = start;

      EventDateTime end = new EventDateTime();
      end.timeZone = "GMT+05:00";
      end.dateTime = endTime;
      event.end = end;

      event.summary = title;
      log('Before pop up');

//       EventReminder[] reminderOverrides = new EventReminder[] {
//     new EventReminder().setMethod("email").setMinutes(24 * 60),
//     new EventReminder().setMethod("popup").setMinutes(10),
// };
// Event.Reminders reminders = new Event.Reminders()
//     .setUseDefault(false)
//     .setOverrides(Arrays.asList(reminderOverrides));
// event.setReminders(reminders);

      EventReminder e1 = new EventReminder();
      e1.method = "popup";
      e1.minutes = 60;

      List<EventReminder> eList = new List<EventReminder>();
      eList.add(e1);

      EventReminders ers = new EventReminders();
      ers.useDefault = false;
      ers.overrides = eList;

      event.reminders = ers;

      // event.reminders.useDefault = false;
      log('After pop up 0');
      // event.reminders.overrides[0].method = "popup";
      log('After pop up 1');
      // event.reminders.overrides[0].minutes = 1;
      // event.reminders = remArr;
      log('After pop up 2');
      try {
        calendar.events.insert(event, calendarId).then((value) {
          print("ADDEDDD_________________${value.status}");
          if (value.status == "confirmed") {
            log('Event added in google calendar');
          } else {
            log("Unable to add event in google calendar");
          }
        });
      } catch (e) {
        log('Error creating event $e');
      }
    });
  }

  void prompt(String url) async {
    print("Please go to the following URL and grant access:");
    print("  => $url");
    print("");

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
