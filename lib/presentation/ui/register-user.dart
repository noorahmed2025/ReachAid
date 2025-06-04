import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:reachaid/data/shared-preferences/shared-preferences-helper.dart';
import 'package:reachaid/presentation/ui/login-user.dart';
import 'package:reachaid/user-type.dart';
import 'bottom-nav-screen.dart';
import '../components/rounded-corner-button.dart';

class RegisterUserScreen extends StatefulWidget {
  const RegisterUserScreen({super.key});

  @override
  State<RegisterUserScreen> createState() => _RegisterUserScreenState();
}

class _RegisterUserScreenState extends State<RegisterUserScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _mobileNumber;
  String? _password;
  String? _confirmPassword;
  String? _userName;
  int? _userAge;
  String? _gender;
  String? _medicalHistory;
  String _countryCode = '+97';
  bool _isConfirmPasswordVisible = false;
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('تسجيل'),
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
                  decoration: InputDecoration(
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
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'تآكيد كلمة المرور',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isConfirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                  ),
                  obscureText: _isConfirmPasswordVisible == false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يجب ادخال تآكيد كلمة المرور';
                    }
                    if (value != _password) {
                      return 'كلمة المرور و تآكيد كلمة المرور غير متطابقين';
                    }
                    return null;
                  },
                  onSaved: (value) => _confirmPassword = value,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'اسم المستخدم',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يجب ادخال اسم المستخدم';
                    }
                    return null;
                  },
                  onSaved: (value) => _userName = value,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'عمر المستخدم',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يجب ادخال عمر المستخدم';
                    }
                    if (int.tryParse(value) == null) {
                      return 'ادخل عمر صحيح';
                    }
                    return null;
                  },
                  onSaved: (value) => _userAge = int.tryParse(value!),
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('الجنس'),
                    Row(
                      children: <Widget>[
                        Radio<String>(
                          value: 'male',
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value;
                            });
                          },
                        ),
                        const Text('ذكر'),
                        Radio<String>(
                          value: 'female',
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value;
                            });
                          },
                        ),
                        const Text('انثي'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'مشاكل صحية يعاني منها المستخدم',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  onSaved: (value) => _medicalHistory = value,
                ),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginUserScreen()),
                      );
                    },
                    child: Text(
                      'لديك حساب بالفعل؟ تسجيل دخول',
                      style: TextStyle(
                        color: Colors.red,
                        decoration: TextDecoration.underline,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: RoundedCornerButton(
                      text: 'تسجيل',
                      color: Colors.red,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          SharedPreferencesHelper.saveBool(
                              SharedPreferencesHelper.USER_LOGGED_IN, true);
                          SharedPreferencesHelper.saveInt(
                              SharedPreferencesHelper.USER_TYPE,
                              UserType.User.value);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BottomNavScreen(
                                      userType: UserType.User,
                                    )),
                            (Route<dynamic> route) => false,
                          );
                          print('Mobile Number: $_countryCode $_mobileNumber');
                          print('Password: $_password');
                          print('User Name: $_userName');
                          print('User Age: $_userAge');
                          print('Gender: $_gender');
                          print('Medical History: $_medicalHistory');
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
