import '../models/diagnostic_result_model.dart';

final List<DiagnosticResultModel> diagnosticResults = [
  DiagnosticResultModel(
    level: 'low',
    title: 'Gender Identifikatsiyasi (Past daraja)',
    minScore: 0,
    maxScore: 4,
    description:
    "Bola o'z jinsiga doir tanlovlarni qilishda noaniqliklarga ega bo'ladi va o'z jinsini anglashda qiyinchiliklarga duch keladi. U turli jinslarga xos bo'lgan obyektlarni ajratishda ba'zan xatolarga yo'l qo'yishi mumkin. Gender ro'llari va stereotiplari haqida tushunchasi hali shakllanmagan bo'ladi.",
    scientificNote:
    "Ilmiy asos: Erta yoshdagi bolalar o'z jinsiga oid tushunchalarni va gender rollarni hali aniq shakllantirmagan bo'ladi. Bu esa ularning jinsiy identifikatsiyasini to'liq anglashlariga to'sqinlik qilishi mumkin (Kohlberg, 1966).",
  ),
  DiagnosticResultModel(
    level: 'medium',
    title: 'Gender Identifikatsiyasi (O‘rtacha daraja)',
    minScore: 5,
    maxScore: 8,
    description:
    "Bola jinsiy tanlovlarni qisman aniqlaydi, lekin ba'zi noaniqliklar mavjud. U o'z jinsiga mos keladigan obyektlarni tanlasa ham, ba'zan gender stereotiplari va rollarini tushunishda qiyinchiliklarga duch keladi. Genderga doir ayrim tushunchalar rivojlanayotgan bo'ladi.",
    scientificNote:
    "Ilmiy asos: Bola gender rollari va stereotiplari haqida o'rganishda davom etadi, ammo ayrim hollarda gender identifikatsiyasini tushunishda noaniqliklar bo'lishi mumkin (Martin & Ruble, 2004).",
  ),
  DiagnosticResultModel(
    level: 'high',
    title: 'Gender Identifikatsiyasi (Yuqori daraja)',
    minScore: 9,
    maxScore: 100,
    description:
    "Bola o'z jinsiga mos keladigan obyektlarni aniq va to'liq tanlaydi. U o'z jinsini yaxshi tushunadi va gender rollari hamda stereotiplarga mos ravishda tanlov qiladi. Erkak va ayol o'rtasidagi farqlarni aniq ajrata oladi.",
    scientificNote:
    "Ilmiy asos: Bola o'z jinsini tushunish va gender rollarni aniq belgilashda yuqori darajaga erishgan bo'ladi. Bu esa uning gender identifikatsiyasining shakllanganligini ko'rsatadi (Kohlberg, 1966; Martin & Ruble, 2004).",
  ),
];