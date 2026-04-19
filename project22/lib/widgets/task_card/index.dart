import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project22/features/home/widgets/task.dart';
import 'package:project22/core/constant/constant.dart';
import 'package:project22/controllers/timer_controller.dart';
import 'controller.dart';

class TaskCardWidget extends StatelessWidget {
  final Task task;

  const TaskCardWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final cardController = Get.put(TaskCardController());

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: Colors.white,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: cardController.getStatusColor(task.status),
          child: Icon(
            task.status == TaskStatus.done ? Icons.check : Icons.pending,
            color: Colors.white,
          ),
        ),
        title: Text(
          task.title,
          style: const TextStyle(fontWeight: FontWeight.bold, color: primary),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.description, style: const TextStyle(color: primary)),
            const SizedBox(height: 4),
            Text(
              '${task.date.day}/${task.date.month}/${task.date.year} • ${task.durationMinutes} min',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.play_arrow, color: accent),
              onPressed: () {
                cardController.selectTask(task);
                final timerController = Get.find<TimerController>();
                timerController.setTask(task);
                timerController.startTimer();
              },
            ),
            IconButton(
              icon: Icon(Icons.delete, color: danger),
              onPressed: () {
                final timerController = Get.find<TimerController>();
                if (timerController.currentTask.value?.id == task.id) {
                  timerController.pauseTimer();
                  timerController.resetTimer();
                }
                cardController.deleteTask(task.id);
              },
            ),
            PopupMenuButton<TaskStatus>(
              icon: Icon(
                Icons.more_vert,
                color: cardController.getStatusColor(task.status),
              ),
              onSelected: (status) {
                cardController.updateTaskStatus(task.id, status);
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: TaskStatus.pending,
                  child: Row(
                    children: [
                      Icon(Icons.pending, color: warning),
                      const SizedBox(width: 8),
                      const Text('Pending'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: TaskStatus.inProgress,
                  child: Row(
                    children: [
                      Icon(Icons.play_arrow, color: accent),
                      const SizedBox(width: 8),
                      const Text('In Progress'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: TaskStatus.done,
                  child: Row(
                    children: [
                      Icon(Icons.check, color: success),
                      const SizedBox(width: 8),
                      const Text('Done'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        onTap: () {
          cardController.selectTask(task);
        },
      ),
    );
  }
}
