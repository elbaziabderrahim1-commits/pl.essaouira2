import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  runApp(const StaffManagerApp());
}

class StaffManagerApp extends StatelessWidget {
  const StaffManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'نظام تدبير طاقم العمل',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF4F6F8),
        fontFamily: 'Roboto',
      ),
      home: const StaffHomeScreen(),
    );
  }
}

class StaffHomeScreen extends StatefulWidget {
  const StaffHomeScreen({super.key});

  @override
  State<StaffHomeScreen> createState() => _StaffHomeScreenState();
}

class _StaffHomeScreenState extends State<StaffHomeScreen> {
  final List<String> daysOfWeek = [
    'الإثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
    'السبت',
    'الأحد'
  ];

  String selectedDay = 'الأحد';
  String selectedFilter = 'الكل';
  String searchQuery = '';

  // قائمة الموظفين الأولية
  List<Map<String, dynamic>> employees = [
    {
      'id': 'EMP-1001',
      'name': 'خلفاوي الحسين',
      'role': 'رئيس المعقل',
      'status': 'في العمل',
      'dutyType': 'عادي',
      'restDays': ['السبت'],
    },
    {
      'id': 'EMP-1002',
      'name': 'زكرياء الكفيش',
      'role': 'نائب رئيس المعقل',
      'status': 'في العمل',
      'dutyType': 'حراسة ليلية',
      'restDays': ['الأحد'],
    },
    {
      'id': '19496',
      'name': 'البازي عبد الرحيم',
      'role': 'نائب رئيس المعقل',
      'status': 'في العمل',
      'dutyType': 'مداومة',
      'restDays': ['الجمعة'],
    },
    {
      'id': 'EMP-1004',
      'name': 'عبد الله بشبلا',
      'role': 'نائب رئيس المعقل',
      'status': 'راحة أسبوعية',
      'dutyType': 'عادي',
      'restDays': ['الأحد'],
    },
    {
      'id': 'EMP-1005',
      'name': 'علي الحراث',
      'role': 'نائب رئيس المعقل',
      'status': 'رخصة/إجازة',
      'dutyType': 'عادي',
      'restDays': ['السبت', 'الأحد'],
    },
    {
      'id': 'EMP-1006',
      'name': 'عبد الرحمان وركة',
      'role': 'التصنيف والإيواء',
      'status': 'في العمل',
      'dutyType': 'عادي',
      'restDays': ['السبت'],
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // حفظ التغييرات محلياً في الهاتف
  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_employees', jsonEncode(employees));
  }

  // تحميل البيانات عند فتح التطبيق
  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString('saved_employees');
    if (data != null) {
      setState(() {
        employees = List<Map<String, dynamic>>.from(jsonDecode(data));
      });
    }
  }

  // استخراج الحرف الأول للاسم (للصورة الشخصية)
  String _getInitial(String name) {
    if (name.isEmpty) return 'م';
    List<String> parts = name.trim().split(' ');
    return parts[0][0];
  }

  // حساب الإحصائيات حسب اليوم المختار
  Map<String, int> _calculateDailyStats() {
    int working = 0;
    int rest = 0;
    int leave = 0;
    int nightGuard = 0;
    int onCall = 0;

    for (var emp in employees) {
      List restDays = emp['restDays'] ?? [];
      bool isRestDay = restDays.contains(selectedDay);
      String status = emp['status'];
      String duty = emp['dutyType'];

      if (status == 'رخصة/إجازة') {
        leave++;
      } else if (isRestDay || status == 'راحة أسبوعية') {
        rest++;
      } else {
        working++;
        if (duty == 'حراسة ليلية') nightGuard++;
        if (duty == 'مداومة') onCall++;
      }
    }

    return {
      'working': working,
      'rest': rest,
      'leave': leave,
      'nightGuard': nightGuard,
      'onCall': onCall,
    };
  }

  @override
  Widget build(BuildContext context) {
    final stats = _calculateDailyStats();

    final filteredEmployees = employees.where((emp) {
      final nameMatches = emp['name'].contains(searchQuery) || emp['id'].contains(searchQuery);
      List restDays = emp['restDays'] ?? [];
      bool isRestDay = restDays.contains(selectedDay);
      
      if (!nameMatches) return false;

      if (selectedFilter == 'في العمل') return !isRestDay && emp['status'] == 'في العمل';
      if (selectedFilter == 'راحة أسبوعية') return isRestDay || emp['status'] == 'راحة أسبوعية';
      if (selectedFilter == 'رخصة/إجازة') return emp['status'] == 'رخصة/إجازة';
      if (selectedFilter == 'حراسة ليلية') return emp['dutyType'] == 'حراسة ليلية' && !isRestDay;
      if (selectedFilter == 'مداومة') return emp['dutyType'] == 'مداومة' && !isRestDay;

      return true;
    }).toList();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF0088CC),
          elevation: 0,
          title: const Text('نظام تدبير طاقم العمل', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.print, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            // شريط الأيام
            Container(
              color: const Color(0xFF0088CC),
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: daysOfWeek.length,
                itemBuilder: (context, index) {
                  final day = daysOfWeek[index];
                  final isSelected = day == selectedDay;
                  return GestureDetector(
                    onTap: () => setState(() => selectedDay = day),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        day,
                        style: TextStyle(
                          color: isSelected ? const Color(0xFF0088CC) : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // شريط الإحصائيات الفوقي
            Container(
              color: const Color(0xFFFFF8E1),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: Colors.amber),
                    const SizedBox(width: 6),
                    Text(
                      'يوم $selectedDay: ',
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black80),
                    ),
                    _buildStatChip('في العمل: ${stats['working']}', Colors.green),
                    _buildStatChip('راحة أسبوعية: ${stats['rest']}', Colors.orange),
                    _buildStatChip('إجازة/رخصة: ${stats['leave']}', Colors.red),
                    _buildStatChip('حراسة ليلية: ${stats['nightGuard']}', Colors.purple),
                    _buildStatChip('مداومة: ${stats['onCall']}', Colors.blue),
                  ],
                ),
              ),
            ),

            // شريط البحث
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                onChanged: (val) => setState(() => searchQuery = val),
                decoration: InputDecoration(
                  hintText: 'بحث سريع (الاسم، الرقم الإداري...)',
                  prefixIcon: const Icon(Icons.search, color: Color(0xFF0088CC)),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            // أزرار الفلترة
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  _buildFilterButton('الكل'),
                  _buildFilterButton('في العمل'),
                  _buildFilterButton('راحة أسبوعية'),
                  _buildFilterButton('رخصة/إجازة'),
                  _buildFilterButton('حراسة ليلية'),
                  _buildFilterButton('مداومة'),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // إجمالي الأعداد
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('المعروضين: ${filteredEmployees.length}',
                      style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00A8B5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text('المجموع الكلي: ${employees.length}',
                        style: const TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // بطاقات الموظفين (مع إعادة الصورة الشخصية الرمزية)
            Expanded(
              child: ListView.builder(
                itemCount: filteredEmployees.length,
                itemBuilder: (context, index) {
                  final emp = filteredEmployees[index];
                  List restDays = emp['restDays'] ?? [];
                  bool isRestDay = restDays.contains(selectedDay);

                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          // دائر الصورة الشخصية (الحرف الأول من الاسم)
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: const Color(0xFFC8E6C9),
                            child: Text(
                              _getInitial(emp['name']),
                              style: const TextStyle(
                                color: Color(0xFF2E7D32),
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),

                          // تفاصيل الموظف
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      emp['name'],
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                    ),
                                    _buildStatusBadge(emp['status'], isRestDay),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${emp['id']} | ${emp['role']}',
                                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'نوع العمل: ${emp['dutyType']}',
                                  style: TextStyle(
                                    color: emp['dutyType'] == 'حراسة ليلية'
                                        ? Colors.purple
                                        : (emp['dutyType'] == 'مداومة' ? Colors.blue : Colors.black70),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // زر التعديل
                          IconButton(
                            icon: const Icon(Icons.edit, color: Color(0xFF0088CC), size: 20),
                            onPressed: () => _showEditDialog(emp),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _showAddDialog,
          backgroundColor: const Color(0xFFFF5252),
          icon: const Icon(Icons.person_add, color: Colors.white),
          label: const Text('إضافة موظف', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildStatChip(String text, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 11),
      ),
    );
  }

  Widget _buildFilterButton(String label) {
    final isSelected = selectedFilter == label;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0),
      child: ChoiceChip(
        label: Text(label, style: const TextStyle(fontSize: 12)),
        selected: isSelected,
        selectedColor: const Color(0xFF0088CC),
        labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black80),
        onSelected: (val) => setState(() => selectedFilter = label),
      ),
    );
  }

  Widget _buildStatusBadge(String status, bool isRestDay) {
    String displayStatus = isRestDay ? 'راحة أسبوعية' : status;
    Color color = Colors.green;

    if (displayStatus == 'راحة أسبوعية') color = Colors.orange;
    if (displayStatus == 'رخصة/إجازة') color = Colors.red;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        displayStatus,
        style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 11),
      ),
    );
  }

  void _showAddDialog() {
    String name = '';
    String id = '';
    String role = 'عون حراسة';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إضافة موظف جديد'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'الاسم الكامل'),
              onChanged: (v) => name = v,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'الرقم الإداري'),
              onChanged: (v) => id = v,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () {
              if (name.isNotEmpty && id.isNotEmpty) {
                setState(() {
                  employees.add({
                    'id': id,
                    'name': name,
                    'role': role,
                    'status': 'في العمل',
                    'dutyType': 'عادي',
                    'restDays': ['الأحد'],
                  });
                });
                _saveData();
                Navigator.pop(context);
              }
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(Map<String, dynamic> emp) {
    String currentStatus = emp['status'];
    String currentDuty = emp['dutyType'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('تعديل حالة: ${emp['name']}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: currentStatus,
              items: ['في العمل', 'راحة أسبوعية', 'رخصة/إجازة']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => currentStatus = v!,
              decoration: const InputDecoration(labelText: 'الحالة العامة'),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: currentDuty,
              items: ['عادي', 'حراسة ليلية', 'مداومة']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => currentDuty = v!,
              decoration: const InputDecoration(labelText: 'نوع الخدمة'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                emp['status'] = currentStatus;
                emp['dutyType'] = currentDuty;
              });
              _saveData();
              Navigator.pop(context);
            },
            child: const Text('حفظ التغييرات'),
          ),
        ],
      ),
    );
  }
}
