import 'package:def_app/methods/show_snake_bar.dart';
import 'package:def_app/views/chat_view.dart';
import 'package:def_app/views/register_view.dart';
import 'package:def_app/widgets/custom_button.dart';
import 'package:def_app/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);
  static String loginId = 'LoginView';

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> formKey = GlobalKey();
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
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    height: 100,
                    width: 250,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/cat.jpg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                const Text(
                  'Chat App',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 28,
                        ),
                      ),
                    ],
                  ),
                ),
                Form(
                  key: formKey,
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
                  text: 'Login',
                  onpressed: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    if (formKey.currentState!.validate()) {
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: email, password: password);
                        Navigator.pushNamed(
                          context,
                          ChatView.chatId,
                          arguments: email,
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnakeBar(
                            context,
                            'No user found for that email.',
                          );
                        } else if (e.code == 'wrong-password') {
                          showSnakeBar(
                            context,
                            'Wrong password provided for that user.',
                          );
                        }
                      } catch (e) {
                        showSnakeBar(
                          context,
                          e.toString(),
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
                      const Text('don\'t have an account?'),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(
                            context, RegisterView.registerId),
                        child: const Text(
                          'Register',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
