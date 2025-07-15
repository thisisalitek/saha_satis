import 'package:dinamik10_pos/feature/current/view_model/current_state.dart';
import 'package:dinamik10_pos/product/init/language/locale_keys.g.dart';
import 'package:dinamik10_pos/product/state/base/base_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gen/gen.dart';

import '../../../product/service/local_current_service.dart';

class CurrentViewModel extends BaseCubit<CurrentState> {
  CurrentViewModel({required LocalCurrentService localCurrentService})
    : _localCurrentService = localCurrentService,
      super(
        const CurrentState(
          isLoading: false,
          currentAccount: [],
          currentAccountSearchType: CurrentAccountSearchType.accountName,
          searchTypeText: '',
          offset: 0,
        ),
      );

  late final LocalCurrentService _localCurrentService;

  void changeLoading() {
    emit(state.copyWith(isLoading: !state.isLoading));
  }

  Future<void> fetchCurrents({required String searchText, required bool isLoading}) async {
    isLoading ? changeLoading() : null;
    List<CurrentAccountModel> result = await _localCurrentService.getFilteredCurrentAccounts(
      searchType: state.currentAccountSearchType,
      searchText: searchText,
      offset: state.offset,
    );
    emit(state.copyWith(currentAccount: result, currentAccountSearchType: state.currentAccountSearchType, offset: 0));
    _getSearchTypeText();
    isLoading ? changeLoading() : null;
  }

  void _getSearchTypeText() {
    switch (state.currentAccountSearchType) {
      case CurrentAccountSearchType.accountName:
        emit(state.copyWith(searchTypeText: LocaleKeys.current_search_type_name.tr()));
      case CurrentAccountSearchType.accountCode:
        emit(state.copyWith(searchTypeText: LocaleKeys.current_search_type_code.tr()));
    }
  }

  void changeSearchType() {
    CurrentAccountSearchType searchType = state.currentAccountSearchType;
    state.currentAccountSearchType == CurrentAccountSearchType.accountCode
        ? searchType = CurrentAccountSearchType.accountName
        : searchType = CurrentAccountSearchType.accountCode;
    emit(state.copyWith(currentAccountSearchType: searchType));
    _getSearchTypeText();
  }
}
