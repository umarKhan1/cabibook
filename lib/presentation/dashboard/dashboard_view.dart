import 'dart:math';

import 'package:cabibook/logic/map_cubit/google_map_cubit.dart';
import 'package:cabibook/logic/map_cubit/google_map_state.dart';
import 'package:cabibook/logic/rider_cubit/ridercubit_cubit.dart';
import 'package:cabibook/utils/images_const.dart';
import 'package:cabibook/widget/find_driver_widget.dart';
import 'package:cabibook/widget/location_widget.dart';
import 'package:cabibook/widget/pickup_drop_widget.dart';
import 'package:cabibook/widget/vichele_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:lottie/lottie.dart';

class ApplicationDashboardView extends StatefulWidget {
  const ApplicationDashboardView({Key? key}) : super(key: key);

  @override
  _ApplicationDashboardViewState createState() =>
      _ApplicationDashboardViewState();
}

class _ApplicationDashboardViewState extends State<ApplicationDashboardView> {
  /// Holds the current screen‐pixel position of the pickup LatLng
  Offset? _pickupOffset;

  /// Size of your Lottie animation
  static const double _lottieSize = 100.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        // 1) The GoogleMap
        BlocBuilder<MapCubit, MapState>(
          builder: (_, state) {
            final cubit = context.read<MapCubit>();
            gmaps.LatLng center;

            if (state is MapLocationLoaded) {
              center = state.location;
            } else if (state is MapPickupUpdated) {
              center = state.location;
            } else if (state is MapRouteReady) {
              center = state.pickup;
            } else {
              return const Center(child: CircularProgressIndicator());
            }

            return gmaps.GoogleMap(
              onMapCreated: (ctrl) {
                cubit.onMapCreated(ctrl);
                _updatePickupOffsetIfNeeded();                
              },
              initialCameraPosition:
                  gmaps.CameraPosition(target: center, zoom: 16),
              myLocationEnabled: false,
              myLocationButtonEnabled: false,

              markers: cubit.markers,
              polylines: cubit.polylines,

              onCameraMove: (pos) {
                cubit.onCameraMove(pos);
                _updatePickupOffsetIfNeeded();
              },
              onCameraIdle: () {
                cubit.onCameraIdle();
                _updatePickupOffsetIfNeeded();
              },
            );
          },
        ),

        // 2) Pin overlay: center‐screen until route ready, then Lottie at pickup point
        BlocBuilder<MapCubit, MapState>(
          builder: (context, state) {
            final isReady = state is MapRouteReady;

            if (!isReady) {
              // Before route: show the drag‐pin in the exact center
              return const CenterPin();
            }

            // After route: show Lottie at the fixed pickup screen‐pos
            if (_pickupOffset == null) return const SizedBox.shrink();
            return Positioned(
              left: _pickupOffset!.dx,
              top: _pickupOffset!.dy,
              width: _lottieSize,
              height: _lottieSize,
              child: IgnorePointer(
                child: Lottie.asset(
                  ApplicationImageConst.lottieAnimation,
                  width: _lottieSize,
                  height: _lottieSize,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),

        // 3) Always keep your text‐fields visible
        const Positioned(
          top: 50,
          left: 16,
          right: 16,
          child: PickupDropModal(),
        ),

        // 4) Fire ride options when route ready
        BlocListener<MapCubit, MapState>(
          listener: (_, state) {
            if (state is MapRouteReady) {
              final dx = state.pickup.latitude - state.destination.latitude;
              final dy = state.pickup.longitude - state.destination.longitude;
              final distKm = sqrt(dx * dx + dy * dy) * 111;
              context.read<RideCubit>().loadOptions(distKm);
            }
          },
          child: const SizedBox.shrink(),
        ),

        // 5) Vehicle selection sheet
         VehicleModalWidget(),

        // 6) Find driver sheet
        const FindDriverModal(),
      ]),
    );
  }

  /// Recomputes the pickup‐LatLng → screen pixel offset whenever needed.
  void _updatePickupOffsetIfNeeded() async {
    final cubit = context.read<MapCubit>();
    final state = cubit.state;
    if (state is! MapRouteReady || cubit.pickup == null) return;

    try {
      final gmaps.ScreenCoordinate screenPt =
          await cubit.mapController.getScreenCoordinate(cubit.pickup!);
      setState(() {
        _pickupOffset = Offset(
          // center the Lottie horizontally on the pickup point
          screenPt.x.toDouble() - _lottieSize / 2,
          // lift it so the “tip” matches the exact point
          screenPt.y.toDouble() - _lottieSize + 16,
        );
      });
    } catch (_) {
      // map not ready yet; ignore
    }
  }
}
