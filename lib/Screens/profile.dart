import 'package:flutter/material.dart';
import 'package:Manifest/Widgets/goal_card.dart';
import 'package:Manifest/Widgets/progress_card.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: <Widget>[
        // SliverToBoxAdapter(
        //   child: _buildHeaderSection(),
        // ),
        SliverToBoxAdapter(
          child: GoalCard(),
        ),
        SliverToBoxAdapter(
          child: ProgressCard(),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [],
          ),
        ),
      ],
    );
  }
}
