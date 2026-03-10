import '../models/diagnostic_result_model.dart';
import '../models/who_am_i_item_model.dart';

const List<WhoAmIItemModel> toyItems = [
  WhoAmIItemModel(
    title: 'Qo‘g‘irchoq',
    image: 'assets/images/toy1.png',
    category: 'female',
    score: 1,
  ),
  WhoAmIItemModel(
    title: 'Mashina',
    image: 'assets/images/toy2.png',
    category: 'male',
    score: 1,
  ),
  WhoAmIItemModel(
    title: 'Ayiqcha',
    image: 'assets/images/toy3.png',
    category: 'neutral',
    score: 2,
  ),
  WhoAmIItemModel(
    title: 'Konstruktor',
    image: 'assets/images/toy4.png',
    category: 'neutral',
    score: 2,
  ),
  WhoAmIItemModel(
    title: 'Oshxona o‘yinchog‘i',
    image: 'assets/images/toy5.png',
    category: 'female',
    score: 1,
  ),
  WhoAmIItemModel(
    title: 'Robot',
    image: 'assets/images/toy6.png',
    category: 'male',
    score: 1,
  ),
];

const List<WhoAmIItemModel> jobItems = [
  WhoAmIItemModel(
    title: 'Shifokor',
    image: 'assets/images/job1.png',
    category: 'neutral',
    score: 2,
  ),
  WhoAmIItemModel(
    title: 'O‘qituvchi',
    image: 'assets/images/job2.png',
    category: 'neutral',
    score: 2,
  ),
  WhoAmIItemModel(
    title: 'Quruvchi',
    image: 'assets/images/job3.png',
    category: 'male',
    score: 1,
  ),
  WhoAmIItemModel(
    title: 'Dizayner',
    image: 'assets/images/job4.png',
    category: 'neutral',
    score: 2,
  ),
  WhoAmIItemModel(
    title: 'Uchuvchi',
    image: 'assets/images/job5.png',
    category: 'male',
    score: 1,
  ),
  WhoAmIItemModel(
    title: 'Hamshira',
    image: 'assets/images/job6.png',
    category: 'female',
    score: 1,
  ),
];

const List<DiagnosticResultModel> diagnosticResults = [
  DiagnosticResultModel(
    level: 'low',
    title: 'Gender Identifikatsiyasi (Past daraja)',
    description:
    'Bola o‘z jinsiga doir tanlovlarni qilishda noaniqliklarga ega bo‘lishi mumkin. '
        'U turli jinslarga xos deb qabul qilinadigan ob’ektlarni ajratishda ba’zan qiynaladi. '
        'Genderga oid tushunchalari hali to‘liq shakllanmagan bo‘lishi mumkin.',
    scientificNote:
    'Eslatma (ilmiy asos): Erta yoshdagi bolalarda jinsga oid tasavvurlar hali barqaror shakllanib ulgurmagan bo‘lishi mumkin (Kohlberg, 1966).',
    minScore: 0,
    maxScore: 5,
  ),
  DiagnosticResultModel(
    level: 'medium',
    title: 'Gender Identifikatsiyasi (O‘rtacha daraja)',
    description:
    'Bola jinsga oid ayrim tanlovlarni anglay boshlagan, lekin ba’zi noaniqliklar hali saqlanib qolgan bo‘lishi mumkin. '
        'Tanlovlarida qisman barqarorlik kuzatiladi, ammo tushunchalar hali rivojlanish jarayonida bo‘ladi.',
    scientificNote:
    'Eslatma (ilmiy asos): Bola genderga oid bilimlarni faol ravishda o‘rganadi, lekin ayrim tushunchalarda noaniqlik bo‘lishi mumkin (Martin & Ruble, 2004).',
    minScore: 6,
    maxScore: 9,
  ),
  DiagnosticResultModel(
    level: 'high',
    title: 'Gender Identifikatsiyasi (Yuqori daraja)',
    description:
    'Bola tanlovlarni ancha aniq va ishonchli qiladi. U o‘zini anglash va atrofdagi rollarni tushunishda nisbatan yuqori darajada barqarorlik ko‘rsatadi.',
    scientificNote:
    'Ilmiy asos: Bola jinsga oid tushunchalarni ancha ravshan shakllantirib borayotgan bo‘lishi mumkin (Kohlberg, 1966; Martin & Ruble, 2004).',
    minScore: 10,
    maxScore: 20,
  ),
];