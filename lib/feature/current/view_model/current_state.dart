import 'package:dinamik10_pos/product/service/local_current_service.dart';
import 'package:equatable/equatable.dart';
import 'package:gen/gen.dart';

final class CurrentState extends Equatable {
  const CurrentState({
    required this.isLoading,
    required this.currentAccount,
    required this.currentAccountSearchType,
    this.offset = 0,
    required this.searchTypeText,
  });
  final bool isLoading;
  final List<CurrentAccountModel> currentAccount;
  final CurrentAccountSearchType currentAccountSearchType;
  final int offset;
  final String searchTypeText;

  CurrentState copyWith({
    bool? isLoading,
    List<CurrentAccountModel>? currentAccount,
    CurrentAccountSearchType? currentAccountSearchType,
    int? offset,
    String? searchTypeText,
  }) {
    return CurrentState(
      isLoading: isLoading ?? this.isLoading,
      currentAccount: currentAccount ?? this.currentAccount,
      currentAccountSearchType: currentAccountSearchType ?? this.currentAccountSearchType,
      searchTypeText: searchTypeText ?? this.searchTypeText,
    );
  }

  @override
  List<Object?> get props => [isLoading, currentAccount, currentAccountSearchType, offset, searchTypeText];
}
