
import 'package:flutter/material.dart';

navigator(context,destination){
  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
            return destination ;
          }));
}