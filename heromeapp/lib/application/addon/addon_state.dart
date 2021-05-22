import 'package:heromeapp/domain/addon/addon.dart';

abstract class AddonState {}
class AddonUninitializedState extends AddonState {}
class AddonFetchingState extends AddonState {}
class AddonFetchedStated extends AddonState {
  final List<Addon> addons;

  AddonFetchedStated(this.addons);
}
class AddonFetchErrorState extends AddonState {
  final String error;

  AddonFetchErrorState(this.error);
}