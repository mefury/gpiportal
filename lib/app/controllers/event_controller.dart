import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:html' as html;
import '../models/event.dart';
import 'dart:typed_data';

class EventController extends GetxController {
  final RxList<Event> events = <Event>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isUploading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    isLoading.value = true;
    try {
      final response = await Supabase.instance.client
          .from('events')
          .select()
          .order('date_time', ascending: true);
      
      events.value = (response as List<dynamic>)
          .map((json) => Event.fromJson(json))
          .toList();
    } catch (e) {
      print('Error fetching events: $e');
      Get.snackbar(
        'Error',
        'Failed to load events',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<String?> uploadWebImage(html.File file) async {
    try {
      isUploading.value = true;
      final fileName = '${DateTime.now().toIso8601String()}_${file.name}';
      final filePath = 'event_banners/$fileName';
      
      final reader = html.FileReader();
      reader.readAsArrayBuffer(file);
      await reader.onLoad.first;
      
      final bytes = Uint8List.fromList(reader.result as List<int>);
      
      await Supabase.instance.client.storage
          .from('events')
          .uploadBinary(filePath, bytes);
      
      return Supabase.instance.client.storage
          .from('events')
          .getPublicUrl('event_banners/$fileName');
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

  Future<void> addEvent(Map<String, dynamic> event) async {
    isLoading.value = true;
    try {
      await Supabase.instance.client
          .from('events')
          .insert(event);
      Get.back();
      Get.snackbar(
        'Success',
        'Event added successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
      fetchEvents();
    } catch (e) {
      print('Error adding event: $e');
      Get.snackbar(
        'Error',
        'Failed to add event',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteEvent(String id, String? imageUrl) async {
    try {
      // Delete image if exists
      if (imageUrl != null) {
        final filePath = 'event_banners/${imageUrl.split('/').last}';
        await Supabase.instance.client.storage
            .from('events')
            .remove([filePath]);
      }
      
      // Delete event
      await Supabase.instance.client
          .from('events')
          .delete()
          .match({'id': id});
          
      Get.snackbar(
        'Success',
        'Event deleted successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
      fetchEvents();
    } catch (e) {
      print('Error deleting event: $e');
      Get.snackbar(
        'Error',
        'Failed to delete event',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
} 