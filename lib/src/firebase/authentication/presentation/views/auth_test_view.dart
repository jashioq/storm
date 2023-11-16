import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storm/src/firebase/authentication/presentation/cubit/authentication_cubit.dart';

class AuthTestView extends StatefulWidget {
  const AuthTestView({super.key});

  @override
  State<AuthTestView> createState() => _AuthTestViewState();
}

class _AuthTestViewState extends State<AuthTestView> {
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String userID = "Unknown state";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(state.toString()),
              TextField(
                controller: mailController,
                decoration: const InputDecoration(
                  labelText: 'Mail',
                ),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthenticationCubit>().mailPassLogIn(
                    mail: mailController.text,
                    password: passwordController.text,
                  );
                },
                child: const Text('Log in'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthenticationCubit>().googleAuthIn();
                },
                child: const Text('Google log in'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthenticationCubit>().signOut();
                },
                child: const Text('Sign out'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthenticationCubit>().getLocalUser();
                  setState(() {
                    userID = context.read<AuthenticationCubit>().getLocalUser().toString();
                  });
                },
                child: const Text('Get local user id'),
              ),
            ],
          ),
        );
      }
    );
  }
}
