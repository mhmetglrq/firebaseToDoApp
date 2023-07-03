
import 'dart:convert';

class ScheduleModel {
  String uid;
  String title;
  bool allDay;
  DateTime startTime;
  DateTime finishTime;
  String location;
  String note;
  bool isHappened;
  ScheduleModel({
    required this.uid,
    required this.title,
    required this.allDay,
    required this.startTime,
    required this.finishTime,
    required this.location,
    required this.note,
    required this.isHappened,
  });

  ScheduleModel copyWith({
    String? uid,
    String? title,
    bool? allDay,
    DateTime? startTime,
    DateTime? finishTime,
    String? location,
    String? note,
    bool? isHappened,
  }) {
    return ScheduleModel(
      uid: uid ?? this.uid,
      title: title ?? this.title,
      allDay: allDay ?? this.allDay,
      startTime: startTime ?? this.startTime,
      finishTime: finishTime ?? this.finishTime,
      location: location ?? this.location,
      note: note ?? this.note,
      isHappened: isHappened ?? this.isHappened,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'title': title,
      'allDay': allDay,
      'startTime': startTime.millisecondsSinceEpoch,
      'finishTime': finishTime.millisecondsSinceEpoch,
      'location': location,
      'note': note,
      'isHappened': isHappened,
    };
  }

  factory ScheduleModel.fromMap(Map<String, dynamic> map) {
    return ScheduleModel(
      uid: map['uid'] as String,
      title: map['title'] as String,
      allDay: map['allDay'] as bool,
      startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime'] as int),
      finishTime: DateTime.fromMillisecondsSinceEpoch(map['finishTime'] as int),
      location: map['location'] as String,
      note: map['note'] as String,
      isHappened: map['isHappened'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ScheduleModel.fromJson(String source) =>
      ScheduleModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ScheduleModel(uid: $uid, title: $title, allDay: $allDay, startTime: $startTime, finishTime: $finishTime, location: $location, note: $note, isHappened: $isHappened)';
  }

  @override
  bool operator ==(covariant ScheduleModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.title == title &&
        other.allDay == allDay &&
        other.startTime == startTime &&
        other.finishTime == finishTime &&
        other.location == location &&
        other.note == note &&
        other.isHappened == isHappened;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        title.hashCode ^
        allDay.hashCode ^
        startTime.hashCode ^
        finishTime.hashCode ^
        location.hashCode ^
        note.hashCode ^
        isHappened.hashCode;
  }
}
