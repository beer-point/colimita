import 'package:colimita/widgets/app_typography.dart';
import 'package:flutter/material.dart';

enum SocialAuthProvider { google, apple, facebook, anonymously }

class SocialSignInButton extends StatelessWidget {
  final VoidCallback? onPress;
  final SocialAuthProvider socialProvider;

  SocialSignInButton({
    required this.onPress,
    required this.socialProvider,
    Key? key,
  }) : super(key: key);

  String getButtonLabel() {
    switch (socialProvider) {
      case SocialAuthProvider.google:
        return 'Google';
      case SocialAuthProvider.apple:
        return 'Apple';
      case SocialAuthProvider.facebook:
        return 'Facebook';
      case SocialAuthProvider.anonymously:
        return 'Anonimamente';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: ElevatedButton(
        onPressed: onPress,
        child: AppTypography.body(
          'Ingresa con ${getButtonLabel()}',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}
