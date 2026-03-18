import 'dart:io';
import 'package:flutter/material.dart';
import '../data/gender_info_data.dart';
import '../models/gender_info_model.dart';
import '../services/gender_gallery_storage_service.dart';
import '../services/gender_info_storage_service.dart';
import '../theme/app_theme.dart';
import 'gender_gallery_screen.dart';
import 'gender_info_detail_screen.dart';

class GenderInfoScreen extends StatefulWidget {
  const GenderInfoScreen({super.key});

  @override
  State<GenderInfoScreen> createState() => _GenderInfoScreenState();
}

class _GenderInfoScreenState extends State<GenderInfoScreen>
    with SingleTickerProviderStateMixin {
  List<GenderInfoModel> localGenderInfos = [];
  bool isLoading = true;
  int galleryCount = 0;
  int currentPage = 0;

  late final AnimationController _controller;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.90);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();
    _loadGenderInfos();
  }

  Future<void> _loadGenderInfos() async {
    final savedItems = await GenderInfoStorageService.loadGenderInfos();
    final galleryItems = await GenderGalleryStorageService.loadImages();

    if (!mounted) return;

    setState(() {
      localGenderInfos =
          savedItems ?? List<GenderInfoModel>.from(genderInfoList);
      galleryCount = galleryItems.length;
      isLoading = false;
      if (currentPage >= localGenderInfos.length && localGenderInfos.isNotEmpty) {
        currentPage = localGenderInfos.length - 1;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildImage(GenderInfoModel item) {
    if (item.isLocalImage) {
      return Image.file(
        File(item.image),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Icon(
              Icons.auto_awesome_rounded,
              size: 52,
              color: AppTheme.primaryColor,
            ),
          );
        },
      );
    }

    return Image.asset(
      item.image,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return const Center(
          child: Icon(
            Icons.auto_awesome_rounded,
            size: 52,
            color: AppTheme.primaryColor,
          ),
        );
      },
    );
  }

  Widget _buildTopHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFE9D5FF),
            Color(0xFFD9F4FF),
            Color(0xFFFCE7F3),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.10),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.65),
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Icon(
              Icons.psychology_alt_rounded,
              size: 38,
              color: Color(0xFF8B5CF6),
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gender identifikatsiya',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.textDark,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Olimlar fikri va foydali tushunchalarni qulay cardlar orqali o‘rganing',
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textDark,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGalleryCard() {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const GenderGalleryScreen(),
          ),
        );
        await _loadGenderInfos();
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF8B5CF6),
              Color(0xFFC084FC),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF8B5CF6).withOpacity(0.22),
              blurRadius: 14,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 28,
              backgroundColor: Colors.white24,
              child: Icon(
                Icons.photo_library_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Rasmlar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    galleryCount == 0
                        ? 'Ko‘rish uchun rasmlar mavjud emas'
                        : '$galleryCount ta rasmni ko‘rish',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      height: 1.4,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardCounter(int index, int total) {
    return Positioned(
      top: 12,
      right: 12,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.35),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          '${index + 1}/$total',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }

  Widget _buildPageCard(GenderInfoModel item, int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: EdgeInsets.only(
        right: 12,
        left: index == 0 ? 0 : 2,
        top: 4,
        bottom: 4,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => GenderInfoDetailScreen(item: item),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 280,
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFEDE9FF),
                    Color(0xFFF8EEFF),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: _buildImage(item),
                    ),
                  ),
                  _buildCardCounter(index, localGenderInfos.length),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 2, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.textDark,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    item.shortDescription,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.55,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1EDFF),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Text(
                          item.author,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    if (localGenderInfos.isEmpty) return const SizedBox.shrink();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        localGenderInfos.length,
            (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: currentPage == index ? 18 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: currentPage == index
                ? AppTheme.primaryColor
                : const Color(0xFFD9D9E3),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyInfoState() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(
            Icons.psychology_alt_outlined,
            size: 56,
            color: Colors.grey,
          ),
          const SizedBox(height: 12),
          const Text(
            'Ma’lumotlar yo‘q',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: AppTheme.textDark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Admin panel orqali ma’lumotlar qo‘shing',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.5,
              height: 1.5,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF7),
      appBar: AppBar(
        title: const Text('Gender identifikatsiya'),
      ),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : FadeTransition(
        opacity: CurvedAnimation(
          parent: _controller,
          curve: Curves.easeOut,
        ),
        child: RefreshIndicator(
          onRefresh: _loadGenderInfos,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
            children: [
              _buildTopHeader(),
              const SizedBox(height: 18),
              _buildGalleryCard(),
              const SizedBox(height: 18),
              if (localGenderInfos.isEmpty)
                _buildEmptyInfoState()
              else ...[
                const Padding(
                  padding: EdgeInsets.only(left: 2, bottom: 12),
                  child: Text(
                    'Kartalarni yon tomonga suring',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.textDark,
                    ),
                  ),
                ),
                SizedBox(
                  height: 470,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: localGenderInfos.length,
                    onPageChanged: (value) {
                      setState(() {
                        currentPage = value;
                      });
                    },
                    itemBuilder: (context, index) {
                      final item = localGenderInfos[index];
                      return _buildPageCard(item, index);
                    },
                  ),
                ),
                const SizedBox(height: 14),
                _buildPageIndicator(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}