import 'package:flutter/cupertino.dart';
import 'package:way_up/config/routes/app_router.dart';
import 'package:way_up/config/themes/main_theme.dart';
import 'services/storage_service/local_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Demo',
      theme: mainTheme,
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: "/",
    );
  }
}
