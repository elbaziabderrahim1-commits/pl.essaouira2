import 'package:flutter/material.dart';

void main() {
  runApp(const StaffManagementApp());
}

class StaffManagementApp extends StatelessWidget {
  const StaffManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'إدارة طاقم العمل المتكامل',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0077B6),
          primary: const Color(0xFF0077B6),
          secondary: const Color(0xFFFF6B6B),
          background: const Color(0xFFF8F9FA),
        ),
        fontFamily: 'Roboto',
      ),
      home: const EmployeeListScreen(),
    );
  }
}

class Employee {
  String id;
  String name;
  String workCenter;
  String restDays;
  String phone;
  String status; // في العمل, رخصة مرضية, إجازة, في مهمة, موقوف عن العمل, التكوين المستمر
  String attendance; // حاضر, غائب, متأخر
  String currentTask;
  List<String> previousTasks;

  Employee({
    required this.id,
    required this.name,
    required this.workCenter,
    required this.restDays,
    required this.phone,
    this.status = 'في العمل',
    this.attendance = 'حاضر',
    required this.currentTask,
    List<String>? previousTasks,
  }) : previousTasks = previousTasks ?? [];
}

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  // القائمة الكاملة المستخرجة من البيانات المرفقة
  final List<Employee> _employees = [
    Employee(id: 'EMP-1001', name: 'خلفاوي الحسين', workCenter: 'رئيس المعقل', restDays: 'السبت الأحد', phone: '', currentTask: 'رئيس المعقل'),
    Employee(id: 'EMP-1002', name: 'زكرياء الكفيش', workCenter: 'نائب رئيس المعقل', restDays: 'السبت الاحد', phone: '', currentTask: 'نائب رئيس المعقل'),
    Employee(id: 'EMP-1003', name: 'البازي عبد الرحيم', workCenter: 'نائب رئيس المعقل', restDays: 'السبت الاحد', phone: '0635628386', currentTask: 'نائب رئيس المعقل'),
    Employee(id: 'EMP-1004', name: 'عبد الله بشبلا', workCenter: 'نائب رئيس المعقل', restDays: 'الخميس - الجمعة', phone: '', currentTask: 'نائب رئيس المعقل'),
    Employee(id: 'EMP-1005', name: 'علي الحراث', workCenter: 'نائب رئيس المعقل', restDays: 'الثلاثاء الاربعاء', phone: '', currentTask: 'نائب رئيس المعقل'),
    Employee(id: 'EMP-1006', name: 'عبد الرحمان وركة', workCenter: 'التصنيف و الايواء', restDays: 'السبت الاحد', phone: '', currentTask: 'التصنيف و الايواء'),
    Employee(id: 'EMP-1007', name: 'سعيد الهواوي', workCenter: 'ضبط سجلات باب المعقل', restDays: 'السبت الاحد', phone: '', currentTask: 'ضبط سجلات باب المعقل'),
    Employee(id: 'EMP-1008', name: 'موسى بوري', workCenter: 'التفتيش في باب المعقل', restDays: 'السبت الاحد', phone: '', currentTask: 'التفتيش في باب المعقل'),
    Employee(id: 'EMP-1009', name: 'خالد اوقاس', workCenter: 'ضبط حركة باب المعقل', restDays: 'الجمعة السبت', phone: '', currentTask: 'ضبط حركة باب المعقل'),
    Employee(id: 'EMP-1010', name: 'محمد عبيد', workCenter: 'ضبط حركة باب المعقل', restDays: 'الاربعاء الخميس', phone: '', currentTask: 'ضبط حركة باب المعقل'),
    Employee(id: 'EMP-1011', name: 'نور الدين جباري', workCenter: 'الخفر الى المستشفى', restDays: 'السبت الاحد', phone: '', currentTask: 'الخفر الى المستشفى'),
    Employee(id: 'EMP-1012', name: 'عبد الحق العلمي', workCenter: 'الخفر الى المستشفى', restDays: 'السبت الاحد', phone: '', currentTask: 'الخفر الى المستشفى'),
    Employee(id: 'EMP-1013', name: 'مهدي عزمي', workCenter: 'الخفر الى المستشفى', restDays: 'السبت الاحد', phone: '', currentTask: 'الخفر الى المستشفى'),
    Employee(id: 'EMP-1014', name: 'بلمهدي عز الدين', workCenter: 'الخفر الى المستشفى', restDays: 'السبت الاحد', phone: '', currentTask: 'الخفر الى المستشفى'),
    Employee(id: 'EMP-1015', name: 'خالد الغربة', workCenter: 'رئيس الحي الأول', restDays: 'الاربعاء - الخميس', phone: '', currentTask: 'رئيس الحي الأول'),
    Employee(id: 'EMP-1016', name: 'احمد ابوزيا', workCenter: 'نائب رئيس الحي الأول', restDays: 'السبت - الاحد', phone: '', currentTask: 'نائب رئيس الحي الأول'),
    Employee(id: 'EMP-1017', name: 'حمادي محمد', workCenter: 'الحي الأول الجناح الأول', restDays: 'الاثنين - الثلاثاء', phone: '', currentTask: 'الحي الأول الجناح الأول'),
    Employee(id: 'EMP-1018', name: 'ياسين اعميمي', workCenter: 'الحي الأول الجناح الأول', restDays: 'السبت الاحد', phone: '', currentTask: 'الحي الأول الجناح الأول'),
    Employee(id: 'EMP-1019', name: 'عبد الكريم الحنفي', workCenter: 'الحي الأول الجناح الثاني', restDays: 'الثلاثاء الاربعاء', phone: '', currentTask: 'الحي الأول الجناح الثاني'),
    Employee(id: 'EMP-1020', name: 'محمد حافيضي', workCenter: 'الحي الأول الجناح الثاني', restDays: 'الخميس - الجمعة', phone: '', currentTask: 'الحي الأول الجناح الثاني'),
    Employee(id: 'EMP-1021', name: 'خالد عكوري', workCenter: 'الحي الأول الجناح الثالث', restDays: 'الثلاثاء الاربعاء', phone: '', currentTask: 'الحي الأول الجناح الثالث'),
    Employee(id: 'EMP-1022', name: 'التاج محمد', workCenter: 'الحي الأول الجناح الثالث', restDays: 'الخميس - الجمعة', phone: '', currentTask: 'الحي الأول الجناح الثالث'),
    Employee(id: 'EMP-1023', name: 'ابراهيم المجدي', workCenter: 'باب الحي الأول', restDays: 'الثلاثاء الاربعاء', phone: '', currentTask: 'باب الحي الأول'),
    Employee(id: 'EMP-1024', name: 'مهدي ادراوي', workCenter: 'فسحة الحي الأول', restDays: 'السبت الاحد', phone: '', currentTask: 'فسحة الحي الأول'),
    Employee(id: 'EMP-1025', name: 'حسن عمري', workCenter: 'رئيس الحي الثاني', restDays: 'الاثنين - الثلاثاء', phone: '', currentTask: 'رئيس الحي الثاني'),
    Employee(id: 'EMP-1026', name: 'مهدي بنعشى', workCenter: 'نائب رئيس الحي الثاني', restDays: 'الاربعاء - الخميس', phone: '', currentTask: 'نائب رئيس الحي الثاني'),
    Employee(id: 'EMP-1027', name: 'حسن بنخديجة', workCenter: 'الجناح الأول الحي الثاني', restDays: 'الاربعاء - الخميس', phone: '', currentTask: 'الجناح الأول الحي الثاني'),
    Employee(id: 'EMP-1028', name: 'ادريس ايت عيسى', workCenter: 'الجناح الأول الحي الثاني', restDays: 'السبت الاحد', phone: '', currentTask: 'الجناح الأول الحي الثاني'),
    Employee(id: 'EMP-1029', name: 'هني عبد اللطيف', workCenter: 'الجناح الثاني الحي الثاني', restDays: 'الخميس - الجمعة', phone: '', currentTask: 'الجناح الثاني الحي الثاني'),
    Employee(id: 'EMP-1030', name: 'ياسين حافيضي', workCenter: 'الجناح الثاني الحي الثاني', restDays: 'الثلاثاء الاربعاء', phone: '', currentTask: 'الجناح الثاني الحي الثاني'),
    Employee(id: 'EMP-1031', name: 'عبد العظيم فريد', workCenter: 'الجناح الثاني الحي الثاني', restDays: 'السبت الاحد', phone: '', currentTask: 'الجناح الثاني الحي الثاني'),
    Employee(id: 'EMP-1032', name: 'عمران او حميدوش', workCenter: 'فسحة الحي الثاني', restDays: 'الثلاثاء الاربعاء', phone: '', currentTask: 'فسحة الحي الثاني'),
    Employee(id: 'EMP-1033', name: 'وحمان يوسف', workCenter: 'رئيس الحي الثالث', restDays: 'السبت الاحد', phone: '', currentTask: 'رئيس الحي الثالث'),
    Employee(id: 'EMP-1034', name: 'محمد الكنطاري', workCenter: 'نائب رئيس الحي الثالث', restDays: 'الاربعاء - الخميس', phone: '', currentTask: 'نائب رئيس الحي الثالث'),
    Employee(id: 'EMP-1035', name: 'مصعب بوعلام', workCenter: 'الحي الثالث الجناح الأول', restDays: 'الاثنين - الثلاثاء', phone: '', currentTask: 'الحي الثالث الجناح الأول'),
    Employee(id: 'EMP-1036', name: 'عبد الرحمان العوفي', workCenter: 'الحي الثالث الجناح الأول', restDays: 'السبت الاحد', phone: '', currentTask: 'الحي الثالث الجناح الأول'),
    Employee(id: 'EMP-1037', name: 'سيف الدين العبار', workCenter: 'الحي الثالث الجناح الثاني', restDays: 'السبت الاحد', phone: '', currentTask: 'الحي الثالث الجناح الثاني'),
    Employee(id: 'EMP-1038', name: 'وليد كمال', workCenter: 'الحي الثالث الجناح الثاني', restDays: 'الخميس - الجمعة', phone: '', currentTask: 'الحي الثالث الجناح الثاني'),
    Employee(id: 'EMP-1039', name: 'رضى بنكايس', workCenter: 'الحي الثالث الجناح الثالث', restDays: 'الخميس - الجمعة', phone: '', currentTask: 'الحي الثالث الجناح الثالث'),
    Employee(id: 'EMP-1040', name: 'يونس حنيكيش', workCenter: 'الحي الثالث الجناح الثالث', restDays: 'السبت الاحد', phone: '', currentTask: 'الحي الثالث الجناح الثالث'),
    Employee(id: 'EMP-1041', name: 'ياسين الغلوات', workCenter: 'فسحة الحي الثالث', restDays: 'السبت الاحد', phone: '', currentTask: 'فسحة الحي الثالث'),
    Employee(id: 'EMP-1042', name: 'رضى اغفار', workCenter: 'قاعة الزيارة', restDays: 'السبت الاحد', phone: '', currentTask: 'احضار السجناء الى قاعة الزيارة'),
    Employee(id: 'EMP-1043', name: 'حسن بكاري', workCenter: 'قاعة الزيارة', restDays: 'الجمعة السبت', phone: '', currentTask: 'التفتيش في قاعة الزيارة'),
    Employee(id: 'EMP-1044', name: 'محمد مكتاوي', workCenter: 'قاعة الزيارة', restDays: 'السبت الأحد', phone: '', currentTask: 'المسؤول عن قاعة الزيارة'),
    Employee(id: 'EMP-1045', name: 'الموتشو عبد الفتاح', workCenter: 'باب الموظفين', restDays: 'السبت الاحد', phone: '', currentTask: 'حراسة باب الموظفين'),
    Employee(id: 'EMP-1046', name: 'الحيمر محمد', workCenter: 'باب المرتفقين', restDays: 'السبت الاحد', phone: '', currentTask: 'حراسة باب المرتفقين'),
    Employee(id: 'EMP-1047', name: 'عبد الحكيم دكاير', workCenter: 'المواعيد', restDays: 'السبت الاحد', phone: '', currentTask: 'الزيارة والمواعيد'),
    Employee(id: 'EMP-1048', name: 'المهدي ديباني', workCenter: 'تفتيش المؤونة', restDays: 'السبت الاحد', phone: '', currentTask: 'تفتيش المؤونة'),
    Employee(id: 'EMP-1049', name: 'رضا نادر', workCenter: 'تفتيش الزوار', restDays: 'السبت الاحد', phone: '', currentTask: 'تفتيش الزوار'),
    Employee(id: 'EMP-1050', name: 'عبد الرحمان تحيري', workCenter: 'باب الحي الثالث', restDays: 'السبت الأحد', phone: '', currentTask: 'حراسة باب الحي الثالث'),
    Employee(id: 'EMP-1051', name: 'الديبالي عزيز', workCenter: 'الضبط القضائي', restDays: 'السبت الاحد', phone: '', currentTask: 'الحراسة في الضبط القضائي'),
    Employee(id: 'EMP-1052', name: 'الرحالي مصطفى', workCenter: 'الأمن الخارجي', restDays: 'السبت الاحد', phone: '', currentTask: 'رئيس الأمن الخارجي'),
    Employee(id: 'EMP-1053', name: 'الهام البجاوي', workCenter: 'تنظيم الزيارة', restDays: 'السبت الاحد', phone: '', currentTask: 'تنظيم الزيارة'),
    Employee(id: 'EMP-1054', name: 'مونى المشماشي', workCenter: 'قاعة الزيارة', restDays: 'السبت الاحد', phone: '', currentTask: 'مراقبة قاعة الزيارة'),
    Employee(id: 'EMP-1055', name: 'نادية احموش', workCenter: 'تفتيش المؤونة', restDays: 'السبت الاحد', phone: '', currentTask: 'تفتيش المؤونة'),
    Employee(id: 'EMP-1056', name: 'حليمة الجرموني', workCenter: 'تفتيش الزائرات', restDays: 'السبت الاحد', phone: '', currentTask: 'تفتيش الزائرات'),
    Employee(id: 'EMP-1057', name: 'سلمى الروينكو', workCenter: 'الاستقبال والتوجيه', restDays: 'السبت الاحد', phone: '', currentTask: 'الاستقبال والتوجيه'),
    Employee(id: 'EMP-1058', name: 'خديجة بلمقدم', workCenter: 'تفتيش الزائرات', restDays: 'السبت الاحد', phone: '', currentTask: 'تفتيش الزائرات'),
    Employee(id: 'EMP-1059', name: 'حكيمة القويسري', workCenter: 'قاعة الزيارة', restDays: 'السبت الاحد', phone: '', currentTask: 'قاعة الزيارة'),
    Employee(id: 'EMP-1060', name: 'نادية البغادي', workCenter: 'صندوق الزوار', restDays: 'السبت الاحد', phone: '', currentTask: 'تسلم الأموال من الزوار'),
    Employee(id: 'EMP-1061', name: 'عبد العزيز الصديقي', workCenter: 'الأمن الخارجي', restDays: 'السبت الأحد', phone: '', currentTask: 'نائب الأمن الخارجي'),
    Employee(id: 'EMP-1062', name: 'بشرى العرفاوي', workCenter: 'حي النساء', restDays: 'الخميس - الجمعة', phone: '', currentTask: 'نائبة رئيسة حي النساء'),
    Employee(id: 'EMP-1063', name: 'يسرى الرامي', workCenter: 'حي النساء', restDays: 'السبت الاحد', phone: '', currentTask: 'رئيسة حي النساء'),
    Employee(id: 'EMP-1064', name: 'فاطمة حكيمي', workCenter: 'حي النساء', restDays: 'السبت الاحد', phone: '', currentTask: 'التكوين بحي النساء'),
    Employee(id: 'EMP-1065', name: 'هنودي يونس', workCenter: 'باب الايقاف', restDays: 'السبت الاحد', phone: '', currentTask: 'حراسة باب الايقاف'),
    Employee(id: 'EMP-1066', name: 'الخناتي محمد', workCenter: 'النظافة', restDays: 'السبت الاحد', phone: '', currentTask: 'المكلف بالنظافة'),
    Employee(id: 'EMP-1067', name: 'اسامة بلوش', workCenter: 'فواصل الحي الثالث', restDays: 'السبت الأحد', phone: '', currentTask: 'حراسة فواصل الحي الثالث'),
    Employee(id: 'EMP-1068', name: 'رضى نور الدين', workCenter: 'البرج 4', restDays: 'السبت الاحد', phone: '', currentTask: 'حراسة البرج 4'),
    Employee(id: 'EMP-1069', name: 'محمد امين الناصري', workCenter: 'قسم المخالفات', restDays: 'السبت الاحد', phone: '', currentTask: 'المكلف بالمخالفات'),
    Employee(id: 'EMP-1070', name: 'السقاف مهدي', workCenter: 'الملتقى 1', restDays: 'الجمعة السبت', phone: '', currentTask: 'حراسة الملتقى 1'),
    Employee(id: 'EMP-1071', name: 'شرعا محمد', workCenter: 'السجن القديم', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'الحراسة في السجن القديم'),
    Employee(id: 'EMP-1072', name: 'رحالي عبد الحكيم', workCenter: 'السجن القديم', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'الحراسة في السجن القديم'),
    Employee(id: 'EMP-1073', name: 'عبد الله تنباكور', workCenter: 'السجن القديم', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'الحراسة في السجن القديم'),
    Employee(id: 'EMP-1074', name: 'الدويبة سعيد', workCenter: 'السجن القديم', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'الحراسة في السجن القديم'),
    Employee(id: 'EMP-1075', name: 'عبد الصمد السحيمي', workCenter: 'فواصل الحي الثالث', restDays: 'السبت - الاحد', phone: '', currentTask: 'فواصل الحي الثالث'),
    Employee(id: 'EMP-1076', name: 'عبد الصادق الصابر', workCenter: 'فواصل الحي الأول', restDays: 'الثلاثاء الاربعاء', phone: '', currentTask: 'فواصل الحي الأول'),
    Employee(id: 'EMP-1077', name: 'محمد عواج', workCenter: 'المداومة الليلية', restDays: 'حسب نظام المداومة', phone: '', currentTask: 'المداومة الليلية'),
    Employee(id: 'EMP-1078', name: 'اجبلي خالد', workCenter: 'فرقة الحراسة 1', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 1'),
    Employee(id: 'EMP-1079', name: 'طارق العيسي', workCenter: 'فرقة الحراسة 1', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 1'),
    Employee(id: 'EMP-1080', name: 'يونس جبور', workCenter: 'فرقة الحراسة 1', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 1'),
    Employee(id: 'EMP-1081', name: 'عبد الله العلوي', workCenter: 'فرقة الحراسة 1', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 1'),
    Employee(id: 'EMP-1082', name: 'المفداوي المحجوب', workCenter: 'فرقة الحراسة 1', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 1'),
    Employee(id: 'EMP-1083', name: 'اسامة عبو', workCenter: 'فرقة الحراسة 1', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 1'),
    Employee(id: 'EMP-1084', name: 'هشام الخوخي', workCenter: 'فرقة الحراسة 1', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 1'),
    Employee(id: 'EMP-1085', name: 'بو عفسا يوسف', workCenter: 'فرقة الحراسة 1', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 1'),
    Employee(id: 'EMP-1086', name: 'امین بنعلال', workCenter: 'فرقة الحراسة 1', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 1'),
    Employee(id: 'EMP-1087', name: 'يوسف صبير', workCenter: 'فرقة الحراسة 1', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 1'),
    Employee(id: 'EMP-1088', name: 'يوسف عمري', workCenter: 'فرقة الحراسة 1', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 1'),
    Employee(id: 'EMP-1089', name: 'شرف الدين تيكي', workCenter: 'فرقة الحراسة 1', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 1'),
    Employee(id: 'EMP-1090', name: 'محمد امین لوغو', workCenter: 'فرقة الحراسة 1', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 1'),
    Employee(id: 'EMP-1091', name: 'امينة الكارمة', workCenter: 'فرقة الحراسة 1', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 1'),
    Employee(id: 'EMP-1092', name: 'عبد الواحد السوسي', workCenter: 'فرقة الحراسة 2', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 2'),
    Employee(id: 'EMP-1093', name: 'العلاوي ادريس', workCenter: 'فرقة الحراسة 2', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 2'),
    Employee(id: 'EMP-1094', name: 'عادل او شاهد', workCenter: 'فرقة الحراسة 2', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 2'),
    Employee(id: 'EMP-1095', name: 'عبد الفتاح الركراكي', workCenter: 'فرقة الحراسة 2', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 2'),
    Employee(id: 'EMP-1096', name: 'عبد اللطيف الدحماني', workCenter: 'فرقة الحراسة 2', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 2'),
    Employee(id: 'EMP-1097', name: 'ياسين الحمدي', workCenter: 'فرقة الحراسة 2', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 2'),
    Employee(id: 'EMP-1098', name: 'محمد ابنطبر', workCenter: 'فرقة الحراسة 2', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 2'),
    Employee(id: 'EMP-1099', name: 'الحسين فراج', workCenter: 'فرقة الحراسة 2', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 2'),
    Employee(id: 'EMP-1100', name: 'دنيا النعامي', workCenter: 'فرقة الحراسة 2', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 2'),
    Employee(id: 'EMP-1101', name: 'مريم الديخ', workCenter: 'فرقة الحراسة 2', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 2'),
    Employee(id: 'EMP-1102', name: 'سعيد الزنزون', workCenter: 'فرقة الحراسة 3', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 3'),
    Employee(id: 'EMP-1103', name: 'باطش عبد الرحمان', workCenter: 'فرقة الحراسة 3', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 3'),
    Employee(id: 'EMP-1104', name: 'حمزة الفر', workCenter: 'فرقة الحراسة 3', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 3'),
    Employee(id: 'EMP-1105', name: 'عبد الاله لكحل', workCenter: 'فرقة الحراسة 3', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 3'),
    Employee(id: 'EMP-1106', name: 'عثمان بوستي', workCenter: 'فرقة الحراسة 3', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 3'),
    Employee(id: 'EMP-1107', name: 'اسامة اهكو', workCenter: 'فرقة الحراسة 3', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 3'),
    Employee(id: 'EMP-1108', name: 'عصام بنخديجة', workCenter: 'فرقة الحراسة 3', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 3'),
    Employee(id: 'EMP-1109', name: 'عمرو الهندي', workCenter: 'فرقة الحراسة 3', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 3'),
    Employee(id: 'EMP-1110', name: 'سفيان البغزاوي', workCenter: 'فرقة الحراسة 3', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 3'),
    Employee(id: 'EMP-1111', name: 'انجار عبد العزيز', workCenter: 'فرقة الحراسة 3', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 3'),
    Employee(id: 'EMP-1112', name: 'امينة مهاجر', workCenter: 'فرقة الحراسة 3', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 3'),
    Employee(id: 'EMP-1113', name: 'الشابني محمد', workCenter: 'فرقة الحراسة 4', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 4'),
    Employee(id: 'EMP-1114', name: 'مصطفى حيمي', workCenter: 'فرقة الحراسة 4', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 4'),
    Employee(id: 'EMP-1115', name: 'محمد اسرار', workCenter: 'فرقة الحراسة 4', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 4'),
    Employee(id: 'EMP-1116', name: 'وليد بوخيمة', workCenter: 'فرقة الحراسة 4', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 4'),
    Employee(id: 'EMP-1117', name: 'العواد عبد الصمد', workCenter: 'فرقة الحراسة 4', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 4'),
    Employee(id: 'EMP-1118', name: 'زكرياء جاري', workCenter: 'فرقة الحراسة 4', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 4'),
    Employee(id: 'EMP-1119', name: 'المهدي الجنين', workCenter: 'فرقة الحراسة 4', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 4'),
    Employee(id: 'EMP-1120', name: 'عبد الصمد امغران', workCenter: 'فرقة الحراسة 4', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 4'),
    Employee(id: 'EMP-1121', name: 'المغراوي ادريس', workCenter: 'فرقة الحراسة 4', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 4'),
    Employee(id: 'EMP-1122', name: 'مروان تصريحات', workCenter: 'فرقة الحراسة 4', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 4'),
    Employee(id: 'EMP-1123', name: 'عبد العالي الهميص', workCenter: 'فرقة الحراسة 4', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 4'),
    Employee(id: 'EMP-1124', name: 'هاجر المزوهر', workCenter: 'فرقة الحراسة 4', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 4'),
    Employee(id: 'EMP-1125', name: 'حليمة اشهيبة', workCenter: 'فرقة الحراسة 4', restDays: 'حسب نظام الحراسة', phone: '', currentTask: 'فرقة الحراسة الليلية 4'),
    Employee(id: 'EMP-1126', name: 'السامري محمد', workCenter: 'الباب الرسمي', restDays: 'السبت الاحد', phone: '', currentTask: 'الحراسة في الباب الرسمي'),
    Employee(id: 'EMP-1127', name: 'ايوب المغيتي', workCenter: 'باب الايقاف', restDays: 'الاثنين - الثلاثاء', phone: '', currentTask: 'حراسة باب الايقاف'),
    Employee(id: 'EMP-1132', name: 'محمد القليعي', workCenter: 'غير محدد', restDays: '-', phone: '', status: 'موقوف عن العمل', currentTask: 'لا يوجد'),
    Employee(id: 'EMP-1133', name: 'محمد الصديقي', workCenter: 'مركز التكوين', restDays: '-', phone: '', status: 'التكوين المستمر', currentTask: 'دورة تكوينية'),
    Employee(id: 'EMP-1134', name: 'عبد الله مساعد', workCenter: 'غير محدد', restDays: '-', phone: '', status: 'رخصة مرضية', currentTask: 'لا يوجد'),
  ];

  String _searchQuery = '';
  String _selectedFilter = 'الكل';

  List<Employee> get _filteredEmployees {
    return _employees.where((emp) {
      final matchesQuery = emp.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          emp.id.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          emp.workCenter.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          emp.currentTask.toLowerCase().contains(_searchQuery.toLowerCase());

      if (_selectedFilter == 'الكل') return matchesQuery;
      if (_selectedFilter == 'غائب') return matchesQuery && emp.attendance == 'غائب';
      if (_selectedFilter == 'رخص وإجازات') return matchesQuery && (emp.status == 'رخصة مرضية' || emp.status == 'إجازة');
      return matchesQuery && emp.status == _selectedFilter;
    }).toList();
  }

  // التنبيهات وإحصائيات الغياب
  int get _absentCount => _employees.where((e) => e.attendance == 'غائب').length;
  int get _leaveCount => _employees.where((e) => e.status == 'رخصة مرضية' || e.status == 'إجازة').length;

  Color _getStatusColor(String status) {
    switch (status) {
      case 'في العمل': return Colors.green;
      case 'رخصة مرضية': return Colors.red;
      case 'إجازة': return Colors.orange;
      case 'في مهمة': return Colors.blue;
      case 'موقوف عن العمل': return Colors.grey;
      default: return Colors.purple;
    }
  }

  void _openEmployeeForm({Employee? employee}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => EmployeeFormDialog(
        employee: employee,
        onSave: (newEmployee) {
          setState(() {
            if (employee == null) {
              _employees.add(newEmployee);
            } else {
              int index = _employees.indexWhere((e) => e.id == employee.id);
              if (index != -1) {
                // حفظ المهمة القديمة في سجل المهام السابقة تلقائياً إذا تغيرت
                if (_employees[index].currentTask != newEmployee.currentTask) {
                  newEmployee.previousTasks.insert(0, '${_employees[index].currentTask} (حتى ${DateTime.now().toString().split(' ')[0]})');
                }
                _employees[index] = newEmployee;
              }
            }
          });
        },
      ),
    );
  }

  void _showExportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تصدير التقارير اليومية', textAlign: TextAlign.right),
        content: const Text('يمكنك إستخراج التقرير اليومي لطاقم العمل وصحيفة الحضور والغياب بتنسيق جاهز للطباعة.', textAlign: TextAlign.right),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton.icon(
            icon: const Icon(Icons.print),
            label: const Text('طباعة التقرير'),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('جاري إعداد التقرير للطباعة...')));
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('نظام تدبير طاقم العمل', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          centerTitle: true,
          elevation: 4,
          actions: [
            IconButton(
              icon: const Icon(Icons.print, color: Colors.white),
              onPressed: _showExportDialog,
              tooltip: 'تصدير التقرير',
            ),
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0077B6), Color(0xFF00B4D8)],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
          ),
        ),
        body: Container(
          color: const Color(0xFFF8F9FA),
          child: Column(
            children: [
              // Alert & Summary Cards
              if (_absentCount > 0 || _leaveCount > 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: Colors.amber.shade100,
                  child: Row(
                    children: [
                      const Icon(Icons.warning_amber_rounded, color: Colors.amber),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'التنبيهات: ينشط حالياً $_leaveCount موظف في إجازة/رخصة، وسُجل غياب $_absentCount اليوم.',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),

              // Search Bar Area
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
                ),
                child: Column(
                  children: [
                    TextField(
                      onChanged: (value) => setState(() => _searchQuery = value),
                      decoration: InputDecoration(
                        hintText: 'بحث سريع (الاسم، الرقم الإداري، المهمة...)',
                        prefixIcon: const Icon(Icons.search, color: Color(0xFF0077B6)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                        filled: true,
                        fillColor: const Color(0xFFF1F5F9),
                        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Quick Filter Chips
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: ['الكل', 'غائب', 'رخص وإجازات', 'في العمل', 'في مهمة'].map((filter) {
                          final isSelected = _selectedFilter == filter;
                          return Padding(
                            padding: const EdgeInsets.only(left: 6.0),
                            child: ChoiceChip(
                              label: Text(filter, style: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontSize: 12)),
                              selected: isSelected,
                              selectedColor: const Color(0xFF0077B6),
                              onSelected: (selected) {
                                setState(() => _selectedFilter = filter);
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    )
                  ],
                ),
              ),

              // Staff Count Indicator
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('عدد الموظفين المعروضين: ${_filteredEmployees.length}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                    Chip(
                      label: Text('المجموع الكلي: ${_employees.length}', style: const TextStyle(color: Colors.white, fontSize: 11)),
                      backgroundColor: const Color(0xFF00B4D8),
                    )
                  ],
                ),
              ),

              // Employee List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  itemCount: _filteredEmployees.length,
                  itemBuilder: (context, index) {
                    final emp = _filteredEmployees[index];
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: _getStatusColor(emp.status).withOpacity(0.15),
                          child: Text(
                            emp.name.isNotEmpty ? emp.name[0] : '؟',
                            style: TextStyle(color: _getStatusColor(emp.status), fontWeight: FontWeight.bold),
                          ),
                        ),
                        title: Row(
                          children: [
                            Text(emp.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                            const Spacer(),
                            // Quick Attendance Toggle Badge
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (emp.attendance == 'حاضر') {
                                    emp.attendance = 'غائب';
                                  } else if (emp.attendance == 'غائب') {
                                    emp.attendance = 'متأخر';
                                  } else {
                                    emp.attendance = 'حاضر';
                                  }
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: emp.attendance == 'حاضر'
                                      ? Colors.green.shade100
                                      : (emp.attendance == 'غائب' ? Colors.red.shade100 : Colors.orange.shade100),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  emp.attendance,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: emp.attendance == 'حاضر'
                                        ? Colors.green.shade800
                                        : (emp.attendance == 'غائب' ? Colors.red.shade800 : Colors.orange.shade800),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${emp.id} | ${emp.workCenter}', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(emp.status).withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    emp.status,
                                    style: TextStyle(color: _getStatusColor(emp.status), fontSize: 11, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'المهمة: ${emp.currentTask}',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 11, color: Colors.blueGrey),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EmployeeDetailScreen(
                                employee: emp,
                                onEdit: () => _openEmployeeForm(employee: emp),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _openEmployeeForm(),
          backgroundColor: const Color(0xFFFF6B6B),
          icon: const Icon(Icons.person_add, color: Colors.white),
          label: const Text('إضافة موظف', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 📇 Employee Card Detail Screen
// -----------------------------------------------------------------------------
class EmployeeDetailScreen extends StatelessWidget {
  final Employee employee;
  final VoidCallback onEdit;

  const EmployeeDetailScreen({super.key, required this.employee, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('بطاقة الموظف التفصيلية'),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.pop(context);
                onEdit();
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: const Color(0xFF0077B6),
                        child: Text(
                          employee.name.isNotEmpty ? employee.name[0] : '؟',
                          style: const TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(employee.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(employee.id, style: const TextStyle(color: Colors.grey, fontSize: 16)),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Chip(
                            label: Text(employee.status, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            backgroundColor: _getStatusColor(employee.status),
                          ),
                          const SizedBox(width: 8),
                          Chip(
                            label: Text('الحضور: ${employee.attendance}', style: const TextStyle(color: Colors.white)),
                            backgroundColor: employee.attendance == 'حاضر' ? Colors.green : Colors.red,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Details List Card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildInfoRow(Icons.business, 'مركز العمل', employee.workCenter),
                      const Divider(),
                      _buildInfoRow(Icons.assignment, 'المهمة الحالية', employee.currentTask),
                      const Divider(),
                      _buildInfoRow(Icons.calendar_month, 'راحة الأسبوع', employee.restDays),
                      const Divider(),
                      _buildInfoRow(Icons.phone, 'رقم الهاتف', employee.phone.isEmpty ? 'غير مسجل' : employee.phone),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Previous Tasks Log Card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.history, color: Color(0xFF0077B6)),
                          SizedBox(width: 8),
                          Text('سجل المهام والمسار السابق', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0077B6))),
                        ],
                      ),
                      const SizedBox(height: 8),
                      employee.previousTasks.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Text('لا يوجد سجل سابق مسجل لهذا الموظف.', style: TextStyle(color: Colors.grey)),
                            )
                          : Column(
                              children: employee.previousTasks
                                  .map((task) => ListTile(
                                        dense: true,
                                        leading: const Icon(Icons.check_circle_outline, size: 18, color: Colors.blueGrey),
                                        title: Text(task),
                                      ))
                                  .toList(),
                            ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'في العمل': return Colors.green;
      case 'رخصة مرضية': return Colors.red;
      case 'إجازة': return Colors.orange;
      case 'في مهمة': return Colors.blue;
      case 'موقوف عن العمل': return Colors.grey;
      default: return Colors.purple;
    }
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF0077B6)),
          const SizedBox(width: 12),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value, style: const TextStyle(color: Colors.black87))),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 📝 Form Modal (Add / Edit)
// -----------------------------------------------------------------------------
class EmployeeFormDialog extends StatefulWidget {
  final Employee? employee;
  final Function(Employee) onSave;

  const EmployeeFormDialog({super.key, this.employee, required this.onSave});

  @override
  State<EmployeeFormDialog> createState() => _EmployeeFormDialogState();
}

class _EmployeeFormDialogState extends State<EmployeeFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _idController;
  late TextEditingController _nameController;
  late TextEditingController _centerController;
  late TextEditingController _taskController;
  late TextEditingController _restController;
  late TextEditingController _phoneController;
  String _selectedStatus = 'في العمل';
  String _selectedAttendance = 'حاضر';

  final List<String> _statusOptions = ['في العمل', 'رخصة مرضية', 'إجازة', 'في مهمة', 'موقوف عن العمل', 'التكوين المستمر'];
  final List<String> _attendanceOptions = ['حاضر', 'غائب', 'متأخر'];

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController(text: widget.employee?.id ?? '');
    _nameController = TextEditingController(text: widget.employee?.name ?? '');
    _centerController = TextEditingController(text: widget.employee?.workCenter ?? '');
    _taskController = TextEditingController(text: widget.employee?.currentTask ?? '');
    _restController = TextEditingController(text: widget.employee?.restDays ?? '');
    _phoneController = TextEditingController(text: widget.employee?.phone ?? '');
    if (widget.employee != null) {
      _selectedStatus = widget.employee!.status;
      _selectedAttendance = widget.employee!.attendance;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 20,
        left: 20,
        right: 20,
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.employee == null ? 'إضافة موظف جديد' : 'تعديل بيانات الموظف',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0077B6)),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _idController,
                  decoration: const InputDecoration(labelText: 'الرقم الإداري (مثال: EMP-1135)'),
                  validator: (v) => v!.isEmpty ? 'مطلوب' : null,
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'الاسم الكامل'),
                  validator: (v) => v!.isEmpty ? 'مطلوب' : null,
                ),
                TextFormField(
                  controller: _centerController,
                  decoration: const InputDecoration(labelText: 'مركز العمل'),
                ),
                TextFormField(
                  controller: _taskController,
                  decoration: const InputDecoration(labelText: 'المهمة الحالية'),
                ),
                TextFormField(
                  controller: _restController,
                  decoration: const InputDecoration(labelText: 'راحة الأسبوع'),
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(labelText: 'رقم الهاتف'),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedStatus,
                        decoration: const InputDecoration(labelText: 'الوضعية'),
                        items: _statusOptions.map((status) => DropdownMenuItem(value: status, child: Text(status))).toList(),
                        onChanged: (val) => setState(() => _selectedStatus = val!),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedAttendance,
                        decoration: const InputDecoration(labelText: 'الحضور اليومي'),
                        items: _attendanceOptions.map((att) => DropdownMenuItem(value: att, child: Text(att))).toList(),
                        onChanged: (val) => setState(() => _selectedAttendance = val!),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0077B6),
                    minimumSize: const Size.fromHeight(45),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final newEmp = Employee(
                        id: _idController.text,
                        name: _nameController.text,
                        workCenter: _centerController.text,
                        currentTask: _taskController.text,
                        restDays: _restController.text,
                        phone: _phoneController.text,
                        status: _selectedStatus,
                        attendance: _selectedAttendance,
                        previousTasks: widget.employee?.previousTasks ?? [],
                      );
                      widget.onSave(newEmp);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('حفظ البيانات والتغيرات', style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
