import 'package:flutter/material.dart';
import '../services/gender_info_storage_service.dart';
import '../services/parent_tip_storage_service.dart';
import '../services/story_storage_service.dart';
import '../services/test_storage_service.dart';
import '../services/who_am_i_storage_service.dart';
import '../theme/app_theme.dart';
import 'admin_login_screen.dart';

class AdminSettingsScreen extends StatefulWidget {
  const AdminSettingsScreen({super.key});

  @override
  State<AdminSettingsScreen> createState() => _AdminSettingsScreenState();
}

class _AdminSettingsScreenState extends State<AdminSettingsScreen> {
  bool isLoading = false;

  Future<void> resetAllData() async {
    setState(() {
      isLoading = true;
    });

    await StoryStorageService.clearStories();
    await ParentTipStorageService.clearTips();
    await GenderInfoStorageService.clearGenderInfos();
    await WhoAmIStorageService.resetAll();
    await TestStorageService.resetTest(1);
    await TestStorageService.resetTest(2);
    await TestStorageService.resetTest(3);

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Barcha ma'lumotlar default holatga qaytarildi"),
      ),
    );
  }

  Future<void> confirmReset() async {
    final result = await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Tasdiqlash"),
        content: const Text(
            "Haqiqatan ham barcha ma'lumotlarni defaultga qaytarmoqchimisiz?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text("Yo‘q"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Text("Ha"),
          ),
        ],
      ),
    );

    if (result == true) {
      resetAllData();
    }
  }

  Future<void> confirmLogout() async {
    final result = await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Admin paneldan chiqmoqchimisiz?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text("Yo‘q"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Text("Ha"),
          ),
        ],
      ),
    );

    if (result == true && mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const AdminLoginScreen(),
        ),
            (route) => false,
      );
    }
  }

  Widget buildCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required List<Color> colors,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
          ),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Settings"),
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              buildCard(
                icon: Icons.restore,
                title: "Defaultga qaytarish",
                subtitle:
                "Barcha ertaklar, testlar va boshqa ma'lumotlarni reset qilish",
                colors: const [
                  Color(0xFF6C63FF),
                  Color(0xFF9A8CFF),
                ],
                onTap: confirmReset,
              ),
              buildCard(
                icon: Icons.logout,
                title: "Logout",
                subtitle: "Admin paneldan chiqish",
                colors: const [
                  Color(0xFFFF8A65),
                  Color(0xFFFFC371),
                ],
                onTap: confirmLogout,
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                    )
                  ],
                ),
                child: const Row(
                  children: [
                    Icon(Icons.info_outline, color: AppTheme.primaryColor),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Defaultga qaytarish barcha admin o‘zgartirishlarini o‘chiradi.",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textDark,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.2),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
        ],
      ),
    );
  }
}