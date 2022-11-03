import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:zstore_flutter/features/feedback/data/data_sources/feedback_data_source.dart';
import 'package:zstore_flutter/features/feedback/domain/repository/feedback_repo.dart';
import 'package:zstore_flutter/features/feedback/domain/repository/feedback_repo_imp.dart';
import 'package:zstore_flutter/features/feedback/domain/usecases/feedback_usecase.dart';
import 'package:zstore_flutter/features/home/domain/repository/home_repo.dart';
import 'package:zstore_flutter/features/home/domain/repository/home_repo_imp.dart';
import 'package:zstore_flutter/features/home/presentation/home_view_model/cart_provider.dart';
import 'package:zstore_flutter/features/home/presentation/home_view_model/db_helper.dart';
import 'package:zstore_flutter/features/my_favrouits/data/data_source/favourite_data_source.dart';
import 'package:zstore_flutter/features/my_favrouits/domain/repository/favourit_repo.dart';
import 'package:zstore_flutter/features/my_favrouits/domain/repository/favourite_repo_imp.dart';
import 'package:zstore_flutter/features/my_favrouits/domain/usecases/favourite%20_usecase.dart';
import 'package:zstore_flutter/features/my_points/data/data_sources/my_points_data_source.dart';
import 'package:zstore_flutter/features/my_points/domain/repository/my_points_repo.dart';
import 'package:zstore_flutter/features/my_points/domain/repository/my_points_repo_imp.dart';
import 'package:zstore_flutter/features/my_points/domain/usecases/my_points_usecase.dart';
import 'package:zstore_flutter/features/order_history/domain/usecase/get_order_history_usecase.dart';
import 'package:zstore_flutter/features/order_tracking/data/data_sources/order_tracking_data_source.dart';
import 'package:zstore_flutter/features/order_tracking/domain/repository/order_tracking_repo.dart';
import 'package:zstore_flutter/features/order_tracking/domain/repository/order_tracking_repo_imp.dart';
import 'package:zstore_flutter/features/profile/data/data_sources/profile_data_source.dart';
import 'package:zstore_flutter/features/profile/domain/repository/profile_repo.dart';
import 'package:zstore_flutter/features/profile/domain/usecases/get_profile_details_usecase.dart';
import 'package:zstore_flutter/features/reviews/data/data_sources/review_data_source.dart';
import 'package:zstore_flutter/features/reviews/domain/repository/reviews_repo.dart';
import 'package:zstore_flutter/features/reviews/domain/usecases/reviews_usecase.dart';
import 'core/router/app_state.dart';
import 'core/utils/globals/globals.dart';
import 'core/utils/network/network_info.dart';
import 'core/utils/providers/date_time_provider.dart';
import 'core/utils/services/secure_storage_servic.dart';
import 'features/authentication/data/data_sources/auth_data_source.dart';
import 'features/authentication/domain/repository/auth_repo_imp.dart';
import 'features/authentication/domain/repository/auth_repo.dart';
import 'features/authentication/domain/usecases/auth_usecase.dart';
import 'features/authentication/presentation/auth_view_model/authentication_view_model.dart';
import 'features/dashboard/presentation/dashboard_view_model/dashboard_view_model.dart';
import 'features/feedback/presentation/feedback_view_model/feedback_view_model.dart';
import 'features/home/data/data_sources/home_data_source.dart';
import 'features/home/domain/usecases/home_usecase.dart';
import 'features/home/presentation/home_view_model/home_view_model.dart';
import 'features/my_favrouits/presentation/my_favrouits_view_model/my_favrouits_view_model.dart';
import 'features/my_membership/presentation/my_membership_view_model/my_membership_view_model.dart';
import 'features/my_points/presentation/my_points_view_model/my_points_view_model.dart';
import 'features/order_history/data/data_sources/order_history_data_source.dart';
import 'features/order_history/domain/repository/order_history_repo.dart';
import 'features/order_history/domain/repository/order_history_repo_imp.dart';
import 'features/order_history/presentation/order_history_view_model/order_history_view_model.dart';
import 'features/order_tracking/presentation/order_tracking_view_model/order_tracking_view_model.dart';
import 'features/profile/domain/repository/profile_repo_imp.dart';
import 'features/profile/presentation/profile_view_model/profile_view_model.dart';
import 'features/reviews/domain/repository/reviews_repo_imp.dart';
import 'features/reviews/presentation/reviews_view_model/reviews_view_model.dart';

Future<void> init() async {
  /// UseCases
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => RegisterationUsecase(sl()));
  sl.registerLazySingleton(() => LogoutUsecase(sl()));
  // sl.registerLazySingleton(() => ForgetPasswordUsecase(sl()));
  sl.registerLazySingleton(() => ValidateOtpUsecase(sl()));
  sl.registerLazySingleton(() => GenerateOtpUsecase(sl()));
  sl.registerLazySingleton(() => UpdatePasswordUsecase(sl()));
  sl.registerLazySingleton(() => GetProfileDetailsUsecase(sl()));
  sl.registerLazySingleton(() => UpdateProfileDetailsUsecase(sl()));
  sl.registerLazySingleton(() => FeedbackUsecase(sl()));
  sl.registerLazySingleton(() => GetReviewsUsecase(sl()));
  sl.registerLazySingleton(() => UpdateProfileImageUsecase(sl()));
  sl.registerLazySingleton(() => GetCategoriesAndProductUsecase(sl()));
  sl.registerLazySingleton(() => GetProductByIdUsecase(sl()));
  sl.registerLazySingleton(() => GetProductsBySubCategoryUsecase(sl()));
  sl.registerLazySingleton(() => GetSubCategoriesByCategoryUsecase(sl()));
  sl.registerLazySingleton(() => CheckoutUsecase(sl()));
  sl.registerLazySingleton(() => AddToFavouriteUsecase(sl()));
  sl.registerLazySingleton(() => GetOrderHistoryUsecase(sl()));
  sl.registerLazySingleton(() => GetFavouritesUSeCase(sl()));
  sl.registerLazySingleton(() => DeleteFavouriteUSseCaase(sl()));
  sl.registerLazySingleton(() => GetFeedbackUsecase(sl()));
  sl.registerLazySingleton(() => GetOrderHistoryDetailsUsecase(sl()));
  sl.registerLazySingleton(() => ClearOrderHistoryUsecase(sl()));
  sl.registerLazySingleton(() => SeeReviewDetailsUsecase(sl()));
  sl.registerLazySingleton(() => AddReviewsUsecase(sl()));
  sl.registerLazySingleton(() => GetTotalPointsUsecase(sl()));

  /// Data Sources

  sl.registerLazySingleton<AuthDataSource>(() => AuthDataSourceImp(dio: sl()));
  sl.registerLazySingleton<ProfileDataSource>(
      () => ProfileDataRepoImp(dio: sl()));
  sl.registerLazySingleton<FeedbackDataSource>(
      () => FeedbackDataImp(dio: sl()));
  sl.registerLazySingleton<ReviewsDataSource>(() => ReviewsDataImp(dio: sl()));
  sl.registerLazySingleton<HomeDataSource>(() => HomeDataImp(dio: sl()));
  sl.registerLazySingleton<FavouriteDataSource>(
      () => FavouriteDataImp(dio: sl()));

  sl.registerLazySingleton<OrderTrackingDataSource>(
      () => OrderTrackingDataImp(dio: sl()));

  sl.registerLazySingleton<OrderHistoryDataSource>(
      () => OrderHistoryDataImp(dio: sl()));
  sl.registerLazySingleton<MyPointsDataSource>(
      () => MyPointsDataImp(dio: sl()));
  // sl.registerLazySingleton<DashboardRepository>(() => DashboardRepoImp(dashboardDataSource: sl(), networkInfo: sl()));

  /// Configs

  /// Repository
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepoImp(authDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<ProfileRepository>(
      () => ProfileRepoImp(networkInfo: sl(), profileDataSource: sl()));
  sl.registerLazySingleton<FeedbackRepository>(
      () => FeedbackRepoImp(dataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<ReviewsRepository>(
      () => ReviewsRepoImp(dataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<HomeRepository>(
      () => HomeRepoImp(dataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<FavouriteRepo>(
      () => FavouriteRepoImp(dataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<OrderHistoryRepository>(() =>
      OrderHistoryRepoImp(orderHistoryDataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<OrderTrackingRepository>(() =>
      OrderTrackingRepoImp(networkInfo: sl(), orderTrackingDataSource: sl()));
  sl.registerLazySingleton<MyPointsRepository>(() =>
      MyPointsRepoImp(networkInfo: sl(), dataSource: sl()));

  /// External
  sl.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<SecureStorageService>(() => SecureStorageService());
  sl.registerLazySingleton<DBHelper>(() => DBHelper());

  /// View Models
  sl.registerLazySingleton<AuthViewModel>(() => AuthViewModel(
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
      ));
  sl.registerLazySingleton(() => DateTimeViewModel());
  sl.registerLazySingleton(() => DashboardViewModel());
  sl.registerLazySingleton(() => HomeViewModel(sl(), sl(), sl(), sl(), sl()));
  sl.registerLazySingleton(() => ProfileViewModel(sl(), sl()));
  sl.registerLazySingleton(() => OrderHistoryViewModel(sl(), sl(), sl()));
  sl.registerLazySingleton(() => MyPointsViewModel(sl()));
  sl.registerLazySingleton(() => FavouriteViewModel(sl(),sl(),sl()));
  sl.registerLazySingleton(() => FeedbackViewModel(sl(),sl()));
  sl.registerLazySingleton(() => ReviewsViewModel(sl(),sl(),sl()));

  sl.registerLazySingleton(() => MyMemberShipViewModel());
  sl.registerLazySingleton(() => OrderTrackingViewModel());
  sl.registerLazySingleton(() => CartProvider());

  /// Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  /// Navigator
  sl.registerLazySingleton(() => AppState());
}
