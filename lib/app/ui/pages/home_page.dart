import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controllers/theme_controller.dart';
import '../../routes/app_pages.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;
    final buttonPadding = size.width * 0.04; // 4% of screen width
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Obx(() => Icon(
            themeController.isDarkMode 
                ? Icons.light_mode 
                : Icons.dark_mode,
          )),
          onPressed: themeController.toggleTheme,
        ),
        title: const Text(
          'GPI PORTAL',
          style: TextStyle(
            letterSpacing: 1.2,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await Supabase.instance.client.auth.signOut();
              Get.offAllNamed(Routes.LOGIN);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).colorScheme.background,
                    Theme.of(context).colorScheme.background.withOpacity(0.8),
                  ],
                ),
              ),
              child: GridView.count(
                crossAxisCount: size.width < 600 ? 2 : 3, // 3 columns for larger screens
                padding: EdgeInsets.all(buttonPadding),
                mainAxisSpacing: buttonPadding,
                crossAxisSpacing: buttonPadding,
                childAspectRatio: 1.1, // Make buttons slightly taller than wide
                children: [
                  _buildMenuButton(
                    context,
                    icon: Icons.announcement,
                    label: 'Announcements',
                    onTap: () => Get.toNamed(Routes.ANNOUNCEMENTS),
                    isSmallScreen: isSmallScreen,
                  ),
                  _buildMenuButton(
                    context,
                    icon: Icons.calendar_today,
                    label: 'Class Routine',
                    onTap: () => Get.toNamed('/class-routine'),
                    isSmallScreen: isSmallScreen,
                  ),
                  _buildMenuButton(
                    context,
                    icon: Icons.event,
                    label: 'Events',
                    onTap: () => Get.toNamed('/events'),
                    isSmallScreen: isSmallScreen,
                  ),
                  _buildMenuButton(
                    context,
                    icon: Icons.people,
                    label: 'Instructors',
                    onTap: () => Get.toNamed('/instructors'),
                    isSmallScreen: isSmallScreen,
                  ),
                  _buildMenuButton(
                    context,
                    icon: Icons.school,
                    label: 'Admission',
                    onTap: () => Get.toNamed('/admission'),
                    isSmallScreen: isSmallScreen,
                  ),
                  _buildMenuButton(
                    context,
                    icon: Icons.info,
                    label: 'About',
                    onTap: () => Get.toNamed('/about'),
                    isSmallScreen: isSmallScreen,
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0, -4),
                  blurRadius: 16,
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  'Greenland Polytechnic Institute',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  'Institute code: 50454 EIIN:139610',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialButton(
                      context,
                      icon: Icons.facebook,
                      onTap: () => _launchUrl('https://www.facebook.com/GreenlandPolytechnicInstitute/'),
                    ),
                    const SizedBox(width: 24),
                    _buildSocialButton(
                      context,
                      icon: Icons.language,
                      onTap: () => _launchUrl('https://www.greenlandpolytechnic.com/'),
                    ),
                    const SizedBox(width: 24),
                    _buildSocialButton(
                      context,
                      icon: Icons.location_on,
                      onTap: () => _launchUrl('https://maps.app.goo.gl/7oqNwPzcC6MoDunNA'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required bool isSmallScreen,
  }) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).cardTheme.color!,
                Theme.of(context).cardTheme.color!.withOpacity(0.95),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(isSmallScreen ? 12 : 14),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon, 
                  size: isSmallScreen ? 32 : 36,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: isSmallScreen ? 12 : 14),
              Text(
                label, 
                style: TextStyle(
                  fontSize: isSmallScreen ? 14 : 15,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          ),
          child: Icon(
            icon,
            size: 28,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
} 