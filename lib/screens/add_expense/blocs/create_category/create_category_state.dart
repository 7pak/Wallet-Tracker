part of 'create_category_cubit.dart';

sealed class CreateCategoryState extends Equatable {
  const CreateCategoryState();

  @override
  List<Object> get props => [];
}

final class CreateCategoryInitial extends CreateCategoryState {}

final class CreateCategoryFailure extends CreateCategoryState {
  final String message;

  const CreateCategoryFailure(this.message);
}

final class CreateCategorySuccess extends CreateCategoryState {}

final class CreateCategoryLoading extends CreateCategoryState {}

