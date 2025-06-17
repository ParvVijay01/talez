import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:hexacom_user/helper/responsive_helper.dart';
import 'package:hexacom_user/localization/language_constrants.dart';
import 'package:hexacom_user/main.dart';
import 'package:hexacom_user/utill/dimensions.dart';
import 'package:hexacom_user/utill/styles.dart';
import 'package:hexacom_user/common/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationPermissionDialogWidget extends StatelessWidget {
  const LocationPermissionDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
        child: SizedBox(
          width: 300,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.add_location_alt_rounded,
                color: Theme.of(context).primaryColor, size: 100),
            const SizedBox(height: Dimensions.paddingSizeLarge),
            Text(
              getTranslated('you_denied_location_permission', context),
              textAlign: TextAlign.justify,
              style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
            ),
            const SizedBox(height: Dimensions.paddingSizeLarge),
            Row(children: [
              // Custom styled "No" button using TextButton for full control
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(
                        color: Theme.of(context).primaryColor, width: 2),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    minimumSize: const Size(1, 50),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    getTranslated('no', context),
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              // Keep using your CustomButtonWidget for "Yes"
              Expanded(
                child: CustomButtonWidget(
                  btnTxt: getTranslated('yes', context),
                  onTap: () async {
                    if (kIsWeb) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "Please enable location permission in your browser settings."),
                      ));
                    } else if (ResponsiveHelper.isMobilePhone()) {
                      await Geolocator.openAppSettings();
                    }
                    Navigator.pop(context);
                  },
                ),
              ),
            ])
          ]),
        ),
      ),
    );
  }
}
