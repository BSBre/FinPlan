import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:finplan/authentication/user_auth.dart';
import 'package:finplan/config/models/alertDialog_model.dart';
import 'package:finplan/config/models/custom_form_field.dart';
import 'package:finplan/config/models/notification_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:finplan/values/constants.dart';
import 'package:finplan/services/FirebaseApi.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class Event {
  final String title;

  Event({required this.title});

  String toString() => this.title;
}

class _CalendarPageState extends State<CalendarPage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  final user = FirebaseAuth.instance;

  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animationController.forward();
    AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) {
        if (!isAllowed) {
          showAlertFunction(
            buildContext: context,
            title: "notification_title".tr(),
            message:"notification_description".tr(),
            closingText: "close".tr(),
            affirmativeText: "send".tr(),
            onPressedFunction:(){ AwesomeNotifications().requestPermissionToSendNotifications();}
          );
        }
      },
    );
    AwesomeNotifications().createdStream.listen(
      (notification) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${titleController.text} notification created"),
          ),
        );
        Navigator.of(context).pop();
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    AwesomeNotifications().createdSink.close();
    super.dispose();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: FinPlanColor),
        title: Text(
          "calendar_title".tr(),
          style: TextStyle(color: FinPlanColor),


        ).tr(),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          RawMaterialButton(
            onPressed: () {
              _addNewEventBottomSheet(context);
              print(user.currentUser?.tenantId);
              print(user.currentUser?.uid);
              print(user.currentUser);
              print(user.currentUser?.displayName);

            },
            child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(color: FinPlanColor, borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Icon(
                  Icons.add,
                  size: 25,
                  color: Colors.white,
                )),
          )
        ],
      ),
      body: Column(
        children: [
          TableCalendar(
            calendarBuilders: CalendarBuilders(
              selectedBuilder: (context, date, _) {
                return FadeTransition(
                  opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: FinPlanColor,
                    ),
                    margin: const EdgeInsets.all(4.0),
                    padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                    width: 80,
                    height: 80,
                    child: Text(
                      '${date.day}',
                      style: TextStyle().copyWith(fontSize: 16.0),
                    ),
                  ),
                );
              },
              todayBuilder: (context, date, _) {
                return Container(
                  margin: const EdgeInsets.all(4.0),
                  padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: FinPlanComplimentaryColor,
                  ),
                  width: 80,
                  height: 80,
                  child: Text(
                    '${date.day}',
                    style: TextStyle().copyWith(fontSize: 16.0),
                  ),
                );
              },
            ),
            availableCalendarFormats: {CalendarFormat.month: "Month"},
            availableGestures: AvailableGestures.all,
            onFormatChanged: null,
            calendarFormat: CalendarFormat.month,
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 1, 1),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                shape: BoxShape.rectangle,
                color: FinPlanComplimentaryColor,
              ),
              markerDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                shape: BoxShape.circle,
                color: FinPlanColor,
              ),
              selectedDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                shape: BoxShape.rectangle,
                color: FinPlanColor,
              ),
              outsideDaysVisible: false,
            ),
            headerStyle: HeaderStyle(
              formatButtonTextStyle: TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
              formatButtonDecoration: BoxDecoration(
                color: FinPlanComplimentaryColor,
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            onDaySelected: _onDaySelected,
          ),
          const SizedBox(height: 8.0),
          // Expanded(
          //   // child: _buildEventList(),
          // ),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }

  void _addNewEventBottomSheet(BuildContext context) {
    TextEditingController descriptionController = TextEditingController();
    TextEditingController dateinput = TextEditingController();
    TextEditingController timeInput = TextEditingController();
    dateinput.text = "";
    timeInput.text = "";

    DateTime? pickedDate;

    int? selectedHour = 0;
    int? selectedMinute = 0;
    int? selectedYear = 0;
    int? selectedMonth = 0;
    int? selectedDay = 0;
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext bc) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 24,
              ),
              Center(
                child: Text(
                  "add_notification".tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: FinPlanColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: TextField(
                  controller: dateinput,
                  decoration: InputDecoration(
                      focusColor: FinPlanColor,
                      prefixIconColor: FinPlanColor,
                      fillColor: FinPlanColor,
                      icon: Icon(Icons.calendar_today),
                      labelText: "enter_date".tr()),
                  readOnly: true,
                  onTap: () async {
                    pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );

                    if (pickedDate != null) {
                      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate!);
                      selectedYear = pickedDate?.year;
                      selectedDay = pickedDate?.day;
                      selectedMonth = pickedDate?.month;

                      setState(() {
                        dateinput.text = formattedDate;
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: CustomFormField(
                      fillColor: FinPlanColor,
                      controller: titleController,
                      labelText: "title".tr(),
                      prefixIcon: Icon(
                        Icons.title,
                        color: FinPlanColor,
                        size: 18,
                      ),
                      hintText: "title".tr(),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: CustomFormField(
                      fillColor: FinPlanColor,
                      controller: descriptionController,
                      labelText: "description".tr(),
                      prefixIcon: Icon(
                        Icons.title,
                        color: FinPlanColor,
                        size: 18,
                      ),
                      hintText: "description".tr(),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                child: TextField(
                  controller: timeInput,
                  decoration: InputDecoration(fillColor: FinPlanColor, icon: Icon(Icons.access_alarm), labelText: "Enter the time"),
                  readOnly: true,
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                    );

                    selectedHour = pickedTime?.hour;
                    selectedMinute = pickedTime?.minute;
                    if (pickedTime?.hour == 0) {
                      timeInput.text = "${pickedTime?.hour}0:${pickedTime?.minute}";
                    } else if (pickedTime?.minute == 0) {
                      timeInput.text = "${pickedTime?.hour}:0${pickedTime?.minute}";
                    } else {
                      timeInput.text = "${pickedTime?.hour}:${pickedTime?.minute}";
                    }
                  },
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                height: 60,
                child: RawMaterialButton(
                  onPressed: () {
                    createRemainderNotification(
                        title: titleController.text,
                        description: descriptionController.text,
                        selectedHour: selectedHour,
                        selectedMinute: selectedMinute,
                        selectedYear: selectedYear,
                        selectedMonth: selectedMonth,
                        selectedDay: selectedDay);
                    DateTime dateForApi = DateTime(selectedYear!, selectedMonth!, selectedDay!, selectedHour!, selectedMinute!);
                    FirebaseApi.createNotification(
                      notificationTitle: titleController.text,
                      dateCreated: DateTime.now(),
                      notificationDescription: descriptionController.text,
                      userId: user.currentUser?.uid,
                      dateSelected: dateForApi,
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      color: FinPlanColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "Create a notification",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        );
      },
    );
  }
}
