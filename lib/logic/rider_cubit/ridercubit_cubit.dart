import 'package:bloc/bloc.dart';
import 'package:cabibook/logic/rider_cubit/ridercubit_state.dart';
import 'package:cabibook/model/vichele_model.dart';
import 'package:cabibook/utils/images_const.dart';

class RideCubit extends Cubit<RideState> {
  RideCubit() : super(RideInitial());

  void loadOptions(double distanceKm) {
    final opts = [

      VehicleOption(name: 'Limousine', asset: ApplicationImageConst.carImage1, price: 80, distanceKm: distanceKm, etaMin: 5),
      VehicleOption(name: 'Luxury', asset: ApplicationImageConst.carImage2, price: 50, distanceKm: distanceKm, etaMin: 3),
      VehicleOption(name: 'Bike', asset: ApplicationImageConst.bikeImage, price: 15, distanceKm: distanceKm, etaMin: 3),
      // … add more
    ];
    emit(RideOptionsLoaded(opts));
  }

  void chooseOption(VehicleOption o) => emit(RideOptionChosen(o));

  void findDriver() {
    emit(FindingDriver());
    // simulate delay then e.g. navigate
  }
}
