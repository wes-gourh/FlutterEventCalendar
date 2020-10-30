import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import './CalendarClient.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CalendarClient calendarClient = CalendarClient();
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now().add(Duration(days: 1));
  TextEditingController _eventName = TextEditingController();
  DateTime selectedDate;

  _body(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  DatePicker.showDateTimePicker(
                    context,
                    showTitleActions: true,
                    minTime: DateTime(2019, 3, 5),
                    maxTime: DateTime(2200, 6, 7),
                    onChanged: (date) {
                      print('change $date');
                    },
                    onConfirm: (date) {
                      setState(
                        () {
                          this.startTime = date;
                        },
                      );
                    },
                    // currentTime: DateTime.now(),
                    // locale: LocaleType.en,
                  );
                },
                child: Text(
                  'Event Start Time',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Text('${DateFormat.yMd().add_jm().format(startTime)}'),
            ],
          ),
          Row(
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  DatePicker.showDateTimePicker(
                    context,
                    showTitleActions: true,
                    minTime: DateTime(2019, 3, 5),
                    maxTime: DateTime(2200, 6, 7),
                    onChanged: (date) {
                      print('change $date');
                    },
                    onConfirm: (date) {
                      setState(() {
                        this.endTime = date;
                      });
                    },
                    currentTime: DateTime.now(),
                    locale: LocaleType.en,
                  );
                },
                child: Text(
                  'Event End Time',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Text(
                '${DateFormat.yMd().add_jm().format(endTime)}',
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _eventName,
              decoration: InputDecoration(hintText: 'Enter Event name'),
            ),
          ),
          RaisedButton(
              child: Text(
                'Insert Event',
              ),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: () {
                print("Event :" + _eventName.text);
                _eventName.text == null || _eventName.text == ''
                    ? Fluttertoast.showToast(
                        msg: "Enter Event Name please!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        // timeInSecForIosWeb: 1,
                        backgroundColor: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        fontSize: 16.0)
                    :
                    //log('add event pressed');
                    calendarClient.insert(
                        _eventName.text,
                        startTime,
                        endTime,
                      );
              }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }
}
