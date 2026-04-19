import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project22/controllers/timer_controller.dart';
import 'package:project22/core/constant/constant.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final timerController = Get.find<TimerController>();

    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Obx(
            () => Text(
              timerController.isBreak.value ? 'Break Time' : 'Work Time',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Obx(
            () => Text(
              timerController.formattedTime,
              style: const TextStyle(
                fontSize: 72,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Obx(
            () => Text(
              timerController.currentTask.value != null
                  ? 'Task: ${timerController.currentTask.value!.title}'
                  : 'No task selected',
              style: const TextStyle(fontSize: 16, color: Colors.white70),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Obx(
                () => ElevatedButton(
                  onPressed: timerController.startTimer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: timerController.isRunning.value
                        ? Colors.grey
                        : success,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  child: const Text('Start'),
                ),
              ),
              Obx(
                () => ElevatedButton(
                  onPressed: timerController.pauseTimer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: timerController.isRunning.value
                        ? warning
                        : Colors.grey,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  child: const Text('Pause'),
                ),
              ),
              ElevatedButton(
                onPressed: timerController.resetTimer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: danger,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: const Text('Reset'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Obx(
            () => TextButton(
              onPressed: timerController.toggleBreak,
              child: Text(
                timerController.isBreak.value
                    ? 'Switch to Work'
                    : 'Switch to Break',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
