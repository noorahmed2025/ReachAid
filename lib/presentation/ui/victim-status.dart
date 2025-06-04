import 'package:flutter/material.dart';
import 'package:reachaid/presentation/ui/bottom-nav-screen.dart';
import 'package:reachaid/user-type.dart';

import '../components/rounded-corner-button.dart';

class VictimStatusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child:
        Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
    child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: double.infinity,
                height: 60,
                child: RoundedCornerButton(
          text: 'تم الانقاذ',
          color: Colors.red,
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => BottomNavScreen(userType: UserType.Rescuer)),
                  (Route<dynamic> route) => false,
            );
            _showAlertDialog(context);
            }
        )
      ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 60,
          child:
            RoundedCornerButton(
                text: 'متوفي',
                color: Colors.red,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BottomNavScreen(userType: UserType.Rescuer)),
                        (Route<dynamic> route) => false,
                  );
                  _showAlertDialog(context);
                }
            )),

          ],
        ),
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            'تم',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}