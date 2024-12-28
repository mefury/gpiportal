import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/announcement.dart';

class AnnouncementController extends GetxController {
  final RxList<Announcement> announcements = <Announcement>[].obs;
  final RxBool isLoading = false.obs;
  RealtimeChannel? _subscription;

  @override
  void onInit() {
    super.onInit();
    fetchAnnouncements();
    _setupSubscription();
  }

  @override
  void onClose() {
    _subscription?.unsubscribe();
    super.onClose();
  }

  Future<void> fetchAnnouncements() async {
    try {
      final response = await Supabase.instance.client
          .from('announcements')
          .select()
          .order('timestamp', ascending: false);
      
      announcements.value = (response as List)
          .map((json) => Announcement.fromJson(json))
          .toList();
    } catch (e) {
      print('Error fetching announcements: $e');
      Get.snackbar(
        'Error',
        'Failed to load announcements',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void _setupSubscription() {
    _subscription = Supabase.instance.client
        .channel('public:announcements')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'announcements',
          callback: (payload) {
            fetchAnnouncements(); // Refresh the list when changes occur
          },
        )
        .subscribe();
  }

  Future<void> addAnnouncement(Map<String, dynamic> announcement) async {
    isLoading.value = true;
    try {
      await Supabase.instance.client
          .from('announcements')
          .insert(announcement);
      Get.back();
      Get.snackbar(
        'Success',
        'Announcement added successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print('Error adding announcement: $e');
      Get.snackbar(
        'Error',
        'Failed to add announcement',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteAnnouncement(String id) async {
    try {
      await Supabase.instance.client
          .from('announcements')
          .delete()
          .match({'id': id});
      Get.snackbar(
        'Success',
        'Announcement deleted successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print('Error deleting announcement: $e');
      Get.snackbar(
        'Error',
        'Failed to delete announcement',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
} 