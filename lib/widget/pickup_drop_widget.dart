// lib/widgets/pickup_drop_modal.dart

import 'package:cabibook/logic/map_cubit/google_map_cubit.dart';
import 'package:cabibook/logic/map_cubit/google_map_state.dart';
import 'package:cabibook/model/place_model.dart';
import 'package:cabibook/utils/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_places_flutter/google_places_flutter.dart';

class PickupDropModal extends StatefulWidget {
  const PickupDropModal({Key? key}) : super(key: key);

  @override
  State<PickupDropModal> createState() => _PickupDropModalState();
}

class _PickupDropModalState extends State<PickupDropModal> {
  late final TextEditingController _pickupController;
  late final TextEditingController _destController;
FocusNode pickupFocusNode = FocusNode();
FocusNode destFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    final cubit = context.read<MapCubit>();

    _pickupController = TextEditingController();
    _destController   = TextEditingController();

    
    _pickupController.addListener(() {
      if (_pickupController.text.isEmpty) {
        cubit.clearPickup();
      }
    });

    
    _destController.addListener(() {
      if (_destController.text.isEmpty) {
        cubit.clearDestination();
      }
    });

    // Keep the fields in sync with Cubit state:
    cubit.stream.listen((state) {
      if (state is MapPickupUpdated) {
        _pickupController.text = state.address;
      }
      if (state is MapRouteReady) {
        _destController.text = state.destAddr;
      }
    });
  }

  @override
  void dispose() {
    _pickupController.dispose();
    _destController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MapCubit>();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(blurRadius: 5, color: Colors.black26)],
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        // ── Pickup Field ────────────────────────────────────
        GooglePlaceAutoCompleteTextField(
          textEditingController: _pickupController,
          focusNode: pickupFocusNode,
          googleAPIKey: EnvoironmentVar.googleMapApiKey,
          countries: const ['pt'],
                      // ← turn on ❌
          inputDecoration: const InputDecoration(
            prefixIcon: Icon(Icons.my_location, color: Colors.blue),
            hintText: 'Your pickup address',
          ),
          getPlaceDetailWithLatLng: (pred) {
            final place = PlaceSuggestion(
              description: pred.description!,
              lat: double.parse(pred.lat!),
              lng: double.parse(pred.lng!),
            );
            cubit.selectPickup(place);
            FocusScope.of(context).unfocus();
          },
          itemClick: (_) {
            FocusScope.of(context).unfocus();
          },
        ),
    
        const SizedBox(height: 8),
    
        // ── Destination Field ────────────────────────────────────
        GooglePlaceAutoCompleteTextField(
        focusNode: destFocusNode,  
          textEditingController: _destController,
          googleAPIKey: EnvoironmentVar.googleMapApiKey,
          countries: const ['pt'],
          inputDecoration: const InputDecoration(
            prefixIcon: Icon(Icons.flag, color: Colors.red),
            hintText: 'Your destination address',
          ),
          getPlaceDetailWithLatLng: (pred) {
            final place = PlaceSuggestion(
              description: pred.description!,
              lat: double.parse(pred.lat!),
              lng: double.parse(pred.lng!),
            );
            cubit.selectDestination(place);
            FocusScope.of(context).unfocus();
          },
          
          itemClick: (__) {
            FocusScope.of(context).unfocus();
          },
        ),
      ]),
    );
  }
}
