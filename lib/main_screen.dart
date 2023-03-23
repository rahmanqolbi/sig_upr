import 'package:catatanku/detail_screen.dart';
import 'package:catatanku/insert_screen.dart';
import 'package:catatanku/notes_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var saveNotes = [];
  List colors = [
    Colors.indigo,
    Colors.green,
    Colors.pink,
    Colors.cyan,
    Colors.purple,
    Colors.lightGreen,
    Colors.red,
    Colors.deepPurple,
    Colors.amber,
    Colors.teal,
    Colors.deepOrange,
    Colors.blue,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.brown,
    Colors.blueGrey,
  ];

  onGoBack() {
    getSaveNotes();
    setState(() {});
  }

  getSaveNotes() async {
    var notes = await NotesPref.read('notes');
    setState(() {
      saveNotes = notes;
    });
  }

  void deleteNote(index) async {
    var saveNotes = await NotesPref.read('notes');
    saveNotes.removeAt(index);

    await NotesPref.save('notes', saveNotes);
    onGoBack();
  }

  @override
  void initState() {
    super.initState();
    getSaveNotes();
  }

  var titleAppStyle = const TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  var titleStyle = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  var dateStyle = const TextStyle(
    fontSize: 14,
    color: Colors.black54,
  );

  var deleteButtonStyle = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  void _showDialog(BuildContext context, index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentTextStyle: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w400),
            titleTextStyle: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
            title: const Text('Hapus Catatan'),
            backgroundColor: const Color(0xFF252525),
            content: const Text('Hapus 1 Item?'),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    const Color(0xFF252525),
                  ),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
                onPressed: () {
                  deleteNote(index);
                  Navigator.pop(context);
                },
                child: const Text('Hapus'),
              ),
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
                child: const Text('Batal'),
              ),
            ],
          );
        }).then((_) => setState(() {
          getSaveNotes();
        }));
  }

  @override
  Widget build(BuildContext context) {
    var mediaWidth = MediaQuery.of(context).size.width;
    if (saveNotes.isEmpty) {
      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(statusBarColor: Color(0xFF252525)),
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xFF252525),
            onPressed: (() {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) {
                    return const InsertScreen(
                      index: null,
                      value: null,
                    );
                  }),
                ),
              ).then((value) => getSaveNotes());
            }),
            child: const Icon(Icons.add),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: mediaWidth > 600
                      ? const EdgeInsets.only(
                          bottom: 32, top: 16, left: 32, right: 32)
                      : const EdgeInsets.only(
                          bottom: 32, top: 16, left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Catatanku',
                        style: titleAppStyle,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFF3B3B3B),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          color: Colors.white,
                          icon: const Icon(Icons.search),
                        ),
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      'Silahkan Menuliskan Catatan Dengan Cara Tekan Tombol (+) Di Pojok Kanan Bawah',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white54, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(statusBarColor: Color(0xFF252525)),
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xFF252525),
            onPressed: (() {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) {
                    return const InsertScreen(
                      index: null,
                      value: null,
                    );
                  }),
                ),
              ).then((value) => getSaveNotes());
            }),
            child: const Icon(Icons.add),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: mediaWidth > 600
                      ? const EdgeInsets.only(
                          bottom: 32, top: 16, left: 32, right: 32)
                      : const EdgeInsets.only(
                          bottom: 32, top: 16, left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Catatanku',
                        style: titleAppStyle,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFF3B3B3B),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          color: Colors.white,
                          icon: const Icon(Icons.search),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth <= 600) {
                      return NotesList();
                    } else if (constraints.maxWidth <= 1200) {
                      return NotesGrid(gridCount: 4);
                    } else {
                      return NotesGrid(gridCount: 6);
                    }
                  },
                )),
              ],
            ),
          ),
        ),
      );
    }
  }

  GridView NotesGrid({gridCount}) {
    return GridView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 32),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gridCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: saveNotes.length,
        itemBuilder: (context, index) {
          return Hero(
            tag: 'noteItem$index',
            child: Material(
              color: const Color(0xFF252525),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) {
                        return DetailScreen(
                          index: index,
                          notes: saveNotes[index],
                        );
                      }),
                    ),
                  ).then((_) => onGoBack());
                },
                child: Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: colors[index % colors.length],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              saveNotes[index]['title'],
                              style: titleStyle,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text(
                              saveNotes[index]['date'],
                              style: dateStyle,
                            ),
                          ],
                        ),
                      ),
                      PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            onTap: () {
                              Future.delayed(const Duration(seconds: 0),
                                  () => _showDialog(context, index));
                            },
                            child: Text('Hapus', style: deleteButtonStyle),
                          ),
                        ],
                        color: const Color(0xFF3B3B3B),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  ListView NotesList() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 16,
        );
      },
      itemCount: saveNotes.length,
      itemBuilder: (context, index) {
        return Hero(
          tag: 'noteItem$index',
          child: Material(
            color: const Color(0xFF252525),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return DetailScreen(
                    index: index,
                    notes: saveNotes[index],
                  );
                }))).then((_) => onGoBack());
              },
              child: Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: colors[index % colors.length],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            saveNotes[index]['title'],
                            style: titleStyle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            saveNotes[index]['date'],
                            style: dateStyle,
                          ),
                        ],
                      ),
                    ),
                    PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          onTap: () {
                            Future.delayed(const Duration(seconds: 0),
                                () => _showDialog(context, index));
                          },
                          child: Text('Hapus', style: deleteButtonStyle),
                        ),
                      ],
                      color: const Color(0xFF3B3B3B),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
