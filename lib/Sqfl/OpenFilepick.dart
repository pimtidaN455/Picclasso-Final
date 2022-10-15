import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:project_photo_learn/my_style.dart';

class FilesPage extends StatefulWidget {
  final List<PlatformFile> files;
  final ValueChanged<PlatformFile> onOpenedFile;

  const FilesPage({
    Key? key,
    required this.files,
    required this.onOpenedFile,
  }) : super(key: key);

  State<FilesPage> createState() => _FilesPageState();
}

class _FilesPageState extends State<FilesPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: new AppBar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          title: Text(
            "Clound",
            style: TextStyle(
              fontSize: 30,
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold,
              //fontStyle: FontStyle.normal,
              fontFamily: 'Rajdhani',
            ),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.add,
                  color: MyStyle().blackColor,
                ),
                onPressed: (() {})),
            TextButton(
                onPressed: () {},
                child: Text(
                  "Edit ",
                  style: TextStyle(
                    fontSize: 20,
                    color: MyStyle().blackColor,
                    fontWeight: FontWeight.bold,
                    //fontStyle: FontStyle.normal,
                    fontFamily: 'Rajdhani',
                  ),
                ))
          ],
          automaticallyImplyLeading: true,
        ),
        body: Center(
            child: GridView.builder(
                padding: EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: widget.files.length,
                itemBuilder: (context, index) {
                  final file = widget.files[index];

                  return buildFile(file);
                })),
      );

  Widget buildFile(PlatformFile file) {
    final kb = file.size / 1024;
    final mb = kb / 1024;
    final fileSize =
        mb >= 1 ? '${mb.toStringAsFixed(2)} MB' : '${kb.toStringAsFixed(2)} KB';
    final extension = file.extension ?? 'none';
    //print('file path show');
    //print(file.path);
    return InkWell(
        onTap: () => OpenFile.open(file.path),
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.amber[400],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '.$extension',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              )),
              const SizedBox(height: 8),
              Text(
                file.name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                fileSize,
                style: TextStyle(fontSize: 16),
              ),
              Text(
                file.path.toString(),
                style: TextStyle(fontSize: 16),
              )
            ],
          ),
        ));
  }
}
/*import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:project_photo_learn/my_style.dart';

class FilesPage extends StatefulWidget {
  final List<PlatformFile> files;
  final ValueChanged<PlatformFile> onOpenedFile;

  const FilesPage({
    Key? key,
    required this.files,
    required this.onOpenedFile,
  }) : super(key: key);

  State<FilesPage> createState() => _FilesPageState();
}

class _FilesPageState extends State<FilesPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: new AppBar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          title: Text(
            "Clound",
            style: TextStyle(
              fontSize: 30,
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold,
              //fontStyle: FontStyle.normal,
              fontFamily: 'Rajdhani',
            ),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.add,
                  color: MyStyle().blackColor,
                ),
                onPressed: (() {})),
            TextButton(
                onPressed: () {},
                child: Text(
                  "Edit ",
                  style: TextStyle(
                    fontSize: 20,
                    color: MyStyle().blackColor,
                    fontWeight: FontWeight.bold,
                    //fontStyle: FontStyle.normal,
                    fontFamily: 'Rajdhani',
                  ),
                ))
          ],
          automaticallyImplyLeading: true,
        ),
        body: Center(
            child: GridView.builder(
                padding: EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: widget.files.length,
                itemBuilder: (context, index) {
                  final file = widget.files[index];

                  return buildFile(file);
                })),
      );

  Widget buildFile(PlatformFile file) {
    final kb = file.size / 1024;
    final mb = kb / 1024;
    final fileSize =
        mb >= 1 ? '${mb.toStringAsFixed(2)} MB' : '${kb.toStringAsFixed(2)} KB';
    final extension = file.extension ?? 'none';
    //print('file path show');
    //print(file.path);
    return InkWell(
        onTap: () => OpenFile.open(file.path),
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.amber[400],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '.$extension',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              )),
              const SizedBox(height: 8),
              Text(
                file.name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                fileSize,
                style: TextStyle(fontSize: 16),
              ),
              Text(
                file.path.toString(),
                style: TextStyle(fontSize: 16),
              )
            ],
          ),
        ));
  }
}*/
