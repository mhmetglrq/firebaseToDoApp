import 'dart:convert';

class NoteModel {
  String title;
  String uid;
  String note;
  String date;
  bool isPinned;
  NoteModel({
    required this.title,
    required this.uid,
    required this.note,
    required this.date,
    required this.isPinned,
  });

  NoteModel copyWith({
    String? title,
    String? uid,
    String? note,
    String? date,
    bool? isPinned,
  }) {
    return NoteModel(
      title: title ?? this.title,
      uid: uid ?? this.uid,
      note: note ?? this.note,
      date: date ?? this.date,
      isPinned: isPinned ?? this.isPinned,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'uid': uid,
      'note': note,
      'date': date,
      'isPinned': isPinned,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      title: map['title'] as String,
      uid: map['uid'] as String,
      note: map['note'] as String,
      date: map['date'] as String,
      isPinned: map['isPinned'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteModel.fromJson(String source) =>
      NoteModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NoteModel(title: $title, uid: $uid, note: $note, date: $date, isPinned: $isPinned)';
  }

  @override
  bool operator ==(covariant NoteModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.uid == uid &&
        other.note == note &&
        other.date == date &&
        other.isPinned == isPinned;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        uid.hashCode ^
        note.hashCode ^
        date.hashCode ^
        isPinned.hashCode;
  }
}
