
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../providers/course_state.dart';
import '../widgets/student_identity.dart';

class EditCoursePage extends StatefulWidget {
  final Course course;

  const EditCoursePage({
    super.key,
    required this.course,
  });

  @override
  State<EditCoursePage> createState() => _EditCoursePageState();
}

class _EditCoursePageState extends State<EditCoursePage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _creditsController;
  late final TextEditingController _categoryController;

  late String _selectedStatus;

  final List<String> _statuses = [
    'planned',
    'active',
    'done',
  ];

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(
      text: widget.course.title,
    );

    _creditsController = TextEditingController(
      text: widget.course.credits.toString(),
    );

    _categoryController = TextEditingController(
      text: widget.course.category,
    );

    _selectedStatus = _statuses.contains(widget.course.status)
        ? widget.course.status
        : 'planned';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _creditsController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  Future<void> _saveCourse() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final courseId = widget.course.id;

    if (courseId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal memperbarui: ID course tidak ditemukan.'),
        ),
      );
      return;
    }

    final updatedCourse = Course(
      id: courseId,
      code: widget.course.code,
      title: _titleController.text.trim(),
      credits: int.parse(_creditsController.text.trim()),
      status: _selectedStatus,
      category: _categoryController.text.trim(),
    );

    final courseState = context.read<CourseState>();
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    try {
      await courseState.updateCourse(updatedCourse);

      if (!mounted) return;

      messenger.showSnackBar(
        const SnackBar(
          content: Text('Course berhasil diperbarui.'),
        ),
      );

      navigator.pop(updatedCourse);
    } catch (e) {
      if (!mounted) return;

      messenger.showSnackBar(
        SnackBar(
          content: Text('Gagal memperbarui course: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Course'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StudentIdentity(),
            const SizedBox(height: 24),
            const Text(
              'Perbarui Informasi Course',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Ubah informasi yang diperlukan, lalu simpan.',
            ),
            const SizedBox(height: 24),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: widget.course.code,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Kode Course',
                      border: OutlineInputBorder(),
                      helperText: 'Kode course tidak dapat diubah.',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Course',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Nama course wajib diisi.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _creditsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Jumlah SKS',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      final credits = int.tryParse(
                        value?.trim() ?? '',
                      );

                      if (credits == null || credits < 1) {
                        return 'Masukkan jumlah SKS minimal 1.';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    initialValue: _selectedStatus,
                    decoration: const InputDecoration(
                      labelText: 'Status Course',
                      border: OutlineInputBorder(),
                    ),
                    items: _statuses.map((status) {
                      return DropdownMenuItem<String>(
                        value: status,
                        child: Text(status),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedStatus = value;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _categoryController,
                    decoration: const InputDecoration(
                      labelText: 'Kategori Course',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Kategori course wajib diisi.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  Consumer<CourseState>(
                    builder: (context, state, child) {
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: state.isSaving
                              ? null
                              : _saveCourse,
                          icon: state.isSaving
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.save),
                          label: Text(
                            state.isSaving
                                ? 'Menyimpan...'
                                : 'Simpan Perubahan',
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Batal'),
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
