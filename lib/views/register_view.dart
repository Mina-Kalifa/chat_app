import 'package:def_app/methods/show_snake_bar.dart';
import 'package:def_app/widgets/custom_button.dart';
import 'package:def_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterView extends StatefulWidget {
  RegisterView({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey();
  static String registerId = 'RegisterView';

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    String email = '';
    String password = '';
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        height: 150,
                        width: 250,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/OIP.jpeg'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 28,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Form(
                      key: widget.formKey,
                      child: Column(
                        children: [
                          CustomTextFormField(
                            getData: (value) {
                              email = value;
                            },
                            label: 'Email',
                            hint: 'Enter Your Email',
                          ),
                          CustomTextFormField(
                            getData: (value) {
                              password = value;
                            },
                            label: 'Password',
                            hint: 'Enter your password',
                            isPassword: true,
                          ),
                        ],
                      ),
                    ),
                    CustomButton(
                      text: 'Register',
                      onpressed: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        if (widget.formKey.currentState!.validate()) {
                          try {
                            await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                              email: email,
                              password: password,
                            );
                            showSnakeBar(
                              context,
                              'Success.',
                            );
                            Navigator.pop(context);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              showSnakeBar(
                                context,
                                'The password provided is too weak.',
                              );
                            } else if (e.code == 'email-already-in-use') {
                              showSnakeBar(
                                context,
                                'The account already exists for that email.',
                              );
                            }
                          } catch (ex) {
                            showSnakeBar(
                              context,
                              ex.toString(),
                            );
                          } finally {
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        } else {
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('do you already have an account?'),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Text(
                              'Login',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
