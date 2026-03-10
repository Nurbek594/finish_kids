import '../models/test_option_model.dart';
import '../models/test_question_model.dart';

const List<TestQuestionModel> parentTest1Questions = [
  TestQuestionModel(
    question: '1. Farzandingiz o‘yinchoq tanlayotganda siz qanday yo‘l tutasiz?',
    options: [
      TestOptionModel(text: 'Faqat o‘zim ma’qul ko‘rganini tanlataman', score: 1),
      TestOptionModel(text: 'Ba’zan maslahat beraman, ba’zan erkin qo‘yaman', score: 2),
      TestOptionModel(text: 'Qiziqishiga qarab mustaqil tanlashiga imkon beraman', score: 3),
    ],
  ),
  TestQuestionModel(
    question: '2. Farzandingizning kiyim tanlashiga munosabatingiz qanday?',
    options: [
      TestOptionModel(text: 'Faqat men aytgan kiyimni kiyadi', score: 1),
      TestOptionModel(text: 'Ayrim hollarda tanlashiga ruxsat beraman', score: 2),
      TestOptionModel(text: 'Yoshiga mos ravishda tanlashiga imkon beraman', score: 3),
    ],
  ),
  TestQuestionModel(
    question: '3. Bola savol bersa, siz qanday javob berasiz?',
    options: [
      TestOptionModel(text: 'Savolni qisqa to‘xtataman yoki mavzuni yopaman', score: 1),
      TestOptionModel(text: 'Ba’zi savollariga javob beraman', score: 2),
      TestOptionModel(text: 'Yoshiga mos, tushunarli va xotirjam javob beraman', score: 3),
    ],
  ),
  TestQuestionModel(
    question: '4. Farzandingiz turli kasblarga qiziqsa, siz nima qilasiz?',
    options: [
      TestOptionModel(text: 'Faqat o‘zim to‘g‘ri deb bilgan kasblarni aytaman', score: 1),
      TestOptionModel(text: 'Ba’zi tanlovlarini qo‘llab-quvvatlayman', score: 2),
      TestOptionModel(text: 'Qiziqishini hurmat qilib, turli kasblar haqida tushuntiraman', score: 3),
    ],
  ),
  TestQuestionModel(
    question: '5. Farzandingiz o‘z fikrini bildirsa, sizning munosabatingiz?',
    options: [
      TestOptionModel(text: 'Ko‘pincha rad etaman', score: 1),
      TestOptionModel(text: 'Ba’zan inobatga olaman', score: 2),
      TestOptionModel(text: 'Eshitaman va hurmat bilan yondashaman', score: 3),
    ],
  ),
  TestQuestionModel(
    question: '6. Tarbiya jarayonida bolaga qanday yondashasiz?',
    options: [
      TestOptionModel(text: 'Qattiq nazorat va buyruq bilan', score: 1),
      TestOptionModel(text: 'Nazorat va erkinlikni aralashtiraman', score: 2),
      TestOptionModel(text: 'Mehr, tushuntirish va to‘g‘ri yo‘naltirish bilan', score: 3),
    ],
  ),
];

const List<TestQuestionModel> parentTest2Questions = [
  TestQuestionModel(
    question: '1. Farzandingiz xato qilsa, siz nima qilasiz?',
    options: [
      TestOptionModel(text: 'Darhol koyib, qat’iy jazolayman', score: 1),
      TestOptionModel(text: 'Avval tushuntiraman, keyin talab qo‘yaman', score: 2),
      TestOptionModel(text: 'Sababini tushunib, murosali tushuntiraman', score: 3),
    ],
  ),
  TestQuestionModel(
    question: '2. Uy qoidalariga amal qilinmasa, qanday yo‘l tutasiz?',
    options: [
      TestOptionModel(text: 'Hech qanday e’tiroz qabul qilmayman', score: 1),
      TestOptionModel(text: 'Qoidani eslataman va izoh beraman', score: 2),
      TestOptionModel(text: 'Birga gaplashib, murosali yechim topaman', score: 3),
    ],
  ),
  TestQuestionModel(
    question: '3. Farzandingizning fikr bildirishiga munosabatingiz?',
    options: [
      TestOptionModel(text: 'Kattalar gapiga aralashmasligi kerak deyman', score: 1),
      TestOptionModel(text: 'Ba’zan tinglayman', score: 2),
      TestOptionModel(text: 'Doim tinglab, fikrini qadrlayman', score: 3),
    ],
  ),
  TestQuestionModel(
    question: '4. Kun tartibini kim belgilaydi?',
    options: [
      TestOptionModel(text: 'Faqat men belgilayman', score: 1),
      TestOptionModel(text: 'Asosan men, ba’zan bolani ham so‘rayman', score: 2),
      TestOptionModel(text: 'Birga kelishib belgilaymiz', score: 3),
    ],
  ),
  TestQuestionModel(
    question: '5. Tarbiya uslubingizga qaysi ta’rif mos?',
    options: [
      TestOptionModel(text: 'Qat’iy va buyruqboz', score: 1),
      TestOptionModel(text: 'Izchil va maslahatchi', score: 2),
      TestOptionModel(text: 'Erkin va murosali', score: 3),
    ],
  ),
  TestQuestionModel(
    question: '6. Farzandingiz bilan muammo chiqsa, qanday hal qilasiz?',
    options: [
      TestOptionModel(text: 'Men aytganim bo‘ladi', score: 1),
      TestOptionModel(text: 'Tushuntirib, nazorat qilaman', score: 2),
      TestOptionModel(text: 'Suhbat va hamkorlik bilan hal qilaman', score: 3),
    ],
  ),
];

const List<String> parentTest3Questions = [
  '1. Siz farzandingiz bilan gender tengligi haqida suhbat qilasizmi?',
  '2. Farzandingizning qiziqishlarini hurmat qilasizmi?',
  '3. Tarbiyada faqat an’anaviy qarashlargagina tayanasizmi?',
  '4. Farzandingizning mustaqil fikrlashini qo‘llab-quvvatlaysizmi?',
  '5. Farzandingizga ijtimoiy rollarni tushuntirib berasizmi?',
];