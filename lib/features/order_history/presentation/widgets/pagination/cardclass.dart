import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget zStoreCard({
  required BuildContext context,
  required String leadingIcon,
  required String titleOrder,
  required String titlePlacedOn,
  required String titleStatus,
  required String subtitleOrderId,
  required String subtitleDate,
  required String subtitleStatus,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r), // Image border
          child: SizedBox.fromSize(
            child: Image.network(leadingIcon, fit: BoxFit.cover),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              titleOrder,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(fontSize: 14.sp),
            ),
            Flexible(
              child: Text(
                subtitleOrderId.length > 5
                    ? subtitleOrderId.substring(0, 5) + '...'
                    : subtitleOrderId,
                style: Theme.of(context).textTheme.headline6?.copyWith(
                    fontSize: 12.sp,
                    color: Colors.black54,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              titlePlacedOn,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(fontSize: 14.sp),
            ),
            Text(
              subtitleDate.length > 10
                  ? subtitleDate.substring(0, 10) + '...'
                  : subtitleDate,
              style: Theme.of(context).textTheme.headline6?.copyWith(
                  fontSize: 12.sp,
                  color: Colors.black54,
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              titleStatus,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(fontSize: 14.sp),
            ),
            Text(
              subtitleStatus,
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 12.sp,
                    color: const Color(0xFF099808),
                  ),
            ),
          ],
        )
      ],
    ),
  );
}
