import '../../../../product/service/interface/user_operation.dart';
import '../../../../product/state/base/base_cubit.dart';
import 'home_state.dart';

class HomeViewModel extends BaseCubit<HomeState> {
  HomeViewModel({required UserOperation operationService})
    : _userOperation = operationService,
      super(const HomeState(isLoading: false));

  late final UserOperation _userOperation;

  void changeLoading() {
    emit(state.copyWith(isLoading: !state.isLoading));
  }

  Future<void> fetchUsers() async {
    changeLoading();
    final result = await _userOperation.getUsers();
    emit(state.copyWith(users: result));
    changeLoading();
  }
}
