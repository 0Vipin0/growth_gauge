import 'package:flutter/material.dart';

import '../../routes.dart';
import '../../utils/navigation_helper.dart';
import 'authentication_service.dart';

class PinAuthScreen extends StatefulWidget {
  @override
  _PinAuthScreenState createState() => _PinAuthScreenState();
}

class _PinAuthScreenState extends State<PinAuthScreen> {
  final AuthenticationService _authService = AuthenticationService();
  final TextEditingController _pinController = TextEditingController();
  String? _errorMessage;

  Future<void> _handlePinSubmission() async {
    final String enteredPin = _pinController.text;
    final String? storedPin = await _authService.getSavedPin();

    if (storedPin == null) {
      // Save the entered PIN if no PIN is stored
      await _authService.savePin(enteredPin);
      _navigateToHome();
    } else {
      // Authenticate using the stored PIN
      final bool isAuthenticated = await _authService.authenticateWithPin(
        enteredPin,
      );
      if (isAuthenticated) {
        _navigateToHome();
      } else {
        setState(() {
          _errorMessage = 'Invalid PIN. Please try again.';
        });
      }
    }
  }

  void _navigateToHome() {
    if (mounted) {
      NavigationHelper.replaceWith(context, AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('PIN Authentication'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width > 600
                  ? 400
                  : double.infinity,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Please enter your PIN to proceed:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _pinController,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Enter PIN',
                      errorText: _errorMessage,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: _handlePinSubmission,
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
