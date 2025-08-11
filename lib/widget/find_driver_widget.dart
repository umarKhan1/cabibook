import 'package:cabibook/logic/rider_cubit/ridercubit_cubit.dart';
import 'package:cabibook/logic/rider_cubit/ridercubit_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FindDriverModal extends StatelessWidget {
  const FindDriverModal({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RideCubit, RideState>(
      listener: (_, state) {
        if (state is FindingDriver) {
          // show a loader or navigate
        }
      },
      child: BlocBuilder<RideCubit, RideState>(
        builder: (_, state) {
          if (state is RideOptionChosen) {
            return DraggableScrollableSheet(
              initialChildSize: 0.1,
                      minChildSize: 0.3,
            maxChildSize: 0.5,
              builder: (_, ctl) => Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: ElevatedButton(
                  onPressed: () => context.read<RideCubit>().findDriver(),
                  child: const Text('Find Driver'),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
