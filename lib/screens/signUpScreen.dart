import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:local_shop/models/user.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isVisiable = true;
  late FirebaseAuth _firebaseAuth;
  var formKey = GlobalKey<FormState>();
  var user =
      UserRegister(UserName: "", Password: "", PhoneNumber: "", Email: "");
  // Auth() {
  //   _intializeMe().then((_) {
  //     _firebaseAuth = FirebaseAuth.instance;
  //   });
  // }

  // Future<FirebaseApp> _intializeMe() async {
  //   return await Firebase.initializeApp();
  // }

  // @override
  // void initState() {
  //   Auth();
  // }

  void SaveForm() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: user.Email, password: user.Password);
        print(credential.user);
        Navigator.of(context).pushNamed("/category");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                formKey.currentState?.reset();
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
            key: formKey,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field is required";
                      } else if (value.length < 3) {
                        return "Must be atleast 3 letters";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        user.UserName = value!;
                      });
                    },
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.black)),
                        icon: Icon(Icons.edit),
                        label: Text("User Name")),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field is required";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        user.Email = value!;
                      });
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.black)),
                        icon: Icon(Icons.alternate_email),
                        label: Text("Email")),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextFormField(
                    onSaved: (value) {
                      setState(() {
                        user.Password = value!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field is required";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.black)),
                        icon: Icon(
                          Icons.phone,
                        ),
                        label: Text("Phone Number")),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextFormField(
                    onSaved: (value) {
                      setState(() {
                        user.Password = value!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field is required";
                      }
                      return null;
                    },
                    obscureText: isVisiable,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.black)),
                        icon: Icon(
                          Icons.remove_red_eye_outlined,
                        ),
                        label: Text("Password")),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: OutlinedButton(
                    child: Text("Sign Up"),
                    onPressed: SaveForm,
                  ),
                )
              ],
            )),
      ),
    );
  }
}
