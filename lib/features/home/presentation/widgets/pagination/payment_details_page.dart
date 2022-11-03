import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zstore_flutter/core/constants/app_assets.dart';
import 'package:zstore_flutter/core/utils/theme/app_theme.dart';
import 'package:zstore_flutter/core/widgets/custom/continue_button.dart';
import 'package:zstore_flutter/core/widgets/custom/custom_app_bar.dart';

import '../../../../../core/utils/globals/globals.dart';
import '../../../../../core/utils/providers/date_time_provider.dart';
import '../../../../../core/utils/validators/form_validator.dart';
import '../../../../../core/widgets/custom/custom_form_field.dart';
import '../../../../../core/widgets/custom/date_time_bottom_sheet.dart';
import '../../home_view_model/home_view_model.dart';

class PaymentDetailsPage extends StatelessWidget {
  PaymentDetailsPage({Key? key}) : super(key: key);

  final HomeViewModel homeViewModel = sl();
  final DateTimeViewModel dateTimeProvider = sl();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: homeViewModel),
        ChangeNotifierProvider.value(value: dateTimeProvider),
      ],
      child: PaymentDetailsScreenContent(),
    );
  }
}

class PaymentDetailsScreenContent extends StatefulWidget {
  PaymentDetailsScreenContent({Key? key}) : super(key: key);

  @override
  State<PaymentDetailsScreenContent> createState() =>
      _PaymentDetailsScreenContentState();
}

class _PaymentDetailsScreenContentState
    extends State<PaymentDetailsScreenContent> {
  ValueNotifier<String> dateTime =
      ValueNotifier('${DateFormat('yyyy-MM-dd').format(DateTime.now())}');
HomeViewModel homeViewModel=sl();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar( title: 'Payment Details',color: Colors.white,),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Padding(
              padding:  EdgeInsets.only(left: 20.w),
              child: Text(
                'Payment Details',
                style: AppTheme.appTheme.textTheme.headline6!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 10.h),

            RadioListTile(
                title: Text(
                  'Cash On Delivery',
                  style: AppTheme.appTheme.textTheme.subtitle2,
                ),
                value: 1,
                activeColor: Theme.of(context).primaryColor,
                groupValue: homeViewModel.paymentTypesRadioController,
                onChanged: (value) {
                  setState(() {
                    homeViewModel.paymentTypesRadioController = value as int;
                  });
                }),
            RadioListTile(
                title: Text(
                  'One Click Payment',
                  style: AppTheme.appTheme.textTheme.subtitle2,
                ),
                activeColor: Theme.of(context).primaryColor,
                value: 2,
                groupValue: homeViewModel.paymentTypesRadioController,
                onChanged: (value) {
                  setState(() {
                    homeViewModel.paymentTypesRadioController = value as int;
                  });
                }),

            SizedBox(
              height: 20.h,
            ),
            homeViewModel.paymentTypesRadioController == 2
                ? paymentThroughCard(context)
                : Container(),
            Expanded(
              child: Container(),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ContinueButton(text: 'Pay',
                  loadingNotifier: homeViewModel.isCheckoutNotifier,
                  onPressed: ()async {
             await   context.read<HomeViewModel>().checkoutProduct();
                // context.read<HomeViewModel>().moveToStatus();

              }),
            ),
            SizedBox(
              height: 30.h,
            )
          ],
        ),
      ),
    );
  }

  Widget paymentThroughCard(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Enter your credit card details',
              style: AppTheme.appTheme.textTheme.subtitle1,
            ),
          ),
          Text(
            'Cardholder name',
            style: AppTheme.appTheme.textTheme.subtitle2,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: CustomTextFormField(
              maxLines: 1,
              controller: context.read<HomeViewModel>().cardHolderNameController,
              validator: FormValidators.validateName,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              // focusNode: context.read<HomeProvider>().registerFirstNameFocusNode,
              // onChanged: context.read<HomeProvider>().onRegisterFirstNameChange,
              // onFieldSubmitted: (_) => context.read<HomeProvider>().onRegisterFirstNameSubmitted(context),
            ),
          ),
          Text(
            'Card Number',
            style: AppTheme.appTheme.textTheme.subtitle2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 260.w,
                child: CustomTextFormField(
                  maxLines: 1,
                  controller: context.read<HomeViewModel>().cardNumberController,
                  validator: FormValidators.validateAccountNumber,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  // focusNode: context.read<HomeProvider>().registerFirstNameFocusNode,
                  // onChanged: context.read<HomeProvider>().onRegisterFirstNameChange,
                  // onFieldSubmitted: (_) => context.read<HomeProvider>().onRegisterFirstNameSubmitted(context),
                ),
              ),
              SvgPicture.asset(AppAssets.icMasterSvg),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Expiry date',
                      style: AppTheme.appTheme.textTheme.subtitle2,
                    ),
                    GestureDetector(
                      onTap: () async {
                        final selectDateTimeBottomSheet = DateTimeBottomSheet(
                            context: context,
                            initialSelectedDate:
                                context.read<HomeViewModel>().date,
                            isDob: false);
                        await selectDateTimeBottomSheet.show();
                        print(context.read<DateTimeViewModel>().dateTime.value);
                        if (context.read<DateTimeViewModel>().dateTime.value !=
                            null) {
                          dateTime.value = DateFormat('yyyy-MM-dd').format(
                              context.read<DateTimeViewModel>().dateTime.value!);
                        }
                      },
                      child: Card(
                        child: Container(
                          height: 30.h,
                          width: 130.w,
                          decoration: BoxDecoration(
                              // color: Colors.red.withOpacity(.7),
                              // color: const Color(0xFFC2C5C1),
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ValueListenableBuilder<String>(
                                    valueListenable: dateTime,
                                    builder: (_, date, __) {
                                      return Text(
                                        date,
                                        // style: const TextStyle(color: Color(0xFF006633)),
                                      );
                                    }),
                                const Icon(
                                  Icons.date_range,
                                  color: Color(0xFF1CB5B5),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CVV',
                    style: AppTheme.appTheme.textTheme.subtitle2,
                  ),
                  Card(
                    child: Container(
                      height: 30.h,
                      width: 130.w,
                      decoration: BoxDecoration(
                          // color: Colors.red.withOpacity(.7),
                          // color: const Color(0xFFC2C5C1),
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            ' ****',
                            style: TextStyle(color: Color(0xFF1CB5B5)),
                          ),
                          Icon(
                            Icons.question_mark,
                            color: Color(0xFF1CB5B5),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
