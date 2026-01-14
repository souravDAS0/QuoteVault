import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../services/share_service.dart';
import '../../data/services/share_service_impl.dart';

part 'share_providers.g.dart';

/// Provider for share service
@riverpod
ShareService shareService(Ref ref) {
  return ShareServiceImpl();
}
