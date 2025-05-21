// dart format width=200
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

import '../../data/database/database.dart';
import '../../data/database/shared_preferences_db.dart';
import '../../data/dao/application/application_dao.dart';
import '../../data/dao/application/data_import_export_dao.dart';
import '../../data/dao/application/security_key_dao.dart';
import '../../data/dao/mood/mood_data_dao.dart';
import '../../data/dao/mood/mood_category_dao.dart';
import '../../data/dao/statistic/statistic_dao.dart';
import '../../data/repositories/application/application_repository_local.dart';
import '../../data/repositories/application/data_import_export_repository_local.dart';
import '../../data/repositories/application/security_key_repository_local.dart';
import '../../data/repositories/mood/mood_data_repository_local.dart';
import '../../data/repositories/mood/mood_category_repository_local.dart';
import '../../data/repositories/statistic/statistic_repository_local.dart';

import '../../domain/repositories/application/application_repository.dart';
import '../../domain/repositories/application/data_import_export_repository.dart';
import '../../domain/repositories/application/security_key_repository.dart';
import '../../domain/repositories/mood/mood_data_repository.dart';
import '../../domain/repositories/mood/mood_category_repository.dart';
import '../../domain/repositories/statistic/statistic_repository.dart';
import '../../domain/use_cases/application/application_use_case.dart';
import '../../domain/use_cases/application/data_import_export_use_case.dart';
import '../../domain/use_cases/application/security_key_use_case.dart';
import '../../domain/use_cases/mood/mood_data_use_case.dart';
import '../../domain/use_cases/mood/mood_category_load_use_case.dart';
import '../../domain/use_cases/statistic/statistic_use_case.dart';

import '../view_models/application_view_model.dart';
import '../view_models/security_key_view_model.dart';
import '../view_models/notification_view_model.dart';
import '../view_models/mood_view_model.dart';
import '../view_models/statistic_view_model.dart';

abstract final class Dependencies {
  /// 共享的状态管理
  static List<SingleChildWidget> get _sharedProviders => [
    ..._useCaseProviders,

    ChangeNotifierProvider(lazy: true, create: (context) => ApplicationViewModel(applicationUseCase: context.read())),
    ChangeNotifierProvider(lazy: true, create: (context) => SecurityKeyViewModel(securityKeyUseCase: context.read())),
    ChangeNotifierProvider(lazy: true, create: (context) => NotificationViewModel(awesomeNotifications: context.read())),
    ChangeNotifierProvider(lazy: true, create: (context) => MoodViewModel(moodDataUseCase: context.read())),
    ChangeNotifierProvider(lazy: true, create: (context) => StatisticViewModel(statisticUseCase: context.read())),
  ];

  /// use case 依赖注入
  static List<SingleChildWidget> get _useCaseProviders => [
    Provider(lazy: true, create: (context) => ApplicationUseCase(applicationRepository: context.read())),
    Provider(lazy: true, create: (context) => DataImportExportUseCase(dataImportExportRepository: context.read())),
    Provider(lazy: true, create: (context) => SecurityKeyUseCase(securityKeyRepository: context.read())),
    Provider(lazy: true, create: (context) => MoodDataUseCase(moodDataRepository: context.read())),
    Provider(lazy: true, create: (context) => MoodCategoryLoadUseCase(moodCategoryRepository: context.read())),
    Provider(lazy: true, create: (context) => StatisticUseCase(statisticRepository: context.read())),
  ];

  /// 本地数据状态 依赖注入
  static List<SingleChildWidget> get providersLocal => [
    Provider.value(value: DB.instance),
    Provider.value(value: SharedPreferencesDB.instance),
    Provider.value(value: AwesomeNotifications()),

    Provider(create: (context) => ApplicationDao(sharedPreferencesDB: context.read())),
    Provider(create: (context) => DataImportExportDao(database: context.read())),
    Provider(create: (context) => SecurityKeyDao(sharedPreferencesDB: context.read())),
    Provider(create: (context) => MoodDataDao(database: context.read())),
    Provider(
      create: (context) => MoodCategoryDao(database: context.read(), sharedPreferencesDB: context.read()),
    ),
    Provider(create: (context) => StatisticDao(database: context.read())),

    Provider(create: (context) => ApplicationRepositoryLocal(applicationDao: context.read()) as ApplicationRepository),
    Provider(create: (context) => DataImportExportRepositoryLocal(dataImportExportDao: context.read()) as DataImportExportRepository),
    Provider(create: (context) => SecurityKeyRepositoryLocal(securityKeyDao: context.read()) as SecurityKeyRepository),
    Provider(create: (context) => MoodDataRepositoryLocal(moodDataDao: context.read()) as MoodDataRepository),
    Provider(create: (context) => MoodCategoryRepositoryLocal(moodCategoryDao: context.read()) as MoodCategoryRepository),
    Provider(create: (context) => StatisticRepositoryLocal(statisticDao: context.read()) as StatisticRepository),

    ..._sharedProviders,
  ];
}
