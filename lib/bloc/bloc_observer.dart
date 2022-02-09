import 'package:bloc/bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onTrasition(Bloc bloc, Transition transition){
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print(error);
  }
}