import 'package:flutter/material.dart';
import 'package:reachaid/presentation/ui/select-user-type.dart';

import '../../data/shared-preferences/shared-preferences-helper.dart';
import '../../user-type.dart';
import '../components/rounded-corner-button.dart';
import 'bottom-nav-screen.dart';

class SplashNavigatorPage extends StatefulWidget {
  const SplashNavigatorPage({Key? key}) : super(key: key);

  @override
  State<SplashNavigatorPage> createState() => _SplashNavigatorPageState();
}

class _SplashNavigatorPageState extends State<SplashNavigatorPage> {
  bool? isLoggedIn;
  int? userType;

  @override
  void initState() {
    super.initState();
    _loadLoginStatus();
  }

  Future<void> _loadLoginStatus() async {
    isLoggedIn = await SharedPreferencesHelper.getBool(SharedPreferencesHelper.USER_LOGGED_IN);
    userType = await SharedPreferencesHelper.getInt(SharedPreferencesHelper.USER_TYPE);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == null || userType == null) {
      return const SplashScreen();
    }

    if (isLoggedIn == true) {
      if (userType == UserType.User.value) {
        return BottomNavScreen(userType: UserType.User);
      } else {
        return BottomNavScreen(userType: UserType.Rescuer);
      }
    } else if (isLoggedIn == false) {
      return const SplashScreen();
    }
    return const Center(child: CircularProgressIndicator());
  }
}


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 15),
              alignment: Alignment.topCenter,
              child: Image.asset(
                'assets/images/reach-aid.jpg',
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 70, 50, 0),
              child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: RoundedCornerButton(
                    text: 'تسجيل الدخول',
                    color: Colors.red,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SelectUserType()),
                      );
                    },
                  )),
            ),
          ],
        ),
      );
    }
}
