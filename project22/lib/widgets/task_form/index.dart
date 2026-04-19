import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project22/controllers/task_controller.dart';
import 'package:project22/features/home/widgets/task.dart';
import 'package:project22/core/constant/constant.dart';
import 'controller.dart';

class TaskFormWidget extends StatelessWidget {
  const TaskFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TaskFormController());
    final taskController = Get.find<TaskController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
        backgroundColor: primary,
        foregroundColor: Colors.white,
      ),
      backgroundColor: background,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: controller.titleController,
                decoration: InputDecoration(
                  labelText: 'Task Title',
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  labelStyle: const TextStyle(color: primary),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: accent, width: 2),
                  ),
                ),
                style: const TextStyle(color: primary),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a task title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.descriptionController,
                decoration: InputDecoration(
                  labelText: 'Task Description (Optional)',
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  labelStyle: const TextStyle(color: primary),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: accent, width: 2),
                  ),
                ),
                style: const TextStyle(color: primary),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.durationController,
                decoration: InputDecoration(
                  labelText: 'Expected Duration (Minutes)',
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  labelStyle: const TextStyle(color: primary),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: accent, width: 2),
                  ),
                ),
                style: const TextStyle(color: primary),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter duration';
                  }
                  final duration = int.tryParse(value);
                  if (duration == null || duration <= 0) {
                    return 'Please enter a valid duration';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Obx(
                () => ListTile(
                  title: const Text('Task Date'),
                  subtitle: Text(
                    '${controller.selectedDate.value.day}/${controller.selectedDate.value.month}/${controller.selectedDate.value.year}',
                  ),
                  trailing: const Icon(Icons.calendar_today),
                  tileColor: Colors.white,
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: controller.selectedDate.value,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (picked != null) {
                      controller.setDate(picked);
                    }
                  },
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => DropdownButtonFormField<TaskStatus>(
                  initialValue: controller.selectedStatus.value,
                  decoration: InputDecoration(
                    labelText: 'Status',
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  items: TaskStatus.values.map((status) {
                    return DropdownMenuItem(
                      value: status,
                      child: Text(controller.getStatusText(status)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      controller.setStatus(value);
                    }
                  },
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (controller.formKey.currentState!.validate()) {
                    final task = Task(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      title: controller.titleController.text,
                      description: controller.descriptionController.text,
                      durationMinutes: int.parse(
                        controller.durationController.text,
                      ),
                      date: controller.selectedDate.value,
                      status: controller.selectedStatus.value,
                    );
                    taskController.addTask(task);
                    controller.clearForm();
                    Get.back();
                    Get.snackbar(
                      'Success',
                      'Task added successfully',
                      backgroundColor: success,
                      colorText: Colors.white,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  minimumSize: const Size(double.infinity, 0),
                ),
                child: const Text('Save Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
