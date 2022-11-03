import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';

import '../../../../core/utils/globals/globals.dart';
import '../../../../core/widgets/custom/custom_app_bar.dart';

const kPrimaryColor = Color(0xFFFF8084);
const kWhiteColor = Color(0xFFFFFFFF);
const kLightColor = Color(0xFF808080);
const kDarkColor = Color(0xFF303030);

class OrderTrackingPage extends StatelessWidget {
  const OrderTrackingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrderTrackingPageContent();
  }
}

class OrderTrackingPageContent extends StatefulWidget {
  @override
  _OrderTrackingPageContentState createState() =>
      _OrderTrackingPageContentState();
}

class _OrderTrackingPageContentState extends State<OrderTrackingPageContent> {
  int a = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Order Tracking',
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Wed, 12 September",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Color(0xFF808080),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Order ID : 5136 - 9ui2 - 129i2",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Color(0xFF808080),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 16.0,
              ),
              child: Text(
                "Orders",
                style: TextStyle(
                  fontSize: 22.0,
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width / 6,
                  child: IconStepper(
                    direction: Axis.vertical,
                    enableNextPreviousButtons: false,
                    enableStepTapping: false,
                    stepColor: a == 1 ? Colors.green : Colors.grey,
                    activeStepBorderColor: Colors.white,
                    activeStepBorderWidth: 0.0,
                    activeStepBorderPadding: 0.0,
                    lineColor: Colors.green,
                    lineLength: 70.0,
                    lineDotRadius: 2.0,
                    stepRadius: 16.0,
                    icons: [
                      a == 2
                          ? Icon(Icons.radio_button_checked, color: Colors.grey)
                          : Icon(Icons.radio_button_checked,
                              color: Colors.green),
                      a == 1
                          ? Icon(Icons.check, color: Colors.white)
                          : Icon(Icons.check, color: Colors.white),
                      a == 2
                          ? Icon(Icons.radio_button_checked,
                              color: Colors.green)
                          : Icon(Icons.radio_button_checked, color: Colors.red),
                      a == 2
                          ? Icon(Icons.radio_button_checked,
                              color: Colors.green)
                          : Icon(Icons.radio_button_checked, color: Colors.red),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: trackOrderList.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: ListTile(
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 16.0),
                              leading: Icon(
                                trackOrderList[index].icon,
                                size: 48.0,
                                color: a == index ? kPrimaryColor : Colors.grey,
                              ),
                              title: Text(
                                trackOrderList[index].title.toString(),
                                style: TextStyle(fontSize: 18.0),
                              ),
                              subtitle: Text(
                                trackOrderList[index].subtitle.toString(),
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ),
                          Text(
                            trackOrderList[index].time.toString(),
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              padding: EdgeInsets.only(left: 24.0, top: 16.0, bottom: 16.0),
              decoration: BoxDecoration(
                color: kWhiteColor,
                border: Border.all(
                  width: 0.5,
                  color: kLightColor,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Icon(Icons.home, size: 64.0, color: kPrimaryColor),
                  SizedBox(width: 32.0),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Delivery Address",
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Text(
                          "Home, Work & Other Address",
                          style: TextStyle(
                            fontSize: 15.0,
                            color: kDarkColor.withOpacity(0.7),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.8,
                          child: Text(
                            "Gulberg Islamabad",
                            style: TextStyle(
                              fontSize: 15.0,
                              color: kDarkColor.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
