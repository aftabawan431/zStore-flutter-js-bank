import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zstore_flutter/core/widgets/custom/custom_form_field.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/utils/globals/globals.dart';
import '../../../../../core/utils/theme/app_theme.dart';
import '../../../../../core/utils/validators/form_validator.dart';
import '../../../../../core/widgets/custom/continue_button.dart';
import '../../../../../core/widgets/custom/custom_app_bar.dart';
import '../../home_view_model/home_view_model.dart';

class NewShippingAddressPage extends StatelessWidget {
  NewShippingAddressPage({Key? key}) : super(key: key);

  final HomeViewModel homeViewModel = sl();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: homeViewModel, child:  NewShippingAddressScreenContent());
  }
}

class NewShippingAddressScreenContent extends StatelessWidget {
   NewShippingAddressScreenContent({Key? key}) : super(key: key);
  HomeViewModel homeViewModel = sl();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar( title: 'Shipping Address',color: kCyanColor,),

      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.backgroundImagePNG),
            alignment: Alignment.center,
            fit: BoxFit.cover,
          ),
        ),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            SizedBox(height: 20.h),

            Expanded(
              child: Container(

                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0),
                    )),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 15.h),
                        Text(
                          'Enter a new shipping Address',
                          style: AppTheme.appTheme.textTheme.subtitle1!
                              .copyWith(fontSize: 20.sp),
                        ),
                        Text('Please select the Location on the Map',
                            style: AppTheme.appTheme.textTheme.bodyText2),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: SizedBox(
                            height: 33.h,
                            child: TextFormField(
                                keyboardType: TextInputType.visiblePassword,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                    fontSize: 14.sp),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 10), // <-- SEE HERE

                                    hintText: 'search',

                                    suffixIcon: Icon(
                                      Icons.search,
                                      color: Theme.of(context).primaryColor,
                                    ))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: SizedBox(
                            height: 350.h,
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: GoogleMap(
                                // myLocationButtonEnabled: true,
                                // zoomControlsEnabled: false,
                                initialCameraPosition: context
                                    .read<HomeViewModel>()
                                    .initialCameraPosition,
                              ),
                            ),
                          ),
                        ),
                        Text(' Address',style: AppTheme.appTheme.textTheme.subtitle2,),

                         Form(
                           key: homeViewModel.addressFormKey,
                           child: Padding(
                            padding: EdgeInsets.only(top: 5.h),
                            child: CustomTextFormField(
                              keyboardType: TextInputType.visiblePassword,

                              maxLines: 1,
                              controller:homeViewModel.addressController,
                              validator: FormValidators.validateDetails,
                              contentPadding:  EdgeInsets.symmetric(
                                  vertical: 5.h, horizontal: 15.w),
                              focusNode: homeViewModel
                                  .addressFocusNode,
                              onChanged: homeViewModel
                                  .onAddressChange,
                              onFieldSubmitted: (_) => homeViewModel
                                  .onAddressSubmitted(context),
                            ),
                        ),
                         ),
                        SizedBox(height: 15.h),
                        ContinueButton(text: 'Checkout', onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();

                          homeViewModel.isNewShippingAddressError =
                          true;

                          if (!homeViewModel
                              .addressFormKey
                              .currentState!
                              .validate()) {
                            return;
                          }
                          context.read<HomeViewModel>().moveToPaymentDetails();

                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
