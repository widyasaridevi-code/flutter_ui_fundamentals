import 'package:flutter/material.dart';

const String studentName = 'Komang Widyasari Devi';
const String studentId = '2415051078';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course Explorer',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const ResponsiveShell(),
    );
  }
}

// =====================================================
// DATA COURSE
// =====================================================

const List<Map<String, dynamic>> courses = [
  {
    'title': 'Flutter Dasar',
    'code': 'FL001',
    'credits': 3,
    'status': 'Aktif',
    'description':
        'Mempelajari dasar Flutter, widget, dan struktur aplikasi.',
  },
  {
    'title': 'Dart Programming',
    'code': 'DT001',
    'credits': 3,
    'status': 'Aktif',
    'description':
        'Mempelajari dasar pemrograman menggunakan bahasa Dart.',
  },
  {
    'title': 'Responsive Layout',
    'code': 'RL001',
    'credits': 2,
    'status': 'Aktif',
    'description':
        'Membuat tampilan aplikasi yang menyesuaikan ukuran layar.',
  },
  {
    'title': 'Mobile UI Design',
    'code': 'UI001',
    'credits': 2,
    'status': 'Aktif',
    'description':
        'Mempelajari prinsip dasar desain antarmuka aplikasi mobile.',
  },
  {
    'title': 'Navigation',
    'code': 'NV001',
    'credits': 2,
    'status': 'Aktif',
    'description':
        'Membuat perpindahan halaman dan navigasi aplikasi Flutter.',
  },
  {
    'title': 'User Interaction',
    'code': 'IN001',
    'credits': 2,
    'status': 'Aktif',
    'description':
        'Menangani tap, button, gesture, form, dan feedback pengguna.',
  },
];

// =====================================================
// RESPONSIVE SHELL
// =====================================================

class ResponsiveShell extends StatefulWidget {
  const ResponsiveShell({super.key});

  @override
  State<ResponsiveShell> createState() => _ResponsiveShellState();
}

class _ResponsiveShellState extends State<ResponsiveShell> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    HomePage(),
    CoursesPage(),
    ProfilePage(),
    FeedbackPage(),
  ];

  Widget buildNavigationBar() {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) {
        setState(() {
          selectedIndex = index;
        });
      },
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.school_outlined),
          selectedIcon: Icon(Icons.school),
          label: 'Courses',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          label: 'Profile',
        ),
        NavigationDestination(
          icon: Icon(Icons.feedback_outlined),
          selectedIcon: Icon(Icons.feedback),
          label: 'Feedback',
        ),
      ],
    );
  }

  Widget buildNavigationRail() {
    return NavigationRail(
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) {
        setState(() {
          selectedIndex = index;
        });
      },
      labelType: NavigationRailLabelType.all,
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: Text('Home'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.school_outlined),
          selectedIcon: Icon(Icons.school),
          label: Text('Courses'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          label: Text('Profile'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.feedback_outlined),
          selectedIcon: Icon(Icons.feedback),
          label: Text('Feedback'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 840) {
          return Scaffold(
            body: pages[selectedIndex],
            bottomNavigationBar: buildNavigationBar(),
          );
        }

        return Scaffold(
          body: Row(
            children: [
              buildNavigationRail(),
              const VerticalDivider(width: 1),
              Expanded(
                child: pages[selectedIndex],
              ),
            ],
          ),
        );
      },
    );
  }
}

// =====================================================
// REUSABLE WIDGET 1
// =====================================================

class StudentIdentity extends StatelessWidget {
  const StudentIdentity({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      '$studentId - $studentName',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

// =====================================================
// HOME PAGE
// =====================================================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Explorer'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StudentIdentity(),

            const SizedBox(height: 32),

            const Icon(
              Icons.school,
              size: 80,
            ),

            const SizedBox(height: 20),

            const Text(
              'Course Explorer',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'Aplikasi sederhana untuk menjelajahi '
              'daftar course mahasiswa.',
              style: TextStyle(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 24),

            const CourseInfoCard(
              title: 'Responsive',
              description:
                  'Tampilan menyesuaikan ukuran layar.',
              icon: Icons.devices,
            ),

            const SizedBox(height: 12),

            const CourseInfoCard(
              title: 'Interactive',
              description:
                  'Course dapat dipilih dan diberi favorite.',
              icon: Icons.touch_app,
            ),

            const SizedBox(height: 12),

            const CourseInfoCard(
              title: 'Feedback',
              description:
                  'Tersedia form feedback dengan validasi.',
              icon: Icons.feedback,
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================
// REUSABLE WIDGET 2
// =====================================================

class CourseInfoCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const CourseInfoCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(
          icon,
          size: 32,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(description),
      ),
    );
  }
}

// =====================================================
// COURSES PAGE
// =====================================================

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  final Set<String> favoriteCourses = {};

  void toggleFavorite(String courseCode) {
    setState(() {
      if (favoriteCourses.contains(courseCode)) {
        favoriteCourses.remove(courseCode);
      } else {
        favoriteCourses.add(courseCode);
      }
    });
  }

  void openCourseDetail(Map<String, dynamic> course) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CourseDetailPage(
          course: course,
          isFavorite: favoriteCourses.contains(
            course['code'],
          ),
          onFavoriteChanged: () {
            toggleFavorite(course['code']);
          },
        ),
      ),
    );
  }

  Widget buildCourseCard(Map<String, dynamic> course) {
    final isFavorite = favoriteCourses.contains(
      course['code'],
    );

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          openCourseDetail(course);
        },
        onLongPress: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${course['title']} - ${course['code']}',
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    child: Icon(Icons.school),
                  ),

                  const Spacer(),

                  IconButton(
                    onPressed: () {
                      toggleFavorite(course['code']);
                    },
                    icon: Icon(
                      isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Text(
                course['title'],
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                '${course['code']} • '
                '${course['credits']} SKS',
              ),

              const SizedBox(height: 8),

              Text(
                course['description'],
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          int columns;

          if (constraints.maxWidth < 600) {
            columns = 1;
          } else if (constraints.maxWidth < 840) {
            columns = 2;
          } else {
            columns = 3;
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const StudentIdentity(),

                const SizedBox(height: 24),

                const Text(
                  'Daftar Course',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                GridView.builder(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(),
                  itemCount: courses.length,
                  gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.35,
                  ),
                  itemBuilder: (context, index) {
                    return buildCourseCard(
                      courses[index],
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// =====================================================
// COURSE DETAIL PAGE
// =====================================================

class CourseDetailPage extends StatefulWidget {
  final Map<String, dynamic> course;
  final bool isFavorite;
  final VoidCallback onFavoriteChanged;

  const CourseDetailPage({
    super.key,
    required this.course,
    required this.isFavorite,
    required this.onFavoriteChanged,
  });

  @override
  State<CourseDetailPage> createState() =>
      _CourseDetailPageState();
}

class _CourseDetailPageState
    extends State<CourseDetailPage> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
  }

  void toggleFavorite() {
    widget.onFavoriteChanged();

    setState(() {
      isFavorite = !isFavorite;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavorite
              ? 'Course ditambahkan ke favorite.'
              : 'Course dihapus dari favorite.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final course = widget.course;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Detail'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const StudentIdentity(),

            const SizedBox(height: 32),

            const Center(
              child: Icon(
                Icons.school,
                size: 90,
              ),
            ),

            const SizedBox(height: 24),

            Text(
              course['title'],
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              'Code: ${course['code']}',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Credits: ${course['credits']} SKS',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Status: ${course['status']}',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              course['description'],
              style: const TextStyle(
                fontSize: 17,
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: toggleFavorite,
                icon: Icon(
                  isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                ),
                label: Text(
                  isFavorite
                      ? 'Favorite'
                      : 'Tambah Favorite',
                ),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Kembali'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================
// PROFILE PAGE
// =====================================================

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const StudentIdentity(),

            const SizedBox(height: 32),

            const CircleAvatar(
              radius: 55,
              child: Icon(
                Icons.person,
                size: 60,
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Profile Mahasiswa',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            const Card(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('Nama'),
                subtitle: Text(studentName),
              ),
            ),

            const SizedBox(height: 12),

            const Card(
              child: ListTile(
                leading: Icon(Icons.badge),
                title: Text('NIM'),
                subtitle: Text(studentId),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================
// FEEDBACK PAGE
// =====================================================

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() =>
      _FeedbackPageState();
}

class _FeedbackPageState
    extends State<FeedbackPage> {
  final formKey = GlobalKey<FormState>();

  final commentController =
      TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  Future<void> submitFeedback() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    await Future.delayed(
      const Duration(seconds: 2),
    );

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Feedback berhasil dikirim.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const StudentIdentity(),

              const SizedBox(height: 24),

              const Text(
                'Form Feedback',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              TextFormField(
                initialValue: studentName,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Nama wajib diisi';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                initialValue: studentId,
                decoration: const InputDecoration(
                  labelText: 'NIM',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'NIM wajib diisi';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: commentController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Komentar',
                  hintText: 'Minimal 5 karakter',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Komentar wajib diisi';
                  }

                  if (value.trim().length < 5) {
                    return 'Komentar minimal 5 karakter';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: isLoading
                      ? null
                      : submitFeedback,
                  icon: const Icon(Icons.send),
                  label: const Text(
                    'Kirim Feedback',
                  ),
                ),
              ),

              const SizedBox(height: 24),

              if (isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}