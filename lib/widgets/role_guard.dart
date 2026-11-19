
import 'package:flutter/material.dart';
import '../services/profile_service.dart';

class RoleGuard extends StatelessWidget {
  final List<String> allowedRoles;
  final Widget child;
  final Widget? fallback;

  const RoleGuard({
    super.key,
    required this.allowedRoles,
    required this.child,
    this.fallback,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserProfile?>(
      future: ProfileService().getMyProfile(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError || snapshot.data == null) {
          return fallback ??
              const SizedBox.shrink();
        }

        final userRole = snapshot.data!.role;

        if (allowedRoles.contains(userRole)) {
          return child;
        }

        return fallback ??
            const SizedBox.shrink();
      },
    );
  }
}
