import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast() {
  Fluttertoast.showToast(
      msg: 'Date and Time are scheduled !',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white);
}

Future<TimeOfDay?> _selectTime(BuildContext context,
    {@required DateTime? initialDate}) {
  final now = DateTime.now();

  return showTimePicker(
    context: context,
    initialTime: TimeOfDay(hour: initialDate!.hour, minute: initialDate.minute),
    builder: (BuildContext context, Widget? child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      );
    },
  );
}

Future<DateTime?> _selectDateTime(BuildContext context,
    {@required DateTime? initialDate}) {
  final now = DateTime.now();
  final newestDate = initialDate!.isAfter(now) ? initialDate : now;

  return showDatePicker(
    context: context,
    initialDate: newestDate.add(Duration(seconds: 1)),
    firstDate: now,
    lastDate: DateTime(2100),
  );
}

Dialog? showDateTimeDialog(
  BuildContext context, {
  @required ValueChanged<DateTime>? onSelectedDate,
  @required DateTime? initialDate,
}) {
  final dialog = Dialog(
    child: DateTimeDialog(
        onSelectedDate: onSelectedDate!, initialDate: initialDate!),
  );

  showDialog(context: context, builder: (BuildContext context) => dialog);
  return Dialog(
    child: Text(" "),
  );
}

class DateTimeDialog extends StatefulWidget {
  final ValueChanged<DateTime> onSelectedDate;
  final DateTime initialDate;

  const DateTimeDialog({
    required this.onSelectedDate,
    required this.initialDate,
    Key? key,
  }) : super(key: key);
  @override
  _DateTimeDialogState createState() => _DateTimeDialogState();
}

class _DateTimeDialogState extends State<DateTimeDialog> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();

    selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Select time',
              style: Theme.of(context).textTheme.title,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text(DateFormat('dd-MM-yyyy').format(selectedDate)),
                  onPressed: () async {
                    final date = await _selectDateTime(context,
                        initialDate: selectedDate);
                    if (date == null) return;

                    setState(() {
                      selectedDate = DateTime(
                        date.year,
                        date.month,
                        date.day,
                        selectedDate.hour,
                        selectedDate.minute,
                      );
                    });

                    widget.onSelectedDate(selectedDate);
                  },
                ),
                const SizedBox(width: 8),
                RaisedButton(
                  child: Text(DateFormat('HH:mm').format(selectedDate)),
                  onPressed: () async {
                    final time =
                        await _selectTime(context, initialDate: selectedDate);
                    if (time == null) return;

                    setState(() {
                      selectedDate = DateTime(
                        selectedDate.year,
                        selectedDate.month,
                        selectedDate.day,
                        time.hour,
                        time.minute,
                      );
                    });

                    widget.onSelectedDate(selectedDate);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            OutlineButton(
              color: Colors.purple[200],
              child: Text('Schedule!'),
              onPressed: () {
                Navigator.of(context).pop();
                showToast();
              },
              highlightColor: Colors.orange,
            ),
          ],
        ),
      );
}
