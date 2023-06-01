import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:local_shop/models/user.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isVisiable = true;

  var formKey = GlobalKey<FormState>();
  var user = UserLogin(Password: "", Email: "");
  void SaveForm() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: user.Email, password: user.Password);
        formKey.currentState?.reset();

        Navigator.of(context).pushNamed("/category");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
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
        padding: const EdgeInsets.all(20.0),
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
                    child: Text("Sign in"),
                    onPressed: SaveForm,
                  ),
                )
              ],
            )),
      ),
    );
  }
}
