import 'package:fixmyclass/Utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const String googleApiKey = "AIzaSyCRQIhsGS3xrGeopcSPW70zal2yNRIQAJc"; // 🔑 Replace this

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen>
    with TickerProviderStateMixin {
  late GoogleMapController mapController;
  LatLng selectedPosition = const LatLng(28.6139, 77.2090); // Default: Delhi
  String? selectedCity;
  bool isLoading = true;

  late AnimationController pinController;
  late Animation<double> pinAnimation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    pinController =
    AnimationController(vsync: this, duration: const Duration(milliseconds: 600))
      ..repeat(reverse: true);
    pinAnimation = Tween<double>(begin: 0, end: 12).animate(
      CurvedAnimation(parent: pinController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      selectedPosition = LatLng(position.latitude, position.longitude);
      isLoading = false;
    });

    _getAddressFromLatLng(selectedPosition);
    mapController.animateCamera(
      CameraUpdate.newLatLngZoom(selectedPosition, 15),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _getAddressFromLatLng(LatLng pos) async {
    List<Placemark> placemarks =
    await placemarkFromCoordinates(pos.latitude, pos.longitude);
    if (placemarks.isNotEmpty) {
      setState(() {
        selectedCity = placemarks.first.locality ?? 'Unknown';
      });
    }
  }

  Future<void> _handleSearch() async {
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: googleApiKey,
      mode: Mode.overlay,
      language: "en",
      hint: "Search for a location...",
      components: [Component(Component.country, "in")],
    );

    if (p != null) {
      final places = GoogleMapsPlaces(apiKey: googleApiKey);
      final detail = await places.getDetailsByPlaceId(p.placeId!);
      final lat = detail.result.geometry!.location.lat;
      final lng = detail.result.geometry!.location.lng;

      setState(() {
        selectedPosition = LatLng(lat, lng);
      });

      mapController.animateCamera(
        CameraUpdate.newLatLngZoom(selectedPosition, 15),
      );
      _getAddressFromLatLng(selectedPosition);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navyBlue,
      body:
      Stack(
        children: [
          // isLoading
          //     ? const Center(child: CircularProgressIndicator(color: Colors.white ))
          //     :
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: selectedPosition,
              zoom: 14,
            ),
            onCameraMove: (position) {
              selectedPosition = position.target;
            },
            onCameraIdle: () => _getAddressFromLatLng(selectedPosition),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
          ),

          // 🌈 Gradient header with search
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding:
              EdgeInsets.only(top: MediaQuery.of(context).padding.top + 12.h, bottom: 12.h),
              decoration:  BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.navyBlue, AppColors.navyBlue,],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26, blurRadius: 10, offset: Offset(0, 4))
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: _handleSearch,
                      child: Container(
                        margin: EdgeInsets.only(right: 16.w),
                        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.search, color: Colors.blueAccent),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                selectedCity ?? 'Search or move map...',
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 📍 Animated center pin
          Center(
            child: AnimatedBuilder(
              animation: pinController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, -pinAnimation.value),
                  child: const Icon(Icons.location_pin,
                      size: 55, color: Colors.redAccent),
                );
              },
            ),
          ),

          // 🏙 City display card
          Positioned(
            bottom: 110.h,
            left: 20.w,
            right: 20.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26, blurRadius: 8, offset: const Offset(0, 3))
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.location_city_rounded,
                      color: Colors.blueAccent),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        selectedCity ?? 'Detecting city...',
                        key: ValueKey(selectedCity),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ✅ Save Button
          Positioned(
            bottom: 40.h,
            left: 50.w,
            right: 50.w,
            child: ElevatedButton.icon(
              onPressed: () {
                if (selectedCity != null) {
                  Navigator.pop(context, selectedCity);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please select a valid location")),
                  );
                }
              },
              icon: const Icon(Icons.check_circle_outline),
              label: const Text("Save Location ",style: TextStyle(color: Colors.white),),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.navyBlue,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
                textStyle: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
                elevation: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
