// ignore_for_file: depend_on_referenced_packages, avoid_print, duplicate_ignore, prefer_adjacent_string_concatenation

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:rhd_todolist/ui/notified_page.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../models/task.dart';

class NotifyHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin(); //

  initializeNotification() async {
    _configureLocalTimezone();
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            requestSoundPermission: false,
            requestBadgePermission: false,
            requestAlertPermission: false,
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('appicon');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      iOS: initializationSettingsIOS,
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future selectNotification(String? payload) async {
    if (payload != null) {
      // ignore: avoid_print
      print('notification payload: $payload');
    } else {
      // ignore: avoid_print
      print("Notification Done");
    }

    if (payload == "Theme Changed") {
      print("Nothing navigate to");
    } else {
      Get.to(() => NotifiedPage(label: payload));
    }
  }

  displayNotification({required String title, required String body}) async {
    // ignore: avoid_print
    print("doing test");
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'your channel id', 'your channel name',
        importance: Importance.max, priority: Priority.high, icon: 'appicon');
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: title,
    );
  }

  scheduledNotification(int hour, int minutes, Task task) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        task.id!.toInt(),
        task.title,
        task.note,
        _convertTime(hour, minutes),
        // tz.TZDateTime.now(tz.local)  
        //     .add(const Duration(days: 0, minutes: 0, seconds: 5)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'your channel id', 'your channel name')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: "${task.title}|" + "${task.note}|");
  }

  tz.TZDateTime _convertTime(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    return scheduleDate;
  }

  Future<void> _configureLocalTimezone() async {
    tz.initializeTimeZones();
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title!),
        content: Text(body!),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Container(
                    color: Colors.white,
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
