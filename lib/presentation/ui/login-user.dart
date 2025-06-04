import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:reachaid/data/shared-preferences/shared-preferences-helper.dart';
import 'package:reachaid/user-type.dart';
import 'bottom-nav-screen.dart';
import '../components/rounded-corner-button.dart';

class LoginUserScreen extends StatefulWidget {
  const LoginUserScreen({super.key});

  @override
  State<LoginUserScreen> createState() => _LoginUserScreenState();
}

class _LoginUserScreenState extends State<LoginUserScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _mobileNumber;
  String? _password;
  String _countryCode = '+97';
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('تسجيل الدخول'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    CountryCodePicker(
                      onChanged: (CountryCode code) {
                        setState(() {
                          _countryCode = code.dialCode!;
                        });
                      },
                      initialSelection: 'PS',
                      favorite: const ['IL', 'PS'],
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                      alignLeft: false,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'رقم الهاتف',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يجب ادخال رقم الهاتف';
                          }
                          return null;
                        },
                        onSaved: (value) => _mobileNumber = value,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                TextFormField(
                  decoration:  InputDecoration(
                    labelText: 'كلمة المرور',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  obscureText: _isPasswordVisible == false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يجب ادخال كلمة المرور';
                    }
                    return null;
                  },
                  onSaved: (value) => _password = value,
                  onChanged: (value) => _password = value,
                ),

                const SizedBox(height: 24),
                SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: RoundedCornerButton(
                      text: 'تسجيل الدخول',
                      color: Colors.red,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          SharedPreferencesHelper.saveBool(SharedPreferencesHelper.USER_LOGGED_IN, true);
                          SharedPreferencesHelper.saveInt(SharedPreferencesHelper.USER_TYPE, UserType.User.value);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BottomNavScreen(userType: UserType.User,)),
                                (Route<dynamic> route) => false,
                          );
                          print('Mobile Number: $_countryCode $_mobileNumber');
                          print('Password: $_password');
                        }
                      },
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
