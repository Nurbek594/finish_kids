import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ParentTestResultScreen extends StatelessWidget {
  final int testType;
  final int? totalScore;
  final int? yesCount;
  final int? noCount;

  const ParentTestResultScreen({
    super.key,
    required this.testType,
    this.totalScore,
    this.yesCount,
    this.noCount,
  });

  Map<String, String> getMcqResult() {
    final score = totalScore ?? 0;

    if (testType == 1) {
      if (score >= 6 && score <= 10) {
        return {
          'title': 'Gender Identifikatsiyasi (Past daraja)',
          'description':
          'Farzandingizning gender identifikatsiyasi hali shakllanmagan, jinsiy tarbiya jarayonida yanada xushyorroq bo‘lish zarar qilmaydi. Farzandni gender identifikatsiyasini shakllantirish jarayonida bolaning yoshiga xos jinsiy tarbiya bilimlari yetarli emas.',
        };
      } else if (score >= 11 && score <= 15) {
        return {
          'title': 'Gender Identifikatsiyasi (O‘rta daraja)',
          'description':
          'Farzandingizning gender identifikatsiyasi o‘rta darajada rivojlanmoqda. U jinsiy rollar va stereotiplarga oid ayrim tushunchalarga ega, lekin ba’zi yondashuvlar hali shakllanmagan. Gender tenglik doirasida to‘g‘ri tushunchalarni shakllantirish lozim.',
        };
      } else {
        return {
          'title': 'Gender Identifikatsiyasi (Yuqori daraja)',
          'description':
          'Farzandning gender identifikatsiyasi yaxshi rivojlangan. U jinsiy tenglik va gender rollarida aniq va kengroq tushunchalarga ega. Bu yondashuvni qo‘llab-quvvatlash va tarbiyadagi ijobiy yo‘nalishni davom ettirish muhim.',
        };
      }
    } else {
      if (score >= 6 && score <= 10) {
        return {
          'title': 'Juda qat’iy va buyruqboz uslub',
          'description':
          'Agar javoblaringizda ko‘plab 1 ball bo‘lsa, bu farzandingizni ancha qat’iy va buyruqboz usulda tarbiyalayotganingizni ko‘rsatadi. Siz farzandingizga yuqori talablar qo‘yasiz va uning o‘z fikrini bildirishiga kamroq e’tibor berasiz.',
        };
      } else if (score >= 11 && score <= 15) {
        return {
          'title': 'Izchil va maslahatchi uslub',
          'description':
          'Agar javoblaringizda ko‘plab 2 ball bo‘lsa, siz farzandingizga izchil yondashuvni qo‘llaysiz. Sizda maslahatchi roli ham mavjud bo‘lib, farzandingizga aniq yo‘naltirishlar berasiz, lekin ba’zan murosali yondashuvni ham tanlaysiz.',
        };
      } else {
        return {
          'title': 'Erkin va murosali uslub',
          'description':
          'Agar javoblaringizda ko‘plab 3 ball bo‘lsa, bu sizning farzandingizga erkinlik va murosali yondashuvni tanlashingizni ko‘rsatadi. Siz farzand bilan hamkorlikda, uning fikrlarini inobatga olgan holda tarbiya berishga harakat qilasiz.',
        };
      }
    }
  }

  Map<String, String> getYesNoResult() {
    final yes = yesCount ?? 0;
    final no = noCount ?? 0;

    if (yes > no) {
      return {
        'title': 'Ko‘proq “Ha” javoblari',
        'description':
        'Siz farzandingizni gender identifikatsiyasi, tenglik va an’anaviy qadriyatlar asosida tarbiyalaysiz. Bu yondashuvda farzand jinsiy rollar va an’anaviy me’yorlarga moslashtirib tarbiyalanayotganini bildiradi.',
      };
    } else if (no > yes) {
      return {
        'title': 'Ko‘proq “Yo‘q” javoblari',
        'description':
        'Siz ko‘proq “Yo‘q” javoblarini tanlagan bo‘lsangiz, bu sizning jinsiy tarbiyaga kamroq e’tibor berishingizni ko‘rsatadi. Gender identifikatsiyasini shakllantirishda yanada aniqroq yondashuvni qo‘llashingiz zarur.',
      };
    } else {
      return {
        'title': '“Ha” va “Yo‘q” javoblari aralash',
        'description':
        'Farzandingizni muvozanatli yondashuvda tarbiyalaysiz. Bu yondashuvda siz gender tengligi va qadriyatlarni qo‘llab-quvvatlayapsiz, lekin ayrim an’anaviy qarashlar va jinsiy rollar o‘rtasida noaniqliklar mavjud.',
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    final result = testType == 3 ? getYesNoResult() : getMcqResult();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Test natijasi'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF6C63FF),
                    Color(0xFF9A8CFF),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryColor.withOpacity(0.24),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 34,
                    backgroundColor: Colors.white24,
                    child: Icon(
                      Icons.emoji_events_rounded,
                      size: 34,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    result['title'] ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (testType != 3)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Text(
                        'Jami ball: ${totalScore ?? 0}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  if (testType == 3)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Text(
                        'Ha: ${yesCount ?? 0}   |   Yo‘q: ${noCount ?? 0}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 14,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Diagnostik xulosa',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    result['description'] ?? '',
                    style: TextStyle(
                      fontSize: 15.2,
                      height: 1.75,
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}