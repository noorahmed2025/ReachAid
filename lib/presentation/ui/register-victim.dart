import 'package:flutter/material.dart';
import 'package:reachaid/presentation/ui/health_input_screen.dart';
import 'package:reachaid/presentation/ui/victim-status.dart';
import 'package:reachaid/victim-health-state.dart';
import '../components/rounded-corner-button.dart';
import 'package:reachaid/victim-gender.dart';

class RegisterVictim extends StatefulWidget {
  const RegisterVictim({super.key});

  @override
  State<RegisterVictim> createState() => _RegisterVictimState();
}

class _RegisterVictimState extends State<RegisterVictim> {
  final _formKey = GlobalKey<FormState>();
  String? _mobileNumber;
  String? _password;
  String? _confirmPassword;
  String? _victimName;
  int? _victimAge;
  VictimGender? _gender;
  VictimHealthState? _healthState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Opacity(
                  opacity: 1.0,
                  child: Container(
                    child: Image.asset(
                      'assets/images/register-victim.jpeg',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'اسم الضحية',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يجب ادخال اسم الضحية';
                    }
                    return null;
                  },
                  onSaved: (value) => _victimName = value,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'عمر الضحية',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يجب ادخال عمر الضحية';
                    }
                    if (int.tryParse(value) == null) {
                      return 'ادخل عمر صحيح';
                    }
                    return null;
                  },
                  onSaved: (value) => _victimAge = int.tryParse(value!),
                ),

                const SizedBox(height: 16),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('جنس الضحية'),
                    Row(
                      children: <Widget>[
                        Radio<VictimGender>(
                          value: VictimGender.Male,
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value;
                            });
                          },
                        ),
                        const Text('ذكر'),
                        Radio<VictimGender>(
                          value: VictimGender.Female,
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value;
                            });
                          },
                        ),
                        const Text('انثي'),
                        Radio<VictimGender>(
                          value: VictimGender.NotDefined,
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value;
                            });
                          },
                        ),
                        const Text('غير محدد'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('حالة الضحية'),
                    Row(
                      children: <Widget>[
                        Radio<VictimHealthState>(
                          value: VictimHealthState.Stable,
                          groupValue: _healthState,
                          onChanged: (value) {
                            setState(() {
                              _healthState = value;
                            });
                          },
                        ),
                        const Text('مستقرة'),
                        Radio<VictimHealthState>(
                          value: VictimHealthState.Critical,
                          groupValue: _healthState,
                          onChanged: (value) {
                            setState(() {
                              _healthState = value;
                            });
                          },
                        ),
                        const Text('حرجة'),
                        Radio<VictimHealthState>(
                          value: VictimHealthState.Dead,
                          groupValue: _healthState,
                          onChanged: (value) {
                            setState(() {
                              _healthState = value;
                            });
                          },
                        ),
                        const Text('متوفي'),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 24),
                SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: RoundedCornerButton(
                      text: 'التالي',
                      color: Colors.red,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          if (_healthState == VictimHealthState.Dead) {
                            _showAlertDialog(context);
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const HealthInputScreen()),
                            );
                          }
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
