import 'package:flutter/material.dart';
import 'package:frontend/app/modules/user/user_listwidget.dart';
import 'package:get/get.dart';

class UserPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (_){
        return Scaffold(
          body: UserList(),
        );
      }
    );
  }
}