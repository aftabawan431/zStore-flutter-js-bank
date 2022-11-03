import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:zstore_flutter/features/authentication/presentation/auth_view_model/authentication_view_model.dart';
import 'package:zstore_flutter/features/reviews/data/models/add_review_details_response_model.dart';
import 'package:zstore_flutter/features/reviews/data/models/add_reviews_request_model.dart';
import 'package:zstore_flutter/features/reviews/data/models/see_review_details_response_model.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/models/on_error_message_model.dart';
import '../../../../core/router/app_state.dart';
import '../../../../core/router/models/page_action.dart';
import '../../../../core/router/models/page_config.dart';
import '../../../../core/utils/enums/attachment_type.dart';
import '../../../../core/utils/enums/page_state_enum.dart';
import '../../../../core/utils/globals/globals.dart';
import '../../data/models/get_all_reviews_response_model.dart';
import '../../domain/usecases/reviews_usecase.dart';

class ReviewsViewModel extends ChangeNotifier{
  ReviewsViewModel( this.getAllReviewsUsecase, this.addReviewsUsecase, this.seeReviewDetailsUsecase);
  ValueNotifier<File?> ratingImgFileNotifier = ValueNotifier(null);
  ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);
  ValueChanged<OnErrorMessageModel>? onErrorMessage;
  AppState appState = GetIt.I.get<AppState>();
  GetReviewsUsecase getAllReviewsUsecase;
  SeeReviewDetailsUsecase seeReviewDetailsUsecase;
  AddReviewsUsecase addReviewsUsecase;
  SeeReviewDetailsResponseModel? seeReviewDetailsResponseModel;
  AddReviewResponseModel? addReviewResponseModel;
  GetAllReviewsResponseModel ? getReviewResponseModel;
  ValueNotifier<bool> isSeeReviewDetailsNotifier = ValueNotifier(true);
  ValueNotifier<bool> getAllReviewsNotifier = ValueNotifier(true);
  ValueNotifier<bool> addReviewsNotifier = ValueNotifier(false);
  final TextEditingController commentController = TextEditingController();
AuthViewModel authViewModel =sl();
  XFile? selectedFile;
  String? reviewImg ;
  final TextEditingController reviewsImgController = TextEditingController();


  final GlobalKey<FormState> reviewFormFormKey = GlobalKey<FormState>();

  List<String> reviewFilesList = [];
  List<String> reviewFilesNameList = [];
  // Methods

  Future<void> seeReviewDetails({required String reviewId}) async {
    print('it is calling seeReviewDetailsResponseModel');
    isSeeReviewDetailsNotifier.value = true;

    var getReviewDetailsEither = await seeReviewDetailsUsecase.call(reviewId);

    if (getReviewDetailsEither.isLeft()) {
      handleError(getReviewDetailsEither);
      isSeeReviewDetailsNotifier.value = false;
    } else if (getReviewDetailsEither.isRight()) {
      getReviewDetailsEither.foldRight(null, (response, _) {
        seeReviewDetailsResponseModel=null;
        seeReviewDetailsResponseModel = response;
        print('hi');
        Logger().v(seeReviewDetailsResponseModel!.toJson());
        print('hu');
        moveToSeeReviewDetails();
        notifyListeners();
        print(
            'this is the response of seeReviewDetailsResponseModel $seeReviewDetailsResponseModel');
      });
      isSeeReviewDetailsNotifier.value = false;

      //
    }
  }
  Future<void> getAllReviews({required String productId}) async {
    print('it is calling getAllReviews');
    getAllReviewsNotifier.value = true;

    var getAllReviewsEither = await getAllReviewsUsecase.call(productId);

    if (getAllReviewsEither.isLeft()) {
      handleError(getAllReviewsEither);
      getAllReviewsNotifier.value = false;
    } else if (getAllReviewsEither.isRight()) {
      getAllReviewsEither.foldRight(null, (response, _) {
        getReviewResponseModel=null;
        getReviewResponseModel = response;

        moveToReviews();
        print('hi');
        Logger().v(getReviewResponseModel!.toJson());
        print('hu');
        notifyListeners();

        print(
            'this is the response of seeReviewDetailsResponseModel $getReviewResponseModel');
      });
      getAllReviewsNotifier.value = false;

      //
    }
  }
  Future<void> addYourReviews(String productId,int rating,String comment,List<String> images) async {
    addReviewsNotifier.value = true;

    var params = AddReviewRequestModel(productId: productId,
        customerId: authViewModel.userDetails!.data.userId, rating: rating, comment: comment, images: images);
    var addYourReviewEither = await addReviewsUsecase(params);

    if (addYourReviewEither.isLeft()) {
      handleError(addYourReviewEither);
      addReviewsNotifier.value = false;
    } else if (addYourReviewEither.isRight()) {
      addYourReviewEither.foldRight(null, (response, register) {
        addYourReviewEither.foldRight(null, (response, _) {
    addReviewResponseModel=response;
    // getReviewResponseModel=null;
    getAllReviews(productId: getReviewResponseModel!.ID);
          notifyListeners();
          // GetIt.I.get<AppState>().moveToBackScreen();
    addReviewsNotifier.value = false;
          // ShowSnackBar.show(response.msg);


          // removeToDashboard();
          // clearFields();
        });
        addReviewsNotifier.value = false;
      });
      addReviewsNotifier.value = false;
    }
  }


  Future<void> pickFiles(BuildContext context, AttachmentType type, String source) async {
    selectedFile = null;

    try {
      switch (source) {
        case 'camera':
          selectedFile = (await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 50));
          break;
        case 'gallery':
          selectedFile = (await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 50));
          break;
      }

      if (selectedFile != null) {
        ratingImgFileNotifier.value = File(selectedFile!.path);
        String? base64 = encodeToBase64(ratingImgFileNotifier.value);
        if (base64 != null) {
          switch (type) {
            case AttachmentType.reviews:
              reviewImg = base64;
              reviewsImgController.text = ratingImgFileNotifier.value!.path.split('/').last;
              print('this is the name of the pic ${reviewsImgController.text}');
              break;
          }
        }
      }
    } on PlatformException catch (e) {
      onErrorMessage?.call(OnErrorMessageModel(message: e.message.toString()));
    } catch (e) {
      onErrorMessage?.call(OnErrorMessageModel(message: e.toString()));
    }
  }

  Future<void> reviewImageSelector(context) async {
    await showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: 150,
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading:  Icon(
                    Icons.photo_camera,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: const Text('Camera'),
                  onTap: () async {
                    await pickFiles(context, AttachmentType.profileImage, 'camera');
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                    leading:  Icon(
                      Icons.photo_library,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: const Text('Pick From Gallery'),
                    onTap: () async {
                      await pickFiles(context, AttachmentType.profileImage, 'gallery');
                      Navigator.of(context).pop();
                    }),
              ],
            ),
          );
        });
  }

  String? encodeToBase64(File? file) {
    if (file != null) {
      List<int> imageBytes = file.readAsBytesSync();
      return base64Encode(imageBytes);
    }
    return null;
  }

  void moveToSeeReviewDetails() {
    appState.currentAction = PageAction(
        state: PageState.addPage,
        page: PageConfigs.seeReviewDetailsPage);
  }
  void moveToReviews() {
    appState.currentAction = PageAction(
        state: PageState.addPage,
        page: PageConfigs.reviewScreenPage);
  }

  // Error Handling
  void handleError(Either<Failure, dynamic> either) {
    isLoadingNotifier.value = false;
    either.fold((l) => onErrorMessage?.call(OnErrorMessageModel(message: l.message)), (r) => null);
  }

}