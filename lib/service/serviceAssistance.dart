import 'package:dashboard1/global/global.dart';
import 'package:dashboard1/models/userModel.dart';
import 'package:firebase_database/firebase_database.dart';


class AssistanceService {
  
  // Lire l'utilisateur actuel en ligne
  static Future<void> readCurrentOnlineInfo()async{
    currentUser = firebaseAuth.currentUser;
    DatabaseReference userRef = FirebaseDatabase.instance
      .ref()
      .child("users")
      .child(currentUser!.uid);
    
      final snap = await userRef.once();
      if(snap.snapshot.value != null){
        userModelCurrentInfo = UserModel.fromSnapshot(snap.snapshot);
        print("___________________________________________");
        print(userModelCurrentInfo);
        print("--------------------------------------------");
      }
  }
}