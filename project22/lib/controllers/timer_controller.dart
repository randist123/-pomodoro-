import 'dart:async';
import 'package:get/get.dart';
import 'package:project22/controllers/task_controller.dart';
import '../features/home/widgets/task.dart';

class TimerController extends GetxController {
  var remainingTime = 25.obs;
  var isRunning = false.obs;
  var isBreak = false.obs;
  var currentTask = Rxn<Task>();
  var sessionCount = 0.obs;

  Timer? _timer;

  void startTimer() {
    if (!isRunning.value) {
      isRunning.value = true;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (remainingTime.value > 0) {
          remainingTime.value--;
        } else {
          _timer?.cancel();
          isRunning.value = false;
          _onTimerComplete();
        }
      });
    }
  }

  void pauseTimer() {
    if (isRunning.value) {
      _timer?.cancel();
      isRunning.value = false;
    }
  }

  void resetTimer() {
    _timer?.cancel();
    isRunning.value = false;
    remainingTime.value = isBreak.value ? 300 : 25;
  }

  void toggleBreak() {
    _timer?.cancel();
    isRunning.value = false;
    isBreak.value = !isBreak.value;
    remainingTime.value = isBreak.value ? 300 : 25;
  }

  void setTask(Task task) {
    currentTask.value = task;
    remainingTime.value = 25;
    resetTimer();
  }

  void _onTimerComplete() {
    if (!isBreak.value) {
      sessionCount.value++;
      if (currentTask.value != null) {
        final taskController = Get.find<TaskController>();
        taskController.updateTaskStatus(
          currentTask.value!.id,
          TaskStatus.inProgress,
        );
      }
      if (sessionCount.value % 4 == 0) {
        isBreak.value = true;
        remainingTime.value = 1800;
        Get.snackbar(
          'Break Time!',
          'You have completed 4 tasks. Take a 30-minute break!',
          duration: const Duration(seconds: 5),
        );
      }
    } else {
      isBreak.value = false;
      Get.snackbar(
        'Break Finished!',
        'Time to get back to work!',
        duration: const Duration(seconds: 3),
      );
    }
  }

  String get formattedTime {
    final minutes = (remainingTime.value ~/ 60).toString().padLeft(2, '0');
    final seconds = (remainingTime.value % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
