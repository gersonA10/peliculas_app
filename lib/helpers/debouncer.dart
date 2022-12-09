import 'dart:async';

//cada vez hace una peticion http y consume mas megas o wi fi

//calse generica, recibira cualquier dato
class Debouncer<T> {
  Debouncer({required this.duration, this.onValue});

  final Duration duration;

  void Function(T value)? onValue;

  T? _value;
  Timer? _timer;

  T get value => _value!;

  set value(T val) {
    _value = val;
    //cancelar el timer
    _timer?.cancel();
    //si cimple la duration llamo a la funcion
    _timer = Timer(duration, () => onValue!(_value!));
  }
}
