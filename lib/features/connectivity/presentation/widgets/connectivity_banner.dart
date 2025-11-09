import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedra/features/connectivity/presentation/bloc/connectivity_bloc.dart';
import 'package:speedra/features/connectivity/presentation/bloc/connectivity_state.dart';

class ConnectivityBanner extends StatelessWidget {
  const ConnectivityBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityBloc, ConnectivityState>(
      builder: (context, state) {
        if (state is ConnectivityFailure) {
          return Container(
            width: double.infinity,
            color: Colors.red,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'No internet connection. Please check your connection and try again.',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
