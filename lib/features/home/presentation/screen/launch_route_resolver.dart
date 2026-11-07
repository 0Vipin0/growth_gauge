import '../../../../core/routing/app_router.dart';
import '../../../settings/domain/settings_model.dart';

String appRouteForAuthentication(AuthenticationType type) => switch (type) {
  AuthenticationType.pin => appRoutePinAuth,
  AuthenticationType.biometric => appRouteBiometricAuth,
  AuthenticationType.none => appRouteHome,
};
