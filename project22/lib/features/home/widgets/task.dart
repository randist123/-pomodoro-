enum TaskStatus { pending, inProgress, done }

class Task {
  final String id;
  final String title;
  final String description;
  final int durationMinutes;
  final DateTime date;
  final TaskStatus status;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.durationMinutes,
    required this.date,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'durationMinutes': durationMinutes,
      'date': date.toIso8601String(),
      'status': status.toString(),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      durationMinutes: map['durationMinutes'],
      date: DateTime.parse(map['date']),
      status: TaskStatus.values.firstWhere(
        (e) => e.toString() == map['status'],
        orElse: () => TaskStatus.pending,
      ),
    );
  }

  Task copyWith({
    String? id,
    String? title,
    String? description,
    int? durationMinutes,
    DateTime? date,
    TaskStatus? status,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      date: date ?? this.date,
      status: status ?? this.status,
    );
  }
}
