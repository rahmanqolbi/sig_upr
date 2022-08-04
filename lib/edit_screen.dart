import 'package:catatanku/notes_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class EditScreen extends StatefulWidget {
  final int? index;
  final Map<String, dynamic>? value;
  const EditScreen({
    Key? key,
    required this.index,
    required this.value,
  }) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late int? index = widget.index;
  late Map<String, dynamic>? value = widget.value;
  NotesPref notesPref = NotesPref();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  void getNote() {
    setState(() {
      titleController.text = value!['title'];
      descriptionController.text = value!['description'];
    });
  }

  void editNote() async {
    var note = {
      'title': titleController.text,
      'date': DateFormat('MMM dd, yyyy').format(DateTime.now()),
      'description': descriptionController.text,
    };
    var editNote = await NotesPref.read('notes');
    editNote[index] = note;
    await NotesPref.save('notes', editNote);
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
  void initState() {
    super.initState();
    getNote();
  }

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
            child: Hero(
              tag: 'noteItem$index',
              child: Material(
                color: const Color(0xFF252525),
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
                                editNote();
                                Navigator.pop(context);
                                Navigator.pop(context);
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
        ),
      ),
    );
  }
}
