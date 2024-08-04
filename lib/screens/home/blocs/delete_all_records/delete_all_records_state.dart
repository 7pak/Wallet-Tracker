part of 'delete_all_records_cubit.dart';

sealed class DeleteAllRecordsState {}

final class DeleteAllRecordsInitial extends DeleteAllRecordsState {}
final class DeleteAllRecordsSuccess extends DeleteAllRecordsState {}
final class DeleteAllRecordsLoading extends DeleteAllRecordsState {}
final class DeleteAllRecordsFailure extends DeleteAllRecordsState {
  final String message;

  DeleteAllRecordsFailure({required this.message});

}
