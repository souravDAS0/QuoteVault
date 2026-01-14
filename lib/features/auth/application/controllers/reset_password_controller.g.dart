// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ResetPasswordController)
const resetPasswordControllerProvider = ResetPasswordControllerProvider._();

final class ResetPasswordControllerProvider
    extends $NotifierProvider<ResetPasswordController, ResetPasswordState> {
  const ResetPasswordControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resetPasswordControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$resetPasswordControllerHash();

  @$internal
  @override
  ResetPasswordController create() => ResetPasswordController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ResetPasswordState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ResetPasswordState>(value),
    );
  }
}

String _$resetPasswordControllerHash() =>
    r'f5764663a42237806cb9aa7472d136195b6e682a';

abstract class _$ResetPasswordController extends $Notifier<ResetPasswordState> {
  ResetPasswordState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ResetPasswordState, ResetPasswordState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ResetPasswordState, ResetPasswordState>,
              ResetPasswordState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
