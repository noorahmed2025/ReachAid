import 'package:flutter/material.dart';
import 'package:reachaid/presentation/ui/register-victim.dart';
import '../components/rounded-corner-button.dart';

class RescuerScreen extends StatelessWidget {
  const RescuerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 288),
              SizedBox(
                  height: 60,
                  child: RoundedCornerButton(
                    text: 'تسجيل ضحية',
                    color: Colors.red,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterVictim()),
                      );
                    },
                  )),
              const SizedBox(height: 24),
              SizedBox(
                  height: 60,
                  child: RoundedCornerButton(
                    text: 'عرض ضحايا',
                    color: Colors.red,
                    onPressed: () {},
                  )),
              const SizedBox(height: 24),
              SizedBox(
                  height: 60,
                  child: RoundedCornerButton(
                    text: 'طلب مساعدة',
                    color: Colors.red,
                    onPressed: () {},
                  )),
            ],
          ),
        ));
  }
}
