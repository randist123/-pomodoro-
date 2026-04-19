import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project22/features/home/widgets/task.dart';

class TaskFormController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final durationController = TextEditingController();
  var selectedDate = DateTime.now().obs;
  var selectedStatus = TaskStatus.pending.obs;

  void clearForm() {
    titleController.clear();
    descriptionController.clear();
    durationController.clear();
    selectedDate.value = DateTime.now();
    selectedStatus.value = TaskStatus.pending;
  }

  void setDate(DateTime date) {
    selectedDate.value = date;
  }

  void setStatus(TaskStatus status) {
    selectedStatus.value = status;
  }

  String getStatusText(TaskStatus status) {
    switch (status) {
      case TaskStatus.pending:
        return 'Pending';
      case TaskStatus.inProgress:
        return 'In Progress';
      case TaskStatus.done:
        return 'Done';
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    durationController.dispose();
    super.onClose();
  }
}
