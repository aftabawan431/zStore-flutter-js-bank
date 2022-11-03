import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:radio_group_v2/radio_group_v2.dart';
import 'package:zstore_flutter/core/models/no_params.dart';
import 'package:zstore_flutter/features/authentication/presentation/auth_view_model/authentication_view_model.dart';
import 'package:zstore_flutter/features/home/data/models/cart_model.dart';
import 'package:zstore_flutter/features/home/data/models/checkout_request_model.dart';
import 'package:zstore_flutter/features/home/data/models/checkout_response_model.dart';
import 'package:zstore_flutter/features/home/data/models/get_product_by_id_response_model.dart';
import 'package:zstore_flutter/features/home/data/models/get_sub_categories_by_category_response_model.dart';
import 'package:zstore_flutter/features/home/presentation/home_view_model/cart_provider.dart';
import 'package:zstore_flutter/features/my_favrouits/presentation/my_favrouits_view_model/my_favrouits_view_model.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/models/on_error_message_model.dart';
import '../../../../core/router/app_state.dart';
import '../../../../core/router/models/page_action.dart';
import '../../../../core/router/models/page_config.dart';
import '../../../../core/utils/enums/page_state_enum.dart';
import '../../../../core/utils/globals/globals.dart';
import '../../../order_history/presentation/order_history_view_model/order_history_view_model.dart';
import '../../data/models/get_categories_products_response_model.dart';
import '../../data/models/get_products_by_sub_category_response_model.dart';
import '../../domain/usecases/home_usecase.dart';
import 'dart:io' show Platform;

class HomeViewModel extends ChangeNotifier {
  HomeViewModel(
      this.getCategoriesAndProductUsecase,
      this.getProductByIdUsecase,
      this.checkoutUsecase,
      this.getSubCategoriesByCategoryUsecase,
      this.getProductsBySubCategoryUsecase);
  AppState appState = GetIt.I.get<AppState>();

  // ;

//payment details

  final TextEditingController addressController = TextEditingController();
  final FocusNode addressFocusNode = FocusNode();
  bool isRegisterButtonPressed = false;
  bool isNewShippingAddressError = false;
  var paymentTypesRadioController = 2;

  int sizeIndex = 0;
  setSize(int value){
    sizeIndex=value;
    notifyListeners();
  }
  String ? size;


  //FavouriteViewModel favouriteViewModel=sl();
  String? channel = '';
  final GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  ValueNotifier<bool> isRatingValueNotifier = ValueNotifier(true);
  RadioGroupController deliveryOptionRadioController = RadioGroupController();

  GetCategoriesAndProductUsecase getCategoriesAndProductUsecase;
  ValueChanged<OnErrorMessageModel>? onErrorMessage;

  final TextEditingController cardHolderNameController =
      TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  DateTime date = DateTime.now();

  final initialCameraPosition = CameraPosition(
    target: LatLng(33.720000, 73.060000),
    zoom: 11.5,
  );

  final List<String> deliveryOptionValues = [
    'Free',
    '50\$ is the standard rate to deliver',
  ];

  double rating = 2;

  void getChannel() {
    if (Platform.isIOS) {
      channel = 'IOS APP';
      print(channel);
    } else if (Platform.isAndroid) {
      channel = 'ANDROID APP';
      print(channel);
    }
  }

  ratingStars() {
    return RatingBar.builder(
      direction: Axis.horizontal,
      // allowHalfRating: true,
      initialRating: getProductByIdResponseModel!.data.ratingNumber.toDouble(),
      itemCount: 5,
      itemBuilder: (context, _) => const Icon(
        Icons.star_border,
        color: Colors.amber,
        size: 5,
      ),
      ignoreGestures: false,
      tapOnlyMode: false,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      onRatingUpdate: (value) {
        rating = getProductByIdResponseModel!.data.ratingNumber.toDouble();
        print(rating);
        isRatingValueNotifier.value = false;
      },
    );
  }

  GetCategoriesAndProductsResponseModel? dashboardDetails;
  ValueNotifier<bool> isGotDetailsNotifier = ValueNotifier(true);

  Future<void> getCategoriesAndProductsList({bool recall = false}) async {
    if (!recall) {
      if (dashboardDetails != null) {
        return;
      }
    }
    print('it is calling');
    isGotDetailsNotifier.value = true;

    var getDashboardDetailsEither =
        await getCategoriesAndProductUsecase.call(NoParams());

    if (getDashboardDetailsEither.isLeft()) {
      handleError(getDashboardDetailsEither);
      isGotDetailsNotifier.value = false;
    } else if (getDashboardDetailsEither.isRight()) {
      getDashboardDetailsEither.foldRight(null, (response, _) {
        dashboardDetails = response;
        print(
            'this is the response of getDashboardDetails ${dashboardDetails}');
      });
      isGotDetailsNotifier.value = false;
      //
    }
  }

  GetProductByIdResponseModel? getProductByIdResponseModel;
  GetProductByIdUsecase getProductByIdUsecase;
  ValueNotifier<bool> isGotProductByIdNotifier = ValueNotifier(true);
  ValueNotifier<Variant?> additionalDescription = ValueNotifier(null);
  ValueNotifier<bool> isGotCategoriesByCatIdNotifier = ValueNotifier(true);

  Future<void> getProductById({required String productId}) async {
    print('it is calling getCategoriesAndProductsResponseModel');
    isGotProductByIdNotifier.value = true;

    var getProductByIdEither = await getProductByIdUsecase.call(productId);

    if (getProductByIdEither.isLeft()) {
      handleError(getProductByIdEither);
      isGotProductByIdNotifier.value = false;
    } else if (getProductByIdEither.isRight()) {
      getProductByIdEither.foldRight(null, (response, _) {
        getProductByIdResponseModel = null;
        getProductByIdResponseModel = response;
        print('hi');
        Logger().v(getProductByIdResponseModel!.toJson());
        print('hu');

        additionalDescription.value == null;
        if (getProductByIdResponseModel!.data.variant.isNotEmpty) {
          additionalDescription.value =
              getProductByIdResponseModel!.data.variant.first;
        }
        FavouriteViewModel favouriteViewModel=sl();

        favouriteViewModel.getFavourites();

        notifyListeners();


        print(
            'this is the response of getProductByIdResponseModel $getProductByIdResponseModel');
      });
      isGotProductByIdNotifier.value = false;

      //
    }
  }

  GetProductsBySubCategoryUsecase getProductsBySubCategoryUsecase;
  CheckoutUsecase checkoutUsecase;
  GetProductsBySubCategoriesResponseModel?
      getProductsBySubCategoriesResponseModel;
  CheckoutResponseModel? checkoutResponseModel;
  GetSubCategoriesByCategoryUsecase getSubCategoriesByCategoryUsecase;
  GetSubCategoriesByCategoryIdResponseModel?
      getSubCategoriesByCategoryIdResponseModel;
  ValueNotifier<bool> isGotProductsBySubCategoryNotifier = ValueNotifier(true);
  ValueNotifier<bool> isCheckoutNotifier = ValueNotifier(false);

  Future<void> getProductsBySubCategory({required String subCategoryId}) async {
    print('it is calling getCategoriesAndProductsResponseModel');
    isGotProductsBySubCategoryNotifier.value = true;

    var getProductByIdEither =
        await getProductsBySubCategoryUsecase.call(subCategoryId);

    if (getProductByIdEither.isLeft()) {
      handleError(getProductByIdEither);
      isGotProductsBySubCategoryNotifier.value = false;
    } else if (getProductByIdEither.isRight()) {
      getProductByIdEither.foldRight(null, (response, _) {
        getProductsBySubCategoriesResponseModel = response;
        isGotProductsBySubCategoryNotifier.value = false;
        print("calling f");
        Logger().v(getProductsBySubCategoriesResponseModel!.toJson());
      });

      //
    }
  }

  AuthViewModel authViewModel = sl();
  CartProvider cartProvider = sl();
  Future<void> checkoutProduct() async {
    getChannel();
    print('it is calling checkoutProduct');
    isCheckoutNotifier.value = true;

    final params = CheckoutRequestModel(
        customer: authViewModel.userDetails!.data.userId.toString(),
        product: cartProvider.cart
            .map((e) => Product(
                productId: e.productId!,
                quantity: e.quantity!,
                price: e.productPrice!,
                sku: e.sku!,
            size: 'XL'))
            .toList(),
        address: addressController.text,
        contact: authViewModel.userDetails!.data.contact.toString(),
        paymentMode: paymentTypesRadioController == 2 ? '' : 'cod',
        totalBill: cartProvider.getTotalPrice().toString(),
        channel: channel!);
    var chekcoutEither = await checkoutUsecase.call(params);
    if (chekcoutEither.isLeft()) {
      handleError(chekcoutEither);
      isCheckoutNotifier.value = false;
    } else if (chekcoutEither.isRight()) {
      chekcoutEither.foldRight(null, (response, _) {
        OrderHistoryViewModel orderHistoryViewModel = sl();
        orderHistoryViewModel.getOrderHistoryResponseModel = null;
        orderHistoryViewModel.getOrderHistory();

        cartProvider.cart.clear();
        cartProvider.emptyCounter();
        moveToStatus();
        checkoutResponseModel = response;
        // additionalDescription.value==null;
        // if(getProductByIdResponseModel!.data.additionalDescription.isNotEmpty) {
        //   additionalDescription.value=getProductByIdResponseModel!.data.additionalDescription.first;
        // }
      });
      isCheckoutNotifier.value = false;

      //
    }
  }

  void onAddressChange(String value) {
    isRegisterButtonPressed = false;
    if (isNewShippingAddressError) {
      addressFormKey.currentState!.validate();
    }
  }

  void onAddressSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  // get Sub Categories by CatId
  Future<void> getSubCategoriesByCategoryId(
      {required String categoryId}) async {
    print('it is calling getCategoriesAndProductsResponseModel');
    isGotCategoriesByCatIdNotifier.value = true;

    var getProductByIdEither =
        await getSubCategoriesByCategoryUsecase.call(categoryId);

    if (getProductByIdEither.isLeft()) {
      handleError(getProductByIdEither);
      isGotCategoriesByCatIdNotifier.value = false;
    } else if (getProductByIdEither.isRight()) {
      getProductByIdEither.foldRight(null, (response, _) {
        getSubCategoriesByCategoryIdResponseModel = response;
        // getProductsBySubCategoriesResponseModel=null;

        print(
            'this is the response of getSubCategoriesByCategoryIdResponseModel'
            ' ${getSubCategoriesByCategoryIdResponseModel!.data.subcategories.first.id}');
      });
      isGotCategoriesByCatIdNotifier.value = false;

      //
    }
  }

  void moveToProductsBySubCategoriesPage() {
    appState.currentAction = PageAction(
        state: PageState.addPage,
        page: PageConfigs.productsBySubCategoriesConfig);
  }

  void moveToCategoriesPage() {
    appState.currentAction = PageAction(
        state: PageState.addPage, page: PageConfigs.categoriesPageConfig);
  }

  void moveToCheckout() {
    appState.currentAction = PageAction(
        state: PageState.replaceAll, page: PageConfigs.dashboardPageConfig);
  }

  void moveToStatus() {
    appState.currentAction =
        PageAction(state: PageState.addPage, page: PageConfigs.statusConfig);
  }

  // void moveToDashboard() {
  //   appState.currentAction = PageAction(state: PageState., page: PageConfigs.dashboardPageConfig);
  // }
  void moveToNewShipping() {
    appState.currentAction = PageAction(
        state: PageState.addPage, page: PageConfigs.newShippingAddressConfig);
  }

  void moveToPaymentDetails() {
    appState.currentAction = PageAction(
        state: PageState.addPage, page: PageConfigs.paymentDetailsConfig);
  }

  void moveToProductDetails() {
    appState.currentAction = PageAction(
        state: PageState.addPage, page: PageConfigs.productDetailsConfig);
  }

  void moveToReviews() {
    appState.currentAction = PageAction(
        state: PageState.addPage, page: PageConfigs.reviewScreenPage);
  }

  // Error Handling
  void handleError(Either<Failure, dynamic> either) {
    isGotDetailsNotifier.value = false;
    either.fold(
        (l) => onErrorMessage?.call(OnErrorMessageModel(message: l.message)),
        (r) => null);
  }
}
