import 'package:get/get.dart';
import '../features/home/widgets/task.dart';
import 'timer_controller.dart';

class TaskController extends GetxController {
  var tasks = <Task>[].obs;
  var selectedTask = Rxn<Task>();

  void addTask(Task task) {
    tasks.add(task);
  }

  void removeTask(String taskId) {
    tasks.removeWhere((task) => task.id == taskId);
  }

  void updateTask(Task task) {
    
    final index = tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      tasks[index] = task;
    }
  }

  void updateTaskStatus(String taskId, TaskStatus status) {
    final index = tasks.indexWhere((task) => task.id == taskId);
    if (index != -1) {
      tasks[index] = tasks[index].copyWith(status: status);
    }
  }

  void selectTask(Task task) {
    selectedTask.value = task;
    final timerController = Get.find<TimerController>();
    timerController.setTask(task);
  }

  List<Task> getTasksByStatus(TaskStatus status) {
    return tasks.where((task) => task.status == status).toList();
  }

  List<Task> get pendingTasks => getTasksByStatus(TaskStatus.pending);
  List<Task> get inProgressTasks => getTasksByStatus(TaskStatus.inProgress);
  List<Task> get completedTasks => getTasksByStatus(TaskStatus.done);
}
