import 'package:bloc/bloc.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState(selectedIndex: 0));

  setSelectedIndex(int index) => emit(NavigationState(selectedIndex: index));
}
