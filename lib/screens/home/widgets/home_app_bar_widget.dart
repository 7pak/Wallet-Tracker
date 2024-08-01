import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_tracker/screens/auth/blocs/login/login_cubit.dart';
import 'package:wallet_tracker/screens/home/blocs/get_user/get_user_cubit.dart';

Widget homeAppBar(BuildContext context) {
  return Row(
    children: [
      Stack(alignment: Alignment.center, children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: Colors.yellow[700]!),
        ),
        Icon(
          CupertinoIcons.person_fill,
          color: Colors.yellow[800]!,
          size: 30,
        )
      ]),
      const SizedBox(
        width: 10,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome!',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: Theme
                    .of(context)
                    .colorScheme
                    .outline),
          ),
          BlocBuilder<GetUserCubit, GetUserState>(
            builder: (context, state) {
              print('State:$state');
              if(state is GetUserSuccess) {
                return Text(
                    state.user.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    )
                );
              }else{
                if(state is GetUserFailure)  print('State: ${state.message}');

                return const Text(
                    'User',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    )
                );
              }
            },
          )
        ],
      ),
      const Spacer(),
      IconButton(
          onPressed: () {
            context.read<LoginCubit>().logout();
          },
          icon: const Icon(
            Icons.login_outlined,
            size: 30,
          )),
    ],
  );
}