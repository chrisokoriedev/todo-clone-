class Task {
  int id;
  String title;
  DateTime date;
  String priority;
  int status; // status will always be 0 if the task is incomplete, 1-when complete
  Task({this.title, this.date, this.priority, this.status});

  Task.withId({this.id, this.title, this.date, this.priority, this.status});

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['title'] = title;
    map['date'] = date.toIso8601String();
    map['priority'] = priority;
    map['status'] = status;
    return map;
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task.withId(
        id: map['id'],
        title: map['title'],
        date: DateTime.parse(map['map']),
        priority: map['priority'],
        status: map['status']);
  }
}
