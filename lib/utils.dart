import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Utils {
  static void showSnackBar(BuildContext context, String text) =>
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(text)));

  //transfer it back to the date time object
  static DateTime toDateTime(Timestamp value) {
    if (value == null) return null!;
    return value.toDate();
  }

  //To transfer a date time to json
  static dynamic fromDateTimeToJson(DateTime date) {
    if (date == null) return null;
    return date.toUtc();
  }

  // static StreamTransformer<QuerySnapshot<Map<String, dynamic>> transformer<T>(

  //         T Function(Map<String, dynamic> json) fromJson) =>
  //     StreamTransformer<QuerySnapshot, List<T>>.fromHandlers(
  //       handleData: (QuerySnapshot data, EventSink<List<T>> sink) {
  //         final snaps = data.docs.map((doc) => doc.data()).toList();
  //         final objects = snaps.map((json) => fromJson(j)).toList();

  //         sink.add(objects);
  //       },
  //     );


}
