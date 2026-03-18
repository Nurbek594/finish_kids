import 'dart:io';
import 'package:flutter/material.dart';
import '../models/gender_gallery_image_model.dart';
import '../services/gender_gallery_storage_service.dart';
import '../data/gender_gallery_default_data.dart';
import '../theme/app_theme.dart';

class GenderGalleryScreen extends StatefulWidget {
  const GenderGalleryScreen({super.key});

  @override
  State<GenderGalleryScreen> createState() => _GenderGalleryScreenState();
}

class _GenderGalleryScreenState extends State<GenderGalleryScreen> {
  List<GenderGalleryImageModel> images = [];
  bool isLoading = true;
  int currentPage = 0;

  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.90);
    _loadImages();
  }

  Future<void> _loadImages() async {
    final saved = await GenderGalleryStorageService.loadImages();

    if (!mounted) return;

    setState(() {
      images = saved.isEmpty
          ? List<GenderGalleryImageModel>.from(defaultGenderGalleryImages)
          : saved;
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// 🔥 MUHIM: rasm qirqilmasligi uchun contain ishlatyapmiz
  Widget _buildImage(GenderGalleryImageModel item) {
    return Container(
      color: Colors.white,
      child: item.isLocalImage
          ? Image.file(
        File(item.imagePath),
        fit: BoxFit.contain,
      )
          : Image.asset(
        item.imagePath,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildCard(GenderGalleryImageModel item, int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: EdgeInsets.only(
        right: 12,
        left: index == 0 ? 0 : 2,
        top: 6,
        bottom: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            colors: [
              Color(0xFFEAF3FF),
              Color(0xFFF7F3FF),
            ],
          ),
        ),
        child: Stack(
          children: [
            /// 📸 RASM
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: _buildImage(item),
              ),
            ),

            /// 🔢 COUNTER
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.35),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  '${index + 1}/${images.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        images.length,
            (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: currentPage == index ? 18 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: currentPage == index
                ? AppTheme.primaryColor
                : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return const Center(
      child: Text(
        'Rasmlar mavjud emas',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF7),
      appBar: AppBar(
        title: const Text('Rasmlar'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : images.isEmpty
          ? _buildEmpty()
          : Column(
        children: [
          const SizedBox(height: 10),

          const Padding(
            padding: EdgeInsets.only(left: 16, bottom: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Rasmlarni yon tomonga suring',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),

          /// 🔥 SLIDER
          SizedBox(
            height: 500,
            child: PageView.builder(
              controller: _pageController,
              itemCount: images.length,
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              itemBuilder: (context, index) {
                return _buildCard(images[index], index);
              },
            ),
          ),

          const SizedBox(height: 12),

          _buildIndicator(),
        ],
      ),
    );
  }
}