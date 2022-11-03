import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:radio_group_v2/radio_group_v2.dart';
import 'package:zstore_flutter/features/authentication/data/modals/login_response_modal.dart';
import 'package:zstore_flutter/features/authentication/presentation/auth_view_model/authentication_view_model.dart';
import 'package:zstore_flutter/features/profile/data/models/profile_image_response_model.dart';
import 'package:zstore_flutter/features/profile/data/models/update_profile_details_request_model.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/models/on_error_message_model.dart';
import '../../../../core/router/app_state.dart';
import '../../../../core/router/models/page_action.dart';
import '../../../../core/router/models/page_config.dart';
import '../../../../core/utils/enums/attachment_type.dart';
import '../../../../core/utils/enums/page_state_enum.dart';
import '../../../../core/utils/globals/globals.dart';
import '../../../../core/utils/globals/show_app_bar.dart';
import '../../data/models/profile_image_request_model.dart';
import '../../domain/usecases/get_profile_details_usecase.dart';

class ProfileViewModel extends ChangeNotifier {
  ProfileViewModel(this.updateProfileDetailsUsecase,this.updateProfileImageUsecase);
  UpdateProfileImageUsecase updateProfileImageUsecase;
  LoginResponseModel? loginResponseModel;

  AuthViewModel authViewModel = sl();
  AppState appState = GetIt.I.get<AppState>();

  ValueNotifier<File?> profileImgFile = ValueNotifier(null);
  ValueNotifier<bool> profileImageNotifier = ValueNotifier(false);
  ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);
  final GlobalKey<FormState> updateProfileFormKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  RadioGroupController genderRadioController = RadioGroupController();
  final List<String> genderValues = [
    'Male',
    'Female',
  ];

  bool isUpdateButtonPressed = false;
  bool isUpdateFirstNameError = false;
  bool isUpdateLastNameError = false;
  bool isEmailError = false;
  bool isMobileError = false;
  bool isAddressError = false;

  //focus nodes
  final FocusNode firstNameFocusNode = FocusNode();
  final FocusNode lastNameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode mobileFocusNode = FocusNode();
  final FocusNode addressFocusNode = FocusNode();

//onChange
  void onUpdateFirstNameChange(String value) {
    isUpdateButtonPressed = false;
    if (isUpdateFirstNameError) {
      updateProfileFormKey.currentState!.validate();
    }
  }

  void onUpdateLastNameChange(String value) {
    isUpdateButtonPressed = false;
    if (isUpdateLastNameError) {
      updateProfileFormKey.currentState!.validate();
    }
  }

  void onEmailChange(String value) {
    isUpdateButtonPressed = false;
    if (isEmailError) {
      updateProfileFormKey.currentState!.validate();
    }
  }

  void onMobileChange(String value) {
    isUpdateButtonPressed = false;
    if (isMobileError) {
      updateProfileFormKey.currentState!.validate();
    }
  }

  void onAddressChange(String value) {
    isUpdateButtonPressed = false;
    if (isAddressError) {
      updateProfileFormKey.currentState!.validate();
    }
  }

  void onUpdateFirstNameSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(lastNameFocusNode);
  }

  void onUpdateLastNameSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(emailFocusNode);
  }

  void onUpdateEmailSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(mobileFocusNode);
  }

  void onUpdateMobileSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(addressFocusNode);
  }

  void onUpdateAddressSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  ValueChanged<OnErrorMessageModel>? onErrorMessage;
  UpdateProfileDetailsUsecase updateProfileDetailsUsecase;
  ProfileImageResponseModel ? profileImageResponseModel;
  // UpdateProfileImageResponseModel? updateProfileImageResponseModel;

  //updateProfile function
  Future<void> updateProfile() async {
    isLoadingNotifier.value = true;

    var params = UpdateProfileDetailsRequestModel(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      contact: mobileController.text,
      address: addressController.text,
      gender: genderRadioController.value == 'Female' ? 'female' : 'male',
      customerID: authViewModel.userDetails!.data.userId,
    );
    var updateProfileEither = await updateProfileDetailsUsecase(params);

    if (updateProfileEither.isLeft()) {
      handleError(updateProfileEither);
      isLoadingNotifier.value = false;
    } else if (updateProfileEither.isRight()) {
      updateProfileEither.foldRight(null, (response, register) {
        updateProfileEither.foldRight(null, (response, _) {

          authViewModel.setCurrent(response);
          notifyListeners();
          GetIt.I.get<AppState>().moveToBackScreen();
          isLoadingNotifier.value = false;
          // ShowSnackBar.show(response.msg);


          // removeToDashboard();
          // clearFields();
        });
        isLoadingNotifier.value = false;
      });
      isLoadingNotifier.value = false;
    }
  }

  Future<void> setProfileImage(BuildContext context) async {
    profileImageNotifier.value = true;

    var params = ProfileImageRequestModel(userId: authViewModel.userDetails!.data.userId.toString(), image: profileImg.toString());

    var updateEither = await updateProfileImageUsecase(params);

    if (updateEither.isLeft()) {
      profileImageNotifier.value = false;

      handleError(updateEither);
    } else if (updateEither.isRight()) {
      updateEither.foldRight(null, (response, previous) {
        updateEither.foldRight(null, (response, _) async {
          authViewModel.userDetails=response;
          profileImgFile.value = null;
          ShowSnackBar.show(response.msg);
          // onErrorMessage?.call(OnErrorMessageModel(message: 'Updated', backgroundColor: Colors.green));
        });
        profileImageNotifier.value = false;
      });
      profileImageNotifier.value = false;
    }
  }

  XFile? selectedFile;
  String? profileImg = '';
  final TextEditingController profileImgController = TextEditingController();
  String profileImgId = '';
  // Methods
  Future<void> pickFiles(
      BuildContext context, AttachmentType type, String source) async {
    selectedFile = null;

    try {
      switch (source) {
        case 'camera':
          selectedFile = (await ImagePicker()
              .pickImage(source: ImageSource.camera, imageQuality: 50));
          break;
        case 'gallery':
          selectedFile = (await ImagePicker()
              .pickImage(source: ImageSource.gallery, imageQuality: 50));
          break;
      }

      if (selectedFile != null) {
        profileImgFile.value = File(selectedFile!.path);
        String? base64 = encodeToBase64(profileImgFile.value);
        if (base64 != null) {
          switch (type) {
            case AttachmentType.profileImage:
              profileImg = base64;
              profileImgController.text =
                  profileImgFile.value!.path.split('/').last;
              print('this is the name of the pic ${profileImgController.text}');
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

  Future<void> profileImageSelector(context) async {
    await showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: 150,
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.photo_camera,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: const Text('Camera'),
                  onTap: () async {
                    await pickFiles(
                        context, AttachmentType.profileImage, 'camera');
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                    leading: Icon(
                      Icons.photo_library,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: const Text('Pick From Gallery'),
                    onTap: () async {
                      await pickFiles(
                          context, AttachmentType.profileImage, 'gallery');
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

  void loadProfileData() {
  LoginResponseModel?  profileDetails= authViewModel.userDetails;
    if (authViewModel.userDetails != null) {
      firstNameController.text = profileDetails!.data.firstName;
      lastNameController.text = profileDetails.data.lastName;
      emailController.text = profileDetails.data.email;
      // genderRadioController.value = profileDetails.data.gender;
      mobileController.text = profileDetails.data.contact;
      addressController.text = profileDetails.data.address;
    }else{
      print('ohhhh');
    }
  }

  // Error Handling
  void handleError(Either<Failure, dynamic> either) {
    isLoadingNotifier.value = false;
    either.fold(
        (l) => onErrorMessage?.call(OnErrorMessageModel(message: l.message)),
        (r) => null);
  }
  void moveToUpdateProfielPage() {
    appState.currentAction = PageAction(
        state: PageState.addPage, page: PageConfigs.updateProfileConfig);
  }
}
