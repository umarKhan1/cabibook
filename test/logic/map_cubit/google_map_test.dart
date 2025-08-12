// ignore_for_file: lines_longer_than_80_chars

import 'package:bloc_test/bloc_test.dart';
import 'package:cabibook/logic/map_cubit/google_map_cubit.dart';
import 'package:cabibook/logic/map_cubit/google_map_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  group('MapCubit', () {
    late MapCubit cubit;

    setUp(() {
      cubit = MapCubit();
    });

    tearDown(() async {
      await cubit.close();
    });

    test('initial state is MapInitial', () {
      expect(cubit.state, isA<MapInitial>());
    });

    blocTest<MapCubit, MapState>(
      'onCameraIdle emits MapPickupUpdated with center',
      build: MapCubit.new,
      act: (c) {
        c
          ..onCameraMove(const CameraPosition(target: LatLng(10, 20), zoom: 14))
          ..onCameraIdle();
      },
      wait: const Duration(milliseconds: 600), // debounce
      expect: () => [isA<MapPickupUpdated>()],
      verify: (c) {
        expect(c.pickup!.latitude, 10);
        expect(c.pickup!.longitude, 20);
        expect(c.pickupAddr, 'Unknown address');
        final hasPickupMarker = c.markers.any(
          (m) => m.markerId.value == 'pickup',
        );
        expect(hasPickupMarker, isTrue);
      },
    );

    blocTest<MapCubit, MapState>(
      'onCameraIdle does nothing when pickupLocked = true',
      build: () => MapCubit()..pickupLocked = true,
      act: (c) {
        c
          ..onCameraMove(const CameraPosition(target: LatLng(1, 1), zoom: 12))
          ..onCameraIdle();
      },
      wait: const Duration(milliseconds: 600),
      expect: () => <MapState>[],
    );

    blocTest<MapCubit, MapState>(
      'onCameraIdle does nothing when destination already set',
      build: () => MapCubit()..destination = const LatLng(7, 8),
      act: (c) {
        c
          ..onCameraMove(const CameraPosition(target: LatLng(9, 9), zoom: 12))
          ..onCameraIdle();
      },
      wait: const Duration(milliseconds: 600),
      expect: () => <MapState>[],
    );

    blocTest<MapCubit, MapState>(
      'clearDestination removes destination marker & polylines, then emits MapPickupUpdated',
      build: () {
        final c = MapCubit()
          // seed like a route existed
          ..pickup = const LatLng(5, 6)
          ..pickupAddr = 'Somewhere'
          ..destination = const LatLng(7, 8)
          ..destinationAddr = 'Dest';
        c.markers.add(
          const Marker(
            markerId: MarkerId('destination'),
            position: LatLng(7, 8),
          ),
        );
        c.polylines.add(
          const Polyline(
            polylineId: PolylineId('route'),
            points: [LatLng(0, 0), LatLng(1, 1)],
          ),
        );
        return c;
      },
      act: (c) => c.clearDestination(),
      expect: () => [isA<MapPickupUpdated>()],
      verify: (c) {
        // Check cubit fields instead of state getters
        expect(c.pickup, isNotNull);
        expect(c.pickup!.latitude, 5);
        expect(c.pickup!.longitude, 6);
        expect(c.pickupAddr, 'Somewhere');

        expect(c.destination, isNull);
        expect(c.destinationAddr, isEmpty);
        expect(c.polylines, isEmpty);

        final hasDestMarker = c.markers.any(
          (m) => m.markerId.value == 'destination',
        );
        expect(hasDestMarker, isFalse);
      },
    );

    blocTest<MapCubit, MapState>(
      'closing cubit cancels debounce timer (no emission after close)',
      build: MapCubit.new,
      act: (c) async {
        c
          ..onCameraMove(const CameraPosition(target: LatLng(3, 4), zoom: 10))
          ..onCameraIdle(); // schedules a 500ms debounce
        await c.close(); // should cancel timer before it emits
      },
      wait: const Duration(milliseconds: 600),
      expect: () => <MapState>[],
    );
  });
}
