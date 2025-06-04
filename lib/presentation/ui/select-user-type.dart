import 'package:flutter/material.dart';
import 'package:reachaid/presentation/components/rounded-corner-button.dart';
import 'package:reachaid/presentation/ui/register-user.dart';
import 'package:reachaid/presentation/ui/register-rescuer.dart';

class SelectUserType extends StatelessWidget {
  const SelectUserType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Opacity(
            opacity: 0.1,
            child: Container(
              margin: const EdgeInsets.only(top: 15),
              child: Image.asset(
                'assets/images/select-user-type.jpeg',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(15, 300, 15, 0),
            child: Column(
              children: [
                SizedBox(
                    width: double.infinity,
                    height: 60,
                    child:  RoundedCornerButton(
                  text: 'اسعاف و انقاذ',
                  color: Colors.red,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterRescuer()),
                    );
                  },
                )),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
                  child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child:  RoundedCornerButton(
                      text: 'المستخدم',
                      color: Colors.red,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RegisterUserScreen()),
                        );
                      },
                    ))
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
