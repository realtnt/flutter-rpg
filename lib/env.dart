import 'package:envied/envied.dart';
part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'ANDROID_GOOGLE_API_KEY', obfuscate: true)
  static final String androidGoogleApiKey = _Env.androidGoogleApiKey;
  
  @EnviedField(varName: 'IOS_GOOGLE_API_KEY', obfuscate: true)
  static final String iosGoogleApiKey = _Env.iosGoogleApiKey;
}
