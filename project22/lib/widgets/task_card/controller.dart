import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project22/controllers/task_controller.dart';
import 'package:project22/features/home/widgets/task.dart';
import 'package:project22/core/constant/constant.dart';

class TaskCardController extends GetxController {
  void updateTaskStatus(String taskId, TaskStatus status) {
    final taskController = Get.find<TaskController>();
    taskController.updateTaskStatus(taskId, status);
  }

  void selectTask(Task task) {
    final taskController = Get.find<TaskController>();
    taskController.selectTask(task);
  }

  void deleteTask(String taskId) {
    final taskController = Get.find<TaskController>();
    taskController.removeTask(taskId);
  }

  Color getStatusColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.pending:
        return warning;
      case TaskStatus.inProgress:
        return accent;
      case TaskStatus.done:
        return success;
    }
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
}
