import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:html' as html;
import 'dart:typed_data';
import '../models/instructor.dart';

class InstructorController extends GetxController {
  final RxList<Instructor> instructors = <Instructor>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isUploading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchInstructors();
  }

  Future<void> fetchInstructors() async {
    isLoading.value = true;
    try {
      final response = await Supabase.instance.client
          .from('instructors')
          .select()
          .order('name');
      
      instructors.value = (response as List<dynamic>)
          .map((json) => Instructor.fromJson(json))
          .toList();
    } catch (e) {
      print('Error fetching instructors: $e');
      Get.snackbar(
        'Error',
        'Failed to load instructors',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<String?> uploadImage(html.File file) async {
    try {
      isUploading.value = true;
      final fileName = '${DateTime.now().toIso8601String()}_${file.name}';
      final filePath = 'instructor_photos/$fileName';
      
      final reader = html.FileReader();
      reader.readAsArrayBuffer(file);
      await reader.onLoad.first;
      
      final bytes = Uint8List.fromList(reader.result as List<int>);
      
      await Supabase.instance.client.storage
          .from('instructors')
          .uploadBinary(filePath, bytes);
      
      return Supabase.instance.client.storage
          .from('instructors')
          .getPublicUrl('instructor_photos/$fileName');
    } catch (e) {
      print('Error uploading image: $e');
      Get.snackbar(
        'Error',
        'Failed to upload image',
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    } finally {
      isUploading.value = false;
    }
  }

  Future<void> addInstructor(Map<String, dynamic> instructor) async {
    isLoading.value = true;
    try {
      await Supabase.instance.client
          .from('instructors')
          .insert(instructor);
      Get.back();
      Get.snackbar(
        'Success',
        'Instructor added successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
      fetchInstructors();
    } catch (e) {
      print('Error adding instructor: $e');
      Get.snackbar(
        'Error',
        'Failed to add instructor',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteInstructor(String id, String? imageUrl) async {
    try {
      if (imageUrl != null) {
        final filePath = 'instructor_photos/${imageUrl.split('/').last}';
        await Supabase.instance.client.storage
            .from('instructors')
            .remove([filePath]);
      }
      
      await Supabase.instance.client
          .from('instructors')
          .delete()
          .match({'id': id});
          
      Get.snackbar(
        'Success',
        'Instructor deleted successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
      fetchInstructors();
    } catch (e) {
      print('Error deleting instructor: $e');
      Get.snackbar(
        'Error',
        'Failed to delete instructor',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
} 