import 'package:dashboard1/pages/administrateur.dart';
import 'package:dashboard1/pages/chauffeurs.dart';
import 'package:dashboard1/pages/dashboard.dart';
import 'package:dashboard1/pages/passagers.dart';
import 'package:dashboard1/pages/reservation.dart';
import 'package:get/get.dart';

class SideBarController extends GetxController {
  RxInt index = 0.obs;

  var pages = [
    Dashboard(),
    Reservation(),
    Passagers(),
    Chauffeurs(),
    Administrateur(),
  ];
}