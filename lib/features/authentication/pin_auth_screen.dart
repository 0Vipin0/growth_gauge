import 'package:flutter/material.dart';

import 'authentication.dart';

class PinAuthScreen extends StatefulWidget {
  @override
  _PinAuthScreenState createState() => _PinAuthScreenState();
}

class _PinAuthScreenState extends State<PinAuthScreen> {
  final AuthenticationProvider _authService = AuthenticationProvider();
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
    if (mounted) Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PIN Authentication')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            ElevatedButton(
              onPressed: _handlePinSubmission,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
