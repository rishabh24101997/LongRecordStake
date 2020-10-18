import 'dart:io';
import 'package:Manifest/Screens/add_vision_board.dart';
import 'package:Manifest/Screens/vision_board_info.dart';
import 'package:flutter/material.dart';
import 'package:Manifest/Theme/theme.dart';
// import 'package:Manifest/Models/vision_board_item.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class VisionBoard extends StatefulWidget {
  @override
  _VisionBoardState createState() => _VisionBoardState();
}

class _VisionBoardState extends State<VisionBoard> {
  var box = Hive.box('visionBoard');
  var boxDarkMode = Hive.box('darkMode');
  // List visionBoardList = [
  //   VisionBoardItem(
  //       title: "My life is filled with joy and abundance 🧡",
  //       image: "https://i.ytimg.com/vi/uojqV6hUEDc/maxresdefault.jpg"),
  //   VisionBoardItem(
  //       title: "I allow only positive and empowering thoughts",
  //       image:
  //           "https://flutterawesome.com/content/images/2019/09/flutter-icons.jpg"),
  //   VisionBoardItem(
  //       title: "I know I believe in myself more than ever",
  //       image:
  //           "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRfcr_0hBqMkgS-YtS28Hsm0qi7f7fuFR6O_Q&usqp=CAU"),
  //   VisionBoardItem(
  //       title: "Everything happens for greater good",
  //       image: "https://i.ytimg.com/vi/uojqV6hUEDc/maxresdefault.jpg"),
  //   VisionBoardItem(
  //       title: "Everything is happening for good reason",
  //       image: "https://i.ytimg.com/vi/uojqV6hUEDc/maxresdefault.jpg"),
  // ];

  // String imagePath;

  @override
  void initState() {
    super.initState();
    // box.clear();
    // box.delete(0);
    // print(box.get(0));
    // print(box.get(1));
    // box.deleteFromDisk();
    // print(box.get(0));
  }

  // Future<void> deleteEntry(index) async {
  //   await box.deleteAt(index);
  // }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: box.listenable(),
      builder: (BuildContext context, Box value, Widget child) {
        // print(value.length);
        // value.delete(0);
        // value.length

        int count = 0;
        for (var i in value.values.toList()) {
          // print(i);
          if (i != null) {
            // if (box.get(widget.fromIndex) == i) {
            //   currAffirmation = count;
            // }
            // affirmations.add(i);
            count++;
          }
        }

        return Scaffold(
          floatingActionButton: FloatingActionButton(
            heroTag: "visionBoard",
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddVisionBoard(
                  isEdit: false,
                  index: null,
                ),
              ));
            },
            child: Icon(Icons.add),
          ),
          body: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        // enableFeedback: true,
                        padding: EdgeInsets.all(8),
                        // splashColor: accentDark,
                        // hoverColor: accentDark,
                        color:
                            boxDarkMode.get(0) ? iconCardDark : iconCardLight,
                        icon: Icon(Icons.info_outline),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VisionBoardInfo(),
                              ));
                        },
                      )
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: count == 0
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 15),
                        child: Padding(
                          padding: const EdgeInsets.all(45),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(0),
                                child: Image.asset(
                                    "assets/images/noitemsvisionboard.png"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    "No items in Vision Board \nTap the button to add some😄",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: boxDarkMode.get(0)
                                            ? textDark
                                            : textLight,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w600)),
                              )
                            ],
                          ),
                        ),
                      )
                    : Container(),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return value.get(index) == null
                      ? Container()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                // margin: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                                elevation: 8,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  child: InkWell(
                                    onLongPress: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                "Delete?",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w700),
                                                maxLines: 2,
                                              ),
                                              content: Text(
                                                  "Are you sure you want to delete this vision card"),
                                              actions: <Widget>[
                                                FlatButton(
                                                  child: Text(
                                                    "Edit",
                                                    style: TextStyle(
                                                      color: accent,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddVisionBoard(
                                                        isEdit: true,
                                                        index: index,
                                                      ),
                                                    ));
                                                  },
                                                ),
                                                FlatButton(
                                                  child: Text(
                                                    "Delete",
                                                    style: TextStyle(
                                                      color: warningColor,
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    // await deleteEntry(index);
                                                    // The value at index is replaced with null
                                                    // because of Hive's bug.
                                                    await box.put(index, null);
                                                    Navigator.of(context).pop();
                                                  },
                                                )
                                              ],
                                            );
                                          });
                                      // print("sjnc");
                                    },
                                    // onTap: () {
                                    //   print("object");
                                    // },
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
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
                                                children: <Widget>[
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Expanded(
                                                      child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    child: Image.file(
                                                      File(value.get(index)[1]),
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
                                                    child: Text(
                                                      value.get(index)[0],
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color:
                                                              boxDarkMode.get(0)
                                                                  ? textDark
                                                                  : textLight,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600),
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
                            )
                          ],
                        );
                }, childCount: value.length),
              ),
              // Image.asset("assets/images/noitems.png")
            ],
          ),
        );
      },
    );
  }
}
