class VehicleOption {        // min

  VehicleOption({
    required this.name,
    required this.asset,
    required this.price,
    required this.distanceKm,
    required this.etaMin,
  });
  final String name;
  final String asset;      // PNG icon path
  final double price;      // $
  final double distanceKm; // km
  final int etaMin;
}
