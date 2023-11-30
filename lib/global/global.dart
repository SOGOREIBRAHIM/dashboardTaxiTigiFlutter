import 'package:dashboard1/models/driverModel.dart';
import 'package:dashboard1/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';


final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

User? currentUser;

UserModel? userModelCurrentInfo;

List<UserModel> listUsers = [];

List<DriverModel> listDriver = [];



// String userDropOffAdress = "";

// DirectionDetailsInfo? tripDirectionDetailsInfo;

// String driverCarDetails = "";

// String driverName = "";

// String driverPhone = "";

// double countRatingStars = 0.0;

// String titleStarsRating = "";

// List driversList = [];

// String cloudMessagingServerToken = "key=APA91bHdTuOWVFbMKf3a_hSnuKOlDHJ652nzleGr_YLI0W2phKe4WmkOcqKCxOZ2uOd6ojjuHX-3FILaz9G8_md8EaOzjGA5exttOwPVmLeN8afEFw4g7tDflMey1ky9XH8uOM4j4kw4";

// String API_KEY = "AIzaSyDDGtmVxuMl8rMOacYgbdEfghp2xpOeYQg";

