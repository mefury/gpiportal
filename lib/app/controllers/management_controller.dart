import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:html' as html;
import 'dart:typed_data';
import '../models/management.dart';

class ManagementController extends GetxController {
  final RxList<Management> managementList = <Management>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isUploading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchManagement();
  }

  Future<void> fetchManagement() async {
    isLoading.value = true;
    try {
      final response = await Supabase.instance.client
          .from('management')
          .select()
          .order('position');
      
      managementList.value = (response as List<dynamic>)
          .map((json) => Management.fromJson(json))
          .toList();
    } catch (e) {
      print('Error fetching management: $e');
      Get.snackbar(
        'Error',
        'Failed to load management',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<String?> uploadImage(html.File file) async {
    try {
      isUploading.value = true;
      final fileName = '${DateTime.now().toIso8601String()}_${file.name}';
      final filePath = 'management_photos/$fileName';
      
      final reader = html.FileReader();
      reader.readAsArrayBuffer(file);
      await reader.onLoad.first;
      
      final bytes = Uint8List.fromList(reader.result as List<int>);
      
      await Supabase.instance.client.storage
          .from('management')
          .uploadBinary(filePath, bytes);
      
      return Supabase.instance.client.storage
          .from('management')
          .getPublicUrl('management_photos/$fileName');
    } catch (e) {
      print('Error uploading image: $e');
      Get.snackbar(
        'Error',
        'Failed to upload image',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
      );
      return null;
    } finally {
      isUploading.value = false;
    }
  }

  Future<void> addManagement(Map<String, dynamic> management) async {
    try {
      await Supabase.instance.client
          .from('management')
          .insert(management);
      Get.back();
      Get.snackbar(
        'Success',
        'Management member added successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade100,
        colorText: Colors.green.shade900,
      );
      fetchManagement();
    } catch (e) {
      print('Error adding management: $e');
      Get.snackbar(
        'Error',
        'Failed to add management member',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
      );
    }
  }

  Future<void> deleteManagement(String id, String? imageUrl) async {
    try {
      if (imageUrl != null) {
        final filePath = 'management_photos/${imageUrl.split('/').last}';
        await Supabase.instance.client.storage
            .from('management')
            .remove([filePath]);
      }
      
      await Supabase.instance.client
          .from('management')
          .delete()
          .match({'id': id});
          
      Get.snackbar(
        'Success',
        'Management member deleted successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade100,
        colorText: Colors.green.shade900,
      );
      fetchManagement();
    } catch (e) {
      print('Error deleting management: $e');
      Get.snackbar(
        'Error',
        'Failed to delete management member',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
      );
    }
  }
} 