import 'package:get/get.dart';
import '../ui/pages/home_page.dart';
import '../ui/pages/login_page.dart';
import '../ui/pages/announcements_page.dart';
import '../ui/pages/class_routine_page.dart';
import '../ui/pages/events_page.dart';
import '../ui/pages/instructors_page.dart';
import '../ui/pages/admission_page.dart';
import '../ui/pages/about_page.dart';

part 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomePage(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: Routes.ANNOUNCEMENTS,
      page: () => const AnnouncementsPage(),
    ),
    GetPage(
      name: Routes.CLASS_ROUTINE,
      page: () => const ClassRoutinePage(),
    ),
    GetPage(
      name: Routes.EVENTS,
      page: () => const EventsPage(),
    ),
    GetPage(
      name: Routes.INSTRUCTORS,
      page: () => const InstructorsPage(),
    ),
    GetPage(
      name: Routes.ADMISSION,
      page: () => const AdmissionPage(),
    ),
    GetPage(
      name: Routes.ABOUT,
      page: () => const AboutPage(),
    ),
  ];
} 