part of 'get_categories_bloc.dart';

@immutable
sealed class GetCategoriesEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class GetCategories extends GetCategoriesEvent {}