import 'package:dinamik10_pos/feature/current/view/current_view.dart';
import 'package:dinamik10_pos/feature/current/view_model/current_view_model.dart';
import 'package:dinamik10_pos/product/service/local_current_service.dart';
import 'package:dinamik10_pos/product/state/base/base_state.dart';
import 'package:flutter/widgets.dart';

mixin CurrentMixin on BaseState<CurrentView> {
  late final CurrentViewModel _currentViewModel;
  late final LocalCurrentService _localCurrentService;
  late final TextEditingController searchController;

  CurrentViewModel get currentViewModel => _currentViewModel;

  @override
  void initState() {
    super.initState();
    _localCurrentService = LocalCurrentService();
    _currentViewModel = CurrentViewModel(localCurrentService: _localCurrentService);
    searchController = TextEditingController();
    searchController.addListener(() {
      _currentViewModel.fetchCurrents(searchText: searchController.text, isLoading: false);
    });
    _currentViewModel.fetchCurrents(searchText: '', isLoading: true);
  }
}
