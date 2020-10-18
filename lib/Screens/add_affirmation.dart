import 'package:Manifest/Screens/select_affirmations.dart';
import 'package:Manifest/Theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:Manifest/Widgets/toast.dart';

class AddAffirmation extends StatefulWidget {
  @override
  _AddAffirmationState createState() => _AddAffirmationState();
}

class _AddAffirmationState extends State<AddAffirmation> {
  var box = Hive.box('affirmations');
  var boxDarkMode = Hive.box('darkMode');
  String affirmation = '';
  TextEditingController affirmationController;

  CustomToast _toast = CustomToast();

  @override
  void initState() {
    affirmationController = TextEditingController();
    // goal = widget.isEdit ? box.get(widget.index)[0] : "";
    // plan = widget.isEdit ? box.get(widget.index)[1] : "";
    affirmationController.value = TextEditingValue(text: affirmation);

    super.initState();
  }

  Widget stackCard(String image, String title) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SelectAffirmations(
                title: title,
              ),
            ));
      },
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              image,
              fit: BoxFit.fitHeight,
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
              child: Text(
                title,
                style: TextStyle(fontSize: 20, color: textDark),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.done),
          onPressed: () {
            if (affirmation.length < 1) {
              _toast.showToast(context, Icons.close, "Enter valid affirmation",
                  warningColor);
              return;
            }
            var list = box.values.toList();
            for (var i in list) {
              if (i == affirmation) {
                _toast.showToast(context, Icons.close,
                    "Same affirmation already added.", accent);
                return;
              }
            }
            box.put(box.length, affirmation).then((value) {
              FocusScope.of(context).requestFocus(new FocusNode());
              setState(() {
                affirmation = "";
                affirmationController.clear();
              });
              _toast.showToast(
                  context, Icons.done, "Affirmation added.", greenColor);
              _toast.showToast(context, Icons.remove_circle,
                  "Long click to remove", warningColor);
            });
          },
        ),
        appBar: AppBar(
          title: Text("Add Affirmation"),
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
                      Center(
                        child: Hero(
                          tag: "affirmation",
                          child: SizedBox(
                            child: Container(
                              height: MediaQuery.of(context).size.height / 8,
                              width: MediaQuery.of(context).size.height / 8,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.height / 8,
                                  )),
                              child: Icon(
                                Icons.playlist_add,
                                size: MediaQuery.of(context).size.height / 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Add new affirmation🚀",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 0),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              affirmation = value;
                            });
                          },
                          controller: affirmationController,
                          scrollPhysics: BouncingScrollPhysics(),
                          minLines: 2,
                          maxLines: 4,
                          keyboardType: TextInputType.multiline,
                          cursorColor: secondary,
                          decoration: InputDecoration(
                              // border: InputBorder.none,
                              hintText: 'Type your affirmation here'),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Or choose from below:",
                            style: TextStyle(
                                fontSize: 16,
                                color: boxDarkMode.get(0)
                                    ? boxDarkMode.get(0)
                                        ? textSubtitleDark
                                        : textSubtitleLight
                                    : textSubtitleLight),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width,
                        // width: MediaQuery.of(context).size.width - 20,
                        // flex: 2,
                        child: GridView.count(
                          physics: BouncingScrollPhysics(),
                          // shrinkWrap: true,
                          crossAxisCount: 2,
                          children: [
                            stackCard("assets/images/money.png",
                                "Money Affirmations"),
                            stackCard("assets/images/happiness.png",
                                "Life Affirmations"),
                            stackCard("assets/images/health.png",
                                "Health Affirmations"),
                            stackCard("assets/images/confidence.png",
                                "Confidence Affirmations")
                          ],
                        ),
                      )
                    ],
                  ),
                ))));
  }
}
