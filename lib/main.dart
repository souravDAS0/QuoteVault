import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'core/config/theme/theme_provider.dart';
import 'core/config/router/app_router.dart';
import 'core/config/router/auth_state_navigation_listener.dart';
import 'core/config/env/env_config.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'core/providers/notification_manager_provider.dart';
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

  runApp(const ProviderScope(child: QuoteVaultApp()));
}

class QuoteVaultApp extends ConsumerWidget {
  const QuoteVaultApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    // Initialize auth state navigation listener
    ref.watch(authStateNavigationListenerProvider);

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

    return MaterialApp.router(
      title: 'QuoteVault',
      theme: ref.watch(effectiveThemeProvider),
      darkTheme: ref.watch(effectiveDarkThemeProvider),
      themeMode: ref.watch(effectiveFlutterThemeModeProvider),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
