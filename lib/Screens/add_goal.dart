import 'package:Manifest/Theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:Manifest/Widgets/toast.dart';

class AddGoal extends StatefulWidget {
  const AddGoal({Key key, this.isEdit, this.index}) : super(key: key);

  final int index;
  final bool isEdit;

  @override
  _AddGoalState createState() => _AddGoalState();
}

class _AddGoalState extends State<AddGoal> {
  var box = Hive.box('goals');
  String goal;
  TextEditingController goalController;
  String plan;
  TextEditingController planController;

  CustomToast _toast = CustomToast();

  @override
  void initState() {
    goalController = TextEditingController();
    planController = TextEditingController();
    goal = widget.isEdit ? box.get(widget.index)[0] : "";
    plan = widget.isEdit ? box.get(widget.index)[1] : "";
    goalController.value = TextEditingValue(text: goal);
    planController.value = TextEditingValue(text: plan);

    

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.done),
          onPressed: () {
            if (goal.length < 10 || plan.length < 10) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        "Alert!",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      content: Text(
                          "Length of Goals and Plans must be greater than 10!"),
                      actions: <Widget>[
                        FlatButton(
                          child: Text(
                            "Okay!",
                            style: TextStyle(
                              color: accent,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  });
              return;
            }

            box.put(widget.isEdit ? widget.index : box.length, [goal, plan]);
            _toast.showToast(context, Icons.done,
                widget.isEdit ? "Goal Edited" : "Goal added", greenColor);
            Navigator.of(context).pop();
            // box.put(3, ["goal", "plan"]);
            // print(box.get(3));
          },
        ),
        appBar: AppBar(
          title: Text(widget.isEdit ? "Edit Goal" : "Add Goal"),
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
                      Hero(
                        tag: "affirmation",
                        child: Center(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height / 5,
                            child: SvgPicture.asset(
                              "assets/images/mind.svg",
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.isEdit ? "Edit your goal✏" : "Add a new goal!🚀",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "*Your Goal",
                            style: TextStyle(fontSize: 20, color: secondary),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 0),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              goal = value;
                            });
                          },
                          controller: goalController,
                          scrollPhysics: BouncingScrollPhysics(),
                          minLines: 2,
                          maxLines: 4,
                          keyboardType: TextInputType.multiline,
                          cursorColor: secondary,
                          decoration: InputDecoration(
                              // border: InputBorder.none,
                              hintText:
                                  '(example) By Dec 31st I will have in my possession \$100k)'),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "*Plan to achieve it",
                            style: TextStyle(fontSize: 20, color: secondary),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 0),
                        child: TextField(
                          scrollPhysics: BouncingScrollPhysics(),
                          minLines: 2,
                          maxLines: 4,
                          controller: planController,
                          onChanged: (value) {
                            setState(() {
                              plan = value;
                            });
                          },
                          keyboardType: TextInputType.multiline,
                          cursorColor: secondary,
                          decoration: InputDecoration(
                              // border: InputBorder.none,
                              hintText:
                                  '(example) To achieve my goal, I\'ll be doing my best as a digital marketer and will give mu absolute best'),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      widget.isEdit && widget.index != 0
                          ? RaisedButton(
                              child: Text("Delete Goal",
                                  style: TextStyle(color: textDark)),
                              splashColor: primaryDark,
                              color: warningColor,
                              onPressed: () {
                                box.put(widget.index, null);
                                Navigator.of(context).pop();
                              },
                            )
                          : Container(),
                      Text("Vector art by Freepik"),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ))));
  }
}
