part of 'remove_category_cubit.dart';

sealed class RemoveCategoryState extends Equatable {
  const RemoveCategoryState();
  @override
  List<Object> get props => [];
}

final class RemoveCategoryInitial extends RemoveCategoryState {}
final class RemoveCategorySuccess extends RemoveCategoryState {}
final class RemoveCategoryLoading extends RemoveCategoryState {}
final class RemoveCategoryFailure extends RemoveCategoryState {
  final String message;

  const RemoveCategoryFailure({required this.message});
}
