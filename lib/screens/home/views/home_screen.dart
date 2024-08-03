import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_tracker/blocs/navigation/navigation_cubit.dart';
import 'package:wallet_tracker/screens/home/widgets/customFAB.dart';

import '../../../config/app_colors.dart';
import '../../transactions/views/stats_screen.dart';
import 'main_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{
  static const List<Widget> _screens = <Widget>[
    MainScreen(),
    TransactionsScreen(),
  ];

  Widget _bottomNavigationBar(int selectedIndex) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: AppColors.tertiary,
          currentIndex: selectedIndex,
          onTap: context.read<NavigationCubit>().setSelectedIndex,
          backgroundColor: Colors.white,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.graph_square_fill), label: 'Stats'),
          ]),
    );
  }

  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleButtons() {
    if (_isExpanded) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _closeButton() {
    if (_isExpanded) {
      _controller.reverse();
      setState(() {
        _isExpanded = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        _closeButton();
      },
      child: BlocBuilder<NavigationCubit, NavigationState>(
  builder: (context, state) {
    return Scaffold(
        bottomNavigationBar: _bottomNavigationBar(state.selectedIndex),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton:  CustomFAB(isExpanded: _isExpanded, toggleExpanded: _toggleButtons, animation: _animation),
        body:  _screens[state.selectedIndex]
      );
  },
),
    );
  }
}
