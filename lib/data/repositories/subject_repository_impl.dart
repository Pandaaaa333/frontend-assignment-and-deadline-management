import 'package:fe_admin_web/domain/entities/subject_entity.dart';
import 'package:fe_admin_web/domain/repositories/subject_repository.dart';

class SubjectRepositoryImpl implements SubjectRepository {
  final List<AdminSubjectModel> _mockSubjects = [
    AdminSubjectModel(id: 'S01', name: 'Khai phá dữ liệu', code: 'IT4040', themeColor: '0xFF4A7DFF', enrolledStudents: 156),
    AdminSubjectModel(id: 'S02', name: 'Đồ án Kiến trúc', code: 'AR3020', themeColor: '0xFF10B981', enrolledStudents: 240),
    AdminSubjectModel(id: 'S03', name: 'Cơ kết cấu', code: 'CE2010', themeColor: '0xFFF59E0B', enrolledStudents: 312),
    AdminSubjectModel(id: 'S04', name: 'Toán cao cấp', code: 'MA1010', themeColor: '0xFF8B5CF6', enrolledStudents: 450),
    AdminSubjectModel(id: 'S05', name: 'Vật lý đại cương', code: 'PH1020', themeColor: '0xFFEC4899', enrolledStudents: 420),
    AdminSubjectModel(id: 'S06', name: 'Trí tuệ nhân tạo', code: 'IT5010', themeColor: '0xFF14B8A6', enrolledStudents: 89),
  ];

  @override
  Future<List<AdminSubjectModel>> getSubjects() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockSubjects;
  }

  @override
  Future<void> saveSubject(AdminSubjectModel subject) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _mockSubjects.indexWhere((s) => s.id == subject.id);
    if (index != -1) {
      _mockSubjects[index] = subject;
    } else {
      _mockSubjects.add(subject);
    }
  }

  @override
  Future<void> deleteSubject(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _mockSubjects.removeWhere((s) => s.id == id);
  }
}
