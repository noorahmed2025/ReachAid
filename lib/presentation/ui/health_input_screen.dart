import 'package:flutter/material.dart';
import 'package:reachaid/presentation/ui/victim-status.dart';

import '../components/rounded-corner-button.dart';

class HealthInputScreen extends StatefulWidget {
  const HealthInputScreen({Key? key}) : super(key: key);

  @override
  State<HealthInputScreen> createState() => _HealthInputScreenState();
}

class _HealthInputScreenState extends State<HealthInputScreen> {
  final _formKey = GlobalKey<FormState>();

  final _bloodPressureMaxController = TextEditingController();
  final _bloodPressureMinController = TextEditingController();
  final _heartRateController = TextEditingController();
  final _breathingRateController = TextEditingController();
  final _temperatureController = TextEditingController();

  @override
  void dispose() {
    _bloodPressureMaxController.dispose();
    _bloodPressureMinController.dispose();
    _heartRateController.dispose();
    _breathingRateController.dispose();
    _temperatureController.dispose();
    super.dispose();
  }


  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String unit,
    required String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: '$label ($unit)',
        border: OutlineInputBorder(),
      ),
      validator: validator,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('القياسات الحيوية')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(
                controller: _bloodPressureMinController,
                label: 'ضغط الدم الانبساطي',
                unit: 'mmHg',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يجب ادخال قيمة';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _bloodPressureMaxController,
                label: 'ضغط الدم الانقباضي',
                unit: 'mmHg',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يجب ادخال قيمة';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _heartRateController,
                label: 'ضربات القلب',
                unit: 'bpm',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يجب ادخال قيمة';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _breathingRateController,
                label: 'التنفس',
                unit: 'breaths/min',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يجب ادخال قيمة';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _temperatureController,
                label: 'درجة الحرارة',
                unit: '°C',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يجب ادخال قيمة';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                // To control the button's width
                  width: double.infinity,
                  height: 60,
                  // Submit Button
                  child: RoundedCornerButton(
                    text: 'تسجيل',
                    color: Colors.red,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  VictimStatusScreen()),
                        );
                        // You would typically send this data to your backend
                      }
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
