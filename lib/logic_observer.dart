import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:colorize/colorize.dart';

class MyBlocObserver extends BlocObserver {

  //* onCreate
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log('${Colorize('onCreate -- ${bloc.runtimeType}').apply(Styles.LIGHT_CYAN)}');
  }

  //* onChange
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log(
      '${Colorize("onChange -- ${bloc.runtimeType}").apply(Styles.LIGHT_CYAN)}, ${Colorize(change.toString()).apply(
        Styles.LIGHT_CYAN,
      )}',
    );
  }

  //! onError
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log(
      '${Colorize('onError -- ${bloc.runtimeType}').apply(Styles.LIGHT_RED)}, ${Colorize(error.toString()).apply(
        Styles.LIGHT_RED,
      )}',
    );
    super.onError(bloc, error, stackTrace);
  }

  //* onClose
  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    log('${Colorize('onClose -- ${bloc.runtimeType}').apply(Styles.LIGHT_CYAN)}');
  }

  //* for Bolc
  /* @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('onEvent -- ${bloc.runtimeType}, $event');
  }*/
  //* for bloc
  /*
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('onTransition -- ${bloc.runtimeType}, $transition');
  }*/
}
