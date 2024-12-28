import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/routine.dart';

class RoutineController extends GetxController {
  static final List<String> departments = [
    'Computer',
    'Electrical',
    'Civil',
    'Mechanical',
    'Automobile'
  ];

  static final List<String> semesters = [
    '1st',
    '2nd',
    '3rd',
    '4th',
    '5th',
    '6th',
    '7th',
    '8th',
  ];

  static final List<String> days = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
  ];

  final RxString selectedDepartment = departments.first.obs;
  final RxString selectedSemester = semesters.first.obs;
  final RxString selectedDay = days.first.obs;
  final RxList<Routine> routines = <Routine>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRoutines();
  }

  Future<void> fetchRoutines() async {
    isLoading.value = true;
    try {
      final response = await Supabase.instance.client
          .from('routines')
          .select()
          .eq('department', selectedDepartment.value)
          .eq('semester', selectedSemester.value)
          .eq('day', selectedDay.value)
          .order('period_no');

      routines.value = (response as List<dynamic>)
          .map((json) => Routine.fromJson(json))
          .toList();
    } catch (e) {
      print('Error fetching routines: $e');
      Get.snackbar(
        'Error',
        'Failed to load routines',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addRoutine(Map<String, dynamic> routine) async {
    try {
      // Check for existing class
      final existing = await Supabase.instance.client
          .from('routines')
          .select()
          .eq('department', routine['department'])
          .eq('semester', routine['semester'])
          .eq('day', routine['day'])
          .eq('period_no', routine['period_no']);

      if ((existing as List).isNotEmpty) {
        Get.snackbar(
          'Error',
          'A class already exists in this time slot',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade100,
          colorText: Colors.red.shade900,
          duration: const Duration(seconds: 3),
        );
        return;
      }

      await Supabase.instance.client
          .from('routines')
          .insert(routine);
      
      Get.back();
      Get.snackbar(
        'Success',
        'Class added successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade100,
        colorText: Colors.green.shade900,
      );
      fetchRoutines();
    } catch (e) {
      print('Error adding routine: $e');
      Get.snackbar(
        'Error',
        'Failed to add class: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
      );
    }
  }

  Future<void> deleteRoutine(String id) async {
    try {
      await Supabase.instance.client
          .from('routines')
          .delete()
          .match({'id': id});
          
      Get.snackbar(
        'Success',
        'Class deleted successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade100,
        colorText: Colors.green.shade900,
      );
      fetchRoutines();
    } catch (e) {
      print('Error deleting routine: $e');
      Get.snackbar(
        'Error',
        'Failed to delete class',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
      );
    }
  }
} 