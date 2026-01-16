import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:workmanager/workmanager.dart';
import 'core/config/theme/theme_provider.dart';
import 'core/config/router/app_router.dart';
import 'core/config/router/auth_state_navigation_listener.dart';
import 'core/config/env/env_config.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'core/providers/notification_manager_provider.dart';
import 'core/services/daily_quote_worker.dart' as dqw;

import 'core/application/controllers/connectivity_controller.dart';
import 'core/widgets/offline_banner.dart';
import 'core/widgets/reconnection_notifier.dart';
import 'features/auth/application/providers/auth_state_provider.dart';
import 'features/settings/application/controllers/settings_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: '.env');

  // Initialize Supabase
  await supabase.Supabase.initialize(
    url: EnvConfig.supabaseUrl,
    anonKey: EnvConfig.supabaseAnonKey,
    authOptions: const supabase.FlutterAuthClientOptions(
      authFlowType: supabase.AuthFlowType.pkce, // For deep link support
    ),
  );

  // Initialize timezone data for notifications
  tz.initializeTimeZones();

  // Initialize WorkManager for background tasks
  await Workmanager().initialize(
    dqw.callbackDispatcher,
    isInDebugMode: false, // Set to true for debugging WorkManager tasks
  );

  runApp(const ProviderScope(child: QuoteVaultApp()));
}

class QuoteVaultApp extends ConsumerWidget {
  const QuoteVaultApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    // Initialize auth state navigation listener
    ref.watch(authStateNavigationListenerProvider);

    // Initialize connectivity monitoring
    ref.watch(connectivityControllerProvider);

    // Initialize notification service (permissions will be requested when needed)
    ref.read(notificationServiceProvider).initialize();

    // Schedule notifications if enabled (after settings load)
    ref.listen(settingsControllerProvider, (previous, next) {
      // Only schedule on first load when settings become available
      if (previous?.isLoading == true && next.isLoading == false) {
        ref
            .read(settingsControllerProvider.notifier)
            .scheduleInitialNotifications();
      }
    });

    // Sync settings from cloud when user logs in
    ref.listen(authStateChangesProvider, (previous, next) {
      final prevUser = previous?.hasValue == true ? previous!.value : null;
      final nextUser = next.hasValue ? next.value : null;

      // User just logged in (was null, now has user)
      if (prevUser == null && nextUser != null) {
        ref.read(settingsControllerProvider.notifier).syncFromCloud();
      }
    });

    return MaterialApp.router(
      title: 'QuoteVault',
      theme: ref.watch(effectiveThemeProvider),
      darkTheme: ref.watch(effectiveDarkThemeProvider),
      themeMode: ref.watch(effectiveFlutterThemeModeProvider),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return ReconnectionNotifier(
          child: Column(
            children: [
              const OfflineBanner(),
              Expanded(child: child ?? const SizedBox.shrink()),
            ],
          ),
        );
      },
    );
  }
}
