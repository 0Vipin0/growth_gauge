import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/user_profile_provider.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _ageCtrl = TextEditingController();
  final _heightCtrl = TextEditingController();
  final _weightCtrl = TextEditingController();

  @override
  void dispose() {
    _ageCtrl.dispose();
    _heightCtrl.dispose();
    _weightCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProfileProvider>(context);
    final profile = provider.currentUserProfile;

    if (profile != null) {
      _ageCtrl.text = profile.data?.age?.toString() ?? '';
      _heightCtrl.text = profile.data?.heightCm?.toString() ?? '';
      _weightCtrl.text = profile.data?.weightKg?.toString() ?? '';
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _ageCtrl,
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) return null;
                  final v = int.tryParse(val);
                  if (v == null || v < 0) return 'Enter a valid age';
                  return null;
                },
              ),
              TextFormField(
                controller: _heightCtrl,
                decoration: const InputDecoration(labelText: 'Height (cm)'),
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) return null;
                  final v = double.tryParse(val);
                  if (v == null || v <= 0) return 'Enter a valid height';
                  return null;
                },
              ),
              TextFormField(
                controller: _weightCtrl,
                decoration: const InputDecoration(labelText: 'Weight (kg)'),
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) return null;
                  final v = double.tryParse(val);
                  if (v == null || v <= 0) return 'Enter a valid weight';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;

                  final age = int.tryParse(_ageCtrl.text);
                  final height = double.tryParse(_heightCtrl.text);
                  final weight = double.tryParse(_weightCtrl.text);
                  provider.updateBiometrics(age: age, heightCm: height, weightKg: weight);
                  await provider.saveProfile();

                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Profile saved')),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Save'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
