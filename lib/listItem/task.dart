import 'package:uuid/uuid.dart';

class Task {
  final bool isCompleted;
  final String text;
  final bool isFavorite;
  final String id;

  Task({required this.isCompleted, required this.text, required this.isFavorite}) : id = const Uuid().v4();
}
