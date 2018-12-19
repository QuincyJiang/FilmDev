import 'dart:async';
import 'package:film_dev/providers/bloc_provider.dart';

class DevMedicBloc implements BlocBase{
  String _brand;
  StreamController<String> _selectedBrandController = StreamController<String>();
  Sink<String> get _inSelectedBrand => _selectedBrandController.sink;
  Stream<String> get _outSelectedBrand => _selectedBrandController.stream;

  StreamController<String> _changeBrandController  = StreamController<String>();
  Sink<String> get updateBrand => _changeBrandController.sink;

  void dispose() {
    _selectedBrandController.close();
    _changeBrandController.close();
  }
  void changeBrand(String brand){
    _brand = brand;
    _inSelectedBrand.add(brand);
  }
}
