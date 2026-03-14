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

  String get title {
    if (testType == 1) return '1-test natijasi';
    if (testType == 2) return '2-test natijasi';
    return '3-test natijasi';
  }

  String get resultText {
    if (testType == 1) {
      final score = totalScore ?? 0;

      if (score >= 6 && score <= 10) {
        return "Gender Identifikatsiyasi (Past daraja)\n\nFarzandingizning gender identifikatsiyasi hali shakllanmagan, jinsiy tarbiya jarayonida yanada xushyorroq bo'lish zarar qilmaydi. Farzandni gender identifikatsiyasini shakllantirish jarayonida bolaning yoshiga xos jinsiy tarbiya bilimlari yetarli emas.\n\nUmumiy ball: $score";
      } else if (score >= 11 && score <= 15) {
        return "Gender Identifikatsiyasi (O‘rta daraja)\n\nFarzandingizning gender identifikatsiyasi o‘rta darajada rivojlanmoqda. U jinsiy rollar va stereotiplarga oid ayrim tushunchalarga ega, lekin ba'zi o‘zgarishlar va yondashuvlar hali shakllanmagan. Gender identifikatsiyasiga oid tushunchalarni to‘g‘ri yondashuv bilan shakllantirish lozim.\n\nUmumiy ball: $score";
      } else {
        return "Gender Identifikatsiyasi (Yuqori daraja)\n\nFarzandingizning gender identifikatsiyasi yaxshi rivojlangan. U jinsiy tenglik va gender rollarida aniq va kengroq tushunchalarga ega. Bu yondashuvni qo‘llab-quvvatlash va jinsiy rollarni tarbiyalashda muvaffaqiyatga erishgansiz.\n\nUmumiy ball: $score";
      }
    }

    if (testType == 2) {
      final score = totalScore ?? 0;

      if (score >= 6 && score <= 10) {
        return "Juda qat'iy va buyruqboz uslub\n\nAgar sizning javoblaringizda ko‘plab 1 ball bo‘lsa, bu farzandingizni ancha qat'iy va buyruqboz usulda tarbiyalashingizni ko‘rsatadi. Siz farzandingizga doimiy ravishda yuqori talablar qo‘yasiz va uning o‘z fikrini bildirishiga kamroq e'tibor berasiz.\n\nUmumiy ball: $score";
      } else if (score >= 11 && score <= 15) {
        return "Izchil va maslahatchi uslub\n\nAgar sizning javoblaringizda ko‘plab 2 ball bo‘lsa, siz o‘z farzandingizga izchil yondashuvni qo‘llaysiz. Sizda maslahatchi roli ham mavjud bo‘lib, farzandingizga aniq yo‘naltirishlar berasiz, lekin ba'zan murosali yondashuvni tanlaysiz. Bu uslub farzand rivojlanishida muhim rol o‘ynaydi.\n\nUmumiy ball: $score";
      } else {
        return "Erkin va murosali uslub\n\nAgar sizning javoblaringizda ko‘plab 3 ball bo‘lsa, bu sizning farzandingizga erkinlik va murosali yondashuvni tanlashingizni ko‘rsatadi. Siz farzand bilan hamkorlikda, ularning fikrlarini inobatga olgan holda tarbiya berishga harakat qilasiz. Bu yondashuv farzandning mustaqilligi va o‘ziga bo‘lgan ishonchini oshiradi.\n\nUmumiy ball: $score";
      }
    }

    final yes = yesCount ?? 0;
    final no = noCount ?? 0;

    if (yes > no) {
      return "Ko‘proq \"Ha\" javoblari tanlangan.\n\nSiz farzandingizni gender identifikatsiyasi, tenglik va an'anaviy qadriyatlar asosida tarbiyalaysiz. Bu yondashuvda farzand jinsiy rollar va an'anaviy me'yorlarga moslashtirib tarbiyalanayotganini bildiradi.\n\nHa: $yes ta\nYo‘q: $no ta";
    } else if (no > yes) {
      return "Ko‘proq \"Yo‘q\" javoblari tanlangan.\n\nBu sizning jinsiy tarbiyaga kamroq e'tibor berishingizni ko‘rsatadi. Siz farzandingizni gender tengligi va ijtimoiy rollar bo‘yicha tarbiyalashda ko‘proq an'anaviy qadriyatlar asosida harakat qilasiz, ammo yanada aniqroq yondashuvni qo‘llashingiz zarur.\n\nHa: $yes ta\nYo‘q: $no ta";
    } else {
      return "\"Ha\" va \"Yo‘q\" javoblari aralash tanlangan.\n\nFarzandingizni muvozanatli yondashuvda tarbiyalaysiz. Bu yondashuvda siz gender tengligi va qadriyatlarni qo‘llab-quvvatlaysiz, lekin ba'zi an'anaviy qarashlar va jinsiy rollar o‘rtasidagi noaniqliklar mavjud. Gender identifikatsiyasini yanada rivojlantirish foydali bo‘ladi.\n\nHa: $yes ta\nYo‘q: $no ta";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF7),
      appBar: AppBar(
        title: const Text("Test natijasi"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF6C63FF),
                  Color(0xFF9A8CFF),
                ],
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.quiz_rounded,
                  size: 80,
                  color: Colors.white,
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(26),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 14,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Text(
              resultText,
              style: TextStyle(
                fontSize: 15,
                height: 1.7,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}