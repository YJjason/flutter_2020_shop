import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  Map arguments;
  UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('用户组件'),
    );
  }
}
