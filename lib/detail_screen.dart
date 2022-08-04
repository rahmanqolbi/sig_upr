import 'package:catatanku/edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DetailScreen extends StatelessWidget {
  final int index;
  final Map<String, dynamic> notes;
  DetailScreen({Key? key, required this.notes, required this.index})
      : super(key: key);

  var titleStyle = const TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  var descriptionStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );
  var dateStyle = const TextStyle(
    fontSize: 14,
    color: Colors.grey,
  );

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
                                Navigator.push(context,
                                    MaterialPageRoute(builder: ((context) {
                                  return EditScreen(
                                    index: index,
                                    value: notes,
                                  );
                                })));
                              },
                              color: Colors.white,
                              icon: const Icon(Icons.edit),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          notes['title'],
                          style: titleStyle,
                        ),
                      ),
                      Text(
                        notes['date'],
                        style: dateStyle,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          notes['description'],
                          style: descriptionStyle,
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
