// ignore_for_file: lines_longer_than_80_chars

import 'package:cabibook/logic/rider_cubit/ridercubit_cubit.dart';
import 'package:cabibook/logic/rider_cubit/ridercubit_state.dart';
import 'package:cabibook/model/vichele_model.dart';
import 'package:cabibook/utils/ext.dart';
import 'package:cabibook/widget/app_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VehicleModalWidget extends StatefulWidget {
  const VehicleModalWidget({super.key});

  @override
  State<VehicleModalWidget> createState() => _VehicleModalWidgetState();
}

class _VehicleModalWidgetState extends State<VehicleModalWidget> {
  VehicleOption? selectedOption;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RideCubit, RideState>(
      builder: (_, state) {
        if (state is RideOptionsLoaded) {
          return DraggableScrollableSheet(
            minChildSize: 0.3,
            maxChildSize: 0.5,
            builder: (_, ctl) => Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  12.hsb,
               Text("Select Your Ride", style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold)),
              

                  // Ride Options List
                  Expanded(
                    child: ListView.builder(
                      controller: ctl,
                      itemCount: state.options.length,
                      itemBuilder: (_, i) {
                        final o = state.options[i];
                        final isSelected = selectedOption == o;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedOption = o;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: isSelected ? context.primaryColor : Colors.transparent,
                                width: 2,
                              ),
                              color: Colors.grey[100],
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              leading: Image.asset(
                                o.asset,
                                width: 60.w,
                                height: 60.w,
                                fit: BoxFit.contain,
                              ),
                              title: Text(
                                o.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                ),
                              ),
                              subtitle: Text(
                                '${o.distanceKm.toStringAsFixed(2)} km · ${o.etaMin} min',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                              trailing: Text(
                                '\$${o.price.toStringAsFixed(0)}',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  12.hsb,

                  // Select Ride Button
                  ApplicationButton(
                    size: Size(260.w, 48.h),
                    onPressed: selectedOption == null
                        ? null
                        : () {
                            context.read<RideCubit>().findDriver();
                          //  context.read<RideCubit>().chooseOption(selectedOption!);
                          },
                    child: Text(
                      'Find Driver',
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  20.hsb,
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
