import 'package:get/get.dart';
import 'package:project22/controllers/timer_controller.dart';

class TimerWidgetController extends GetxController {
  var isExpanded = false.obs;

  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }

  void startTimer() {
    final timerController = Get.find<TimerController>();
    timerController.startTimer();
  }

  void pauseTimer() {
    final timerController = Get.find<TimerController>();
    timerController.pauseTimer();
  }

  void resetTimer() {
    final timerController = Get.find<TimerController>();
    timerController.resetTimer();
  }

  void toggleBreak() {
    final timerController = Get.find<TimerController>();
    timerController.toggleBreak();
  }
}
