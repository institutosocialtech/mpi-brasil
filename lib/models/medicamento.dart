import 'package:flutter/foundation.dart';

class Medicamento {

 final String name;
 final String description;
 bool isFavorite;

 Medicamento({
     @required this.name,
     @required this.description,
     this.isFavorite = false,
 });

}