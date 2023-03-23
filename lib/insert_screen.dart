import 'package:catatanku/notes_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class InsertScreen extends StatefulWidget {
  final int? index;
  final Map<String, dynamic>? value;
  const InsertScreen({
    Key? key,
    required this.index,
    required this.value,
  }) : super(key: key);

  @override
  State<InsertScreen> createState() => _InsertScreenState();
}

class _InsertScreenState extends State<InsertScreen> {
  NotesPref notesPref = NotesPref();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  void saveNote() async {
    var note = {
      'title': titleController.text,
      'date': DateFormat('MMM dd, yyyy').format(DateTime.now()),
      'description': descriptionController.text,
    };
    var saveNote = await NotesPref.read('notes');
    if (note['title'] == '' && note['description'] == '') {
      _showDialog(context);
    } else {
      saveNote.insert(0, note);
      await NotesPref.save('notes', saveNote);
      Navigator.pop(context);
    }
  }

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentTextStyle: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w400),
            titleTextStyle: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
            title: const Text('Catatan Kosong'),
            backgroundColor: const Color(0xFF252525),
            content: const Text(
                'Catatan harus terisi terlebih dahulu agar dapat disimpan'),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    const Color(0xFF252525),
                  ),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Oke'),
              ),
            ],
          );
        });
  }

  var titleStyle = const TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: Colors.white30,
  );

  var descriptionStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.white30,
  );
  var titleInputStyle = const TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  var descriptionInputStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaWidth = MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Color(0xFF252525)),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: mediaWidth > 600
                ? const EdgeInsets.symmetric(horizontal: 32, vertical: 16)
                : const EdgeInsets.all(16),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFF3B3B3B)),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: Colors.white,
                          icon: const Icon(Icons.arrow_back_ios_new),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFF3B3B3B)),
                        child: IconButton(
                          onPressed: () {
                            saveNote();
                          },
                          color: Colors.white,
                          icon: const Icon(Icons.save_outlined),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: TextField(
                      controller: titleController,
                      style: titleInputStyle,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: titleStyle,
                        hintText: 'Judul',
                      ),
                    ),
                  ),
                  TextField(
                    controller: descriptionController,
                    style: descriptionInputStyle,
                    maxLines: 20,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: descriptionStyle,
                      hintText: 'Mulai Mengetik',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
