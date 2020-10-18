import 'dart:io';

import 'package:Manifest/Screens/select_affirmations.dart';
import 'package:Manifest/Theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:hive/hive.dart';
import 'package:Manifest/Widgets/toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class AddVisionBoard extends StatefulWidget {
  const AddVisionBoard({Key key, this.isEdit, this.index}) : super(key: key);

  final bool isEdit;
  final int index;

  @override
  _AddVisionBoardState createState() => _AddVisionBoardState();
}

class _AddVisionBoardState extends State<AddVisionBoard> {
  var box = Hive.box('visionBoard');
  var boxDarkMode = Hive.box('darkMode');
  String visionBoardText = '';
  TextEditingController visionBoardController;

  CustomToast _toast = CustomToast();

  File _image;
  String imagePath;
  final picker = ImagePicker();

  Directory appDocDir;
  String appDocPath;
  String imageName;

  var uuid;

  @override
  void initState() {
    initAsyncVariables();
    visionBoardController = TextEditingController();

    visionBoardText = widget.isEdit ? box.get(widget.index)[0] : "I am so happy and grateful now that ...";
    visionBoardController.value = TextEditingValue(text: visionBoardText);
    _image = widget.isEdit ? File(box.get(widget.index)[1]) : null;
    imagePath = widget.isEdit ? box.get(widget.index)[1] : null;

    uuid = Uuid();

    super.initState();
  }

  Future<void> initAsyncVariables() async {
    Directory tempappDocDir = await getApplicationDocumentsDirectory();
    String tempappDocPath = tempappDocDir.path;
    setState(() {
      appDocDir = tempappDocDir;
      appDocPath = tempappDocPath;
    });

    // if (await File('$appDocPath/image1.png').exists()) {
    //   print("File exists");
    // } else {
    //   print("File don't exists");
    // }
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    String tempimageName;

    tempimageName = uuid.v4();
    // bool condition = true;
    while (await File('$appDocPath/$tempimageName.png').exists()) {
      tempimageName = uuid.v4();
    }

    print("tempimageName " + tempimageName);
    print(
        "\$appDocPath/\$tempimageName.png " + '$appDocPath/$tempimageName.png');

    File temp;
    try {
      temp = await File(pickedFile.path).copy('$appDocPath/$tempimageName.png');
      // temp = File(pickedFile.path);
      // await compressAndGetFile(temp, '$appDocPath/$tempimageName.png');
      print("Copied");
      // print(appDocPath);
    } catch (e) {
      print(e);
    }

    setState(() {
      _image = temp;
      imageName = tempimageName;
      imagePath = '$appDocPath/$imageName.png';
    });
  }

  Future<File> compressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 50,
    );

    print("LENGTH: " + file.lengthSync().toString());
    print(result.lengthSync());

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          heroTag: "visionBoard",
          child: Icon(Icons.done),
          onPressed: () async {
            if (visionBoardText.length < 1) {
              _toast.showToast(
                  context, Icons.close, "Enter valid text", warningColor);
              return;
            }

            if (_image == null) {
              _toast.showToast(
                  context, Icons.close, "Please select an image", warningColor);
              return;
            }
            // var list = box.values.toList();
            // for (var i in list) {
            //   if (i == visionBoardText) {
            //     _toast.showToast(context, Icons.close,
            //         "Same affirmation already added.", accentDark);
            //     return;
            //   }
            // }

            // int length = 0;

            // await FirebaseDatabase.instance
            //     .reference()
            //     .child("backUpData")
            //     .child(FirebaseAuth.instance.currentUser.uid)
            //     .child("visionBoard")
            //     .once()
            //     .then((DataSnapshot dataSnapshot) {
            //   length = dataSnapshot.value ?? {}.length ?? 0;
            //   // print(dataSnapshot.value ?? {}.length ?? 0);
            // });

            // final StorageReference storageReference = FirebaseStorage()
            //     .ref()
            //     .child("images")
            //     .child(FirebaseAuth.instance.currentUser.uid)
            //     .child(length.toString() + ".jpg");

            // final StorageUploadTask uploadTask =
            //     storageReference.putFile(File(imagePath), StorageMetadata());

            await box.put(widget.index ?? box.length,
                [visionBoardText, imagePath]).then((value) {
              _toast.showToast(context, Icons.done, "Photo added.", greenColor);
              _toast.showToast(context, Icons.remove_circle,
                  "Long click to edit", warningColor);
              Navigator.pop(context);
            });
          },
        ),
        appBar: AppBar(
          title: Text("Add a Photo"),
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, right: 15, left: 15),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Center(
                      //   child: Hero(
                      //     tag: "visionBoard",
                      //     child: SizedBox(
                      //       child: Container(
                      //         height: MediaQuery.of(context).size.height / 8,
                      //         width: MediaQuery.of(context).size.height / 8,
                      //         decoration: BoxDecoration(
                      //             color: Colors.blue,
                      //             borderRadius: BorderRadius.circular(
                      //               MediaQuery.of(context).size.height / 8,
                      //             )),
                      //         child: Icon(
                      //           Icons.add_a_photo,
                      //           size: MediaQuery.of(context).size.height / 18,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // Text(
                      //   "Add a photo",
                      //   style: TextStyle(fontSize: 20),
                      // ),
                      // SizedBox(
                      //   height: 40,
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(vertical: 0),
                      //   child: TextField(
                      //     onChanged: (value) {
                      //       setState(() {
                      //         affirmation = value;
                      //       });
                      //     },
                      //     controller: affirmationController,
                      //     scrollPhysics: BouncingScrollPhysics(),
                      //     // minLines: 2,
                      //     // maxLines: 4,
                      //     keyboardType: TextInputType.multiline,
                      //     cursorColor: textHighlightDark,
                      //     decoration: InputDecoration(
                      //         // border: InputBorder.none,
                      //         hintText: 'Type your affirmation here'),
                      //   ),
                      // ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        // margin: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                        elevation: 8,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: InkWell(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(8),
                                  color: boxDarkMode.get(0)
                                      ? primaryDark
                                      : primaryLight,
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                            width: 8,
                                          ),
                                          _image == null
                                              ? Center(
                                                  child: RaisedButton.icon(
                                                    icon: Icon(Icons.add,
                                                        color: textDark),
                                                    label: Text(
                                                      "Select photo",
                                                      style: TextStyle(
                                                          color: textDark),
                                                    ),
                                                    onPressed: () {
                                                      getImage();
                                                    },
                                                  ),
                                                )
                                              : Expanded(
                                                  child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: Image.file(
                                                    _image,
                                                    fit: BoxFit.contain,
                                                  ),
                                                )),
                                          SizedBox(
                                            width: 8,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  color: boxDarkMode.get(0)
                                      ? primaryDark
                                      : primaryLight,
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                            child: TextField(
                                              onChanged: (value) {
                                                setState(() {
                                                  visionBoardText = value;
                                                });
                                              },
                                              controller: visionBoardController,
                                              scrollPhysics:
                                                  BouncingScrollPhysics(),
                                              // minLines: 2,
                                              // maxLines: 4,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              cursorColor: secondary,
                                              decoration: InputDecoration(
                                                  // border: InputBorder.none,
                                                  hintText:
                                                      'Type your affirmation here'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RaisedButton.icon(
                          onPressed: () {
                            setState(() {
                              _image = null;
                            });
                          },
                          icon: Icon(Icons.delete_outline, color: textDark),
                          color: warningColor,
                          splashColor:
                              boxDarkMode.get(0) ? primaryDark : primaryLight,
                          label: Text("Remove Photo",
                              style: TextStyle(color: textDark)))
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(vertical: 10),
                      //   child: Align(
                      //     alignment: Alignment.topLeft,
                      //     child: Text(
                      //       "Or choose from below:",
                      //       style: TextStyle(
                      //           fontSize: 16, color: boxDarkMode.get(0) ? boxDarkMode.get(0) ? textSubtitleDark : textSubtitleLight : textSubtitleLight),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.width,
                      //   // width: MediaQuery.of(context).size.width - 20,
                      //   // flex: 2,
                      //   child: GridView.count(
                      //     physics: BouncingScrollPhysics(),
                      //     // shrinkWrap: true,
                      //     crossAxisCount: 2,
                      //     children: [
                      //       stackCard("assets/images/money.png",
                      //           "Money Affirmations"),
                      //       stackCard("assets/images/happiness.png",
                      //           "Life Affirmations"),
                      //       stackCard("assets/images/health.png",
                      //           "Health Affirmations"),
                      //       stackCard("assets/images/confidence.png",
                      //           "Confidence Affirmations")
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                ))));
  }
}
