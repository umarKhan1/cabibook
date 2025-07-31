import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomPhoneField extends StatefulWidget {
  const CustomPhoneField({
    required this.onChanged,
    required this.isSignIn,
    this.isValid = true,
    super.key,
  });

  final bool isValid;
  final bool isSignIn;
  // ignore: inference_failure_on_function_return_type
  final Function(String phone, String code, bool isSignIn) onChanged;

  @override
  State<CustomPhoneField> createState() => _CustomPhoneFieldState();
}

class _CustomPhoneFieldState extends State<CustomPhoneField> {
  Country selectedCountry = Country(
    phoneCode: '374',
    countryCode: 'AM',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'Armenia',
    example: '37412345678',
    displayName: 'Armenia',
    displayNameNoCountryCode: 'Armenia',
    e164Key: '',
  );

  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    phoneController.addListener(() {
      widget.onChanged(
        phoneController.text.trim(),
        selectedCountry.phoneCode,
        widget.isSignIn,
      );
    });
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: widget.isValid ? Colors.grey.shade300 : Colors.red,
          width: 1.2,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              showCountryPicker(
                context: context,
                showPhoneCode: true,
                countryListTheme: CountryListThemeData(
                  backgroundColor: Colors.white,
                  textStyle: TextStyle(fontSize: 16.sp, color: Colors.black87),
                  bottomSheetHeight: 500.h,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                onSelect: (country) {
                  setState(() {
                    selectedCountry = country;
                  });
                  widget.onChanged(
                    phoneController.text.trim(),
                    country.phoneCode,
                    widget.isSignIn,
                  );
                },
              );
            },
            child: Row(
              children: [
                Text(
                  selectedCountry.flagEmoji,
                  style: TextStyle(fontSize: 24.sp),
                ),
                const Icon(Icons.arrow_drop_down, color: Colors.grey),
                SizedBox(width: 4.w),
                Text(
                  '+${selectedCountry.phoneCode}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Mobile Number',
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.w500,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
