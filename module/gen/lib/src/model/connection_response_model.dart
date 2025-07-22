import 'package:equatable/equatable.dart';
import 'package:vexana/vexana.dart';

class ConnectionResponseModel extends INetworkModel<ConnectionResponseModel> with EquatableMixin {
  final bool? success;

  ConnectionResponseModel({this.success});

  @override
  ConnectionResponseModel fromJson(Map<String, dynamic> json) {
    return ConnectionResponseModel(success: json['success'] as bool?);
  }

  @override
  Map<String, dynamic>? toJson() => null;

  @override
  List<Object?> get props => [success];
}
