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
      title: 'Tahap 16 - Kasus C',
      home: const CaseCPage(),
    );
  }
}

class CaseCPage extends StatefulWidget {
  const CaseCPage({super.key});

  @override
  State<CaseCPage> createState() => _CaseCPageState();
}

class _CaseCPageState extends State<CaseCPage> {
  final nameController = TextEditingController(
    text: studentName,
  );

  final nimController = TextEditingController(
    text: studentId,
  );

  final commentController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    nimController.dispose();
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 16 - Kasus C'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '$studentId - $studentName',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Kasus C - Keyboard Overflow',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'Form ini dibuat cukup panjang untuk '
              'menguji tampilan ketika keyboard muncul.',
            ),

            const SizedBox(height: 300),

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: nimController,
              decoration: const InputDecoration(
                labelText: 'NIM',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: commentController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Komentar',
                hintText: 'Masukkan komentar',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Form berhasil dikirim.',
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Kirim',
                ),
              ),
            ),

            const SizedBox(height: 40),

            const Center(
              child: Text(
                'SingleChildScrollView membuat form '
                'tetap dapat diakses ketika keyboard muncul.',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}