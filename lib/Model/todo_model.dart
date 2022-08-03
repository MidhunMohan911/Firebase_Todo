import 'package:todo_firebase/utils.dart';

class TodoField {
  static const createdTime = 'createTime';
}

class Todo {
  DateTime createdTime;
  String title;
  String id;
  String discription;
  bool isDone;
  Todo(
      {required this.createdTime,
      required this.title,
      this.discription = '',
      this.id = '',
      this.isDone = false});

  static Todo fromJson(Map<String, dynamic> json) => Todo(
      createdTime: Utils.toDateTime(json['createdTime']),
      title: json['title'],
      discription: json['discription'],
      id: json['id'],
      isDone: json['isDone']);

  Map<String, dynamic> toJson() => {
        'createdTime': Utils.fromDateTimeToJson(createdTime),
        'title': title,
        'discription': discription,
        'id': id,
        'isDone': isDone
      };
}
