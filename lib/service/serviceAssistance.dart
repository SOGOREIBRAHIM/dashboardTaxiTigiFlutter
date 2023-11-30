import 'package:dashboard1/global/global.dart';
import 'package:dashboard1/models/userModel.dart';
import 'package:firebase_database/firebase_database.dart';


class AssistanceService {

  
  
  // Lire l'utilisateur actuel en ligne
  static Future<void> readCurrentOnlineInfo() async{
    currentUser = firebaseAuth.currentUser;
    DatabaseReference userRef = FirebaseDatabase.instance
      .ref()
      .child("users")
      .child(currentUser!.uid);
    
      final snap = await userRef.once();
      if(snap.snapshot.value != null){
        userModelCurrentInfo = UserModel.fromSnapshot(snap.snapshot);
        // print("___________________________________________");
        // print(userModelCurrentInfo); 
      }
  }


  // Future<void> getAllUsers() async {
  //   DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users");

  //   final snap = await usersRef.once();
  //   if(snap.snapshot.value != null){
      
  //     print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
  //     print(snap.snapshot.value);

  //     Map<dynamic, dynamic>? usersMap = snap.snapshot.value as Map<dynamic, dynamic>?;

  //     usersMap?.forEach((key, value) {
  //       if (value is Map) {
  //         UserModel user = UserModel.fromSnapshot(snap.snapshot);
  //         listUsers.add(user);
  //         print(listUsers);
  //         print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
  //       }
  //     });
  //   }
    
  // }

  


  

}

