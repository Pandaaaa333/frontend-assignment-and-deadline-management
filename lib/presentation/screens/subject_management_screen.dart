import 'package:flutter/material.dart';
import 'package:fe_admin_web/domain/entities/subject_entity.dart';
import 'package:fe_admin_web/data/repositories/subject_repository_impl.dart';
import 'package:fe_admin_web/presentation/widgets/subject/add_edit_subject_modal.dart';
import 'package:fe_admin_web/presentation/widgets/subject/subject_grid.dart';
import 'package:fe_admin_web/presentation/widgets/subject/subject_management_header.dart';

class SubjectManagementScreen extends StatefulWidget {
  const SubjectManagementScreen({super.key});

  @override
  State<SubjectManagementScreen> createState() =>
      _SubjectManagementScreenState();
}

class _SubjectManagementScreenState extends State<SubjectManagementScreen> {
  final SubjectRepositoryImpl _subjectRepository = SubjectRepositoryImpl();
  late Future<List<AdminSubjectModel>> _subjectsFuture;
  List<AdminSubjectModel> _allSubjects = [];

  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _subjectsFuture = _subjectRepository.getSubjects();
    _subjectsFuture.then((subjects) {
      setState(() {
        _allSubjects = subjects;
      });
    });
  }

  void _saveSubject(String? id, String name, String code) async {
    final subject = AdminSubjectModel(
      id: id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      code: code,
      themeColor: id == null
          ? '0x${(Colors.primaries[DateTime.now().millisecond % Colors.primaries.length].value).toRadixString(16)}'
          : _allSubjects.firstWhere((s) => s.id == id).themeColor,
      enrolledStudents: id == null
          ? 0
          : _allSubjects.firstWhere((s) => s.id == id).enrolledStudents,
    );

    await _subjectRepository.saveSubject(subject);

    // LOAD LẠI DATA THAY VÌ ADD TAY
    final subjects = await _subjectRepository.getSubjects();

    setState(() {
      _allSubjects = List.from(subjects);
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đã lưu môn học thành công!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _deleteSubject(String id) async {
    await _subjectRepository.deleteSubject(id);
    setState(() => _allSubjects.removeWhere((s) => s.id == id));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Đã xóa môn học!'), backgroundColor: Colors.red));
  }

  void _showAddEditSubjectModal([AdminSubjectModel? subject]) {
    showDialog(
      context: context,
      builder: (ctx) => AddEditSubjectModal(
        subject: subject,
        onSave: _saveSubject,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredSubjects = _allSubjects.where((sub) {
      return sub.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          sub.code.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SubjectManagementHeader(
          onSearchChanged: (value) => setState(() => _searchQuery = value),
          onAddSubject: () => _showAddEditSubjectModal(),
        ),
        const SizedBox(height: 24),
        SubjectGrid(
          filteredSubjects: filteredSubjects,
          onEdit: (subject) => _showAddEditSubjectModal(subject),
          onDelete: (id) => _deleteSubject(id),
        ),
      ],
    );
  }
}