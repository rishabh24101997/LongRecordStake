import 'package:flutter/material.dart';

class Choice {
  const Choice({this.title, this.icon});

  final IconData icon;
  final String title;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Profile'),
  const Choice(title: 'Affirmations'),
  const Choice(title: 'Vision Board'),
  const Choice(title: 'POSITV'),
];
