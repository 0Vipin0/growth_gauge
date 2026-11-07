import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../../core/routing/app_router.dart';
import '../../common/presentation/utils/responsive_form_layout.dart';
import '../../common/presentation/widgets/widgets.dart';
import '../infrastructure/authentication_service.dart';

class const PinAuthScreen({super.key}) extends StatefulWidget {
  @override
  State<PinAuthScreen> createState() => _PinAuthScreenState();
}

class _PinAuthScreenState() extends State<PinAuthScreen> {
  final AuthenticationService _authService = AuthenticationService();
  final TextEditingController _pinController = TextEditingController();
  String? _errorMessage;
  bool _isLoading = false;

  Future<void> _handlePinSubmission() async {
    final String enteredPin = _pinController.text;
    if (enteredPin.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a PIN.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

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
          _isLoading = false;
          _errorMessage = 'Invalid PIN. Please try again.';
        });
      }
    }
  }

  void _navigateToHome() {
    if (mounted) {
      context.go(appRouteHome);
    }
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('PIN Authentication'),
      ),
      body: ResponsiveFormLayout(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: AppCard(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Please enter your PIN to proceed:',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        controller: _pinController,
                        label: 'Enter PIN',
                        hintText: '••••',
                        obscureText: true,
                        keyboardType: TextInputType.number,
                        prefixIcon: Icons.lock_outline,
                        errorText: _errorMessage,
                        maxLength: 6,
                        onChanged: (_) {
                          if (_errorMessage != null) {
                            setState(() => _errorMessage = null);
                          }
                        },
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: AppButton.primary(
                          label: 'Submit',
                          onPressed: _isLoading ? null : _handlePinSubmission,
                          isLoading: _isLoading,
                          icon: Icons.arrow_forward,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
