import 'package:flutter/material.dart';
import 'package:frontend/app/data/models/user_model.dart';
import 'package:frontend/app/modules/user/user_controller.dart';
import 'package:get/get.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<UserController>(
      init: UserController(),
      builder: (_){
        if(_.loading){
          return Center(
            child: LinearProgressIndicator(),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text("Usuários"),
          ),
          body: SingleChildScrollView(
            child: Container(
              color: Colors.grey[300],
              height: MediaQuery.of(context).size.height / 0.8,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2
                ),
                itemCount:  _.user.length == 0 ? 0 : _.user.length,
                itemBuilder: (context, index){
                  final UserModel user = _.user[index];
                  return Column(
                    children: [
                      Text(user.name),
                        Text(user.cpf),
                        Text(user.birth.toIso8601String()),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      }        
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:frontend/app/data/models/user_model.dart';
// import 'package:frontend/app/modules/user/user_controller.dart';
// import 'package:get/get.dart';

// class UserList extends GetView<UserController> {
//   const UserList({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<UserController>(
//       
//   }

// }