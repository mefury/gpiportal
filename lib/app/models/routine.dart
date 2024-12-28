class Routine {
  final String id;
  final String department;
  final String semester;
  final String day;
  final String subject;
  final String teacher;
  final String roomNo;
  final String startTime;
  final String endTime;
  final int periodNo;

  Routine({
    required this.id,
    required this.department,
    required this.semester,
    required this.day,
    required this.subject,
    required this.teacher,
    required this.roomNo,
    required this.startTime,
    required this.endTime,
    required this.periodNo,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'department': department,
    'semester': semester,
    'day': day,
    'subject': subject,
    'teacher': teacher,
    'room_no': roomNo,
    'start_time': startTime,
    'end_time': endTime,
    'period_no': periodNo,
  };

  factory Routine.fromJson(Map<String, dynamic> json) => Routine(
    id: json['id'],
    department: json['department'],
    semester: json['semester'],
    day: json['day'],
    subject: json['subject'],
    teacher: json['teacher'],
    roomNo: json['room_no'],
    startTime: json['start_time'],
    endTime: json['end_time'],
    periodNo: json['period_no'],
  );
} 