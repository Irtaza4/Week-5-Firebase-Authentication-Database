import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:internship_task_firebase/view/SignUp_view.dart';
import 'package:internship_task_firebase/view/profile_view.dart';
import 'package:internship_task_firebase/view_model/auth_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false; // ✅ Loading State

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Center(child: Icon(Icons.camera, size: 100)),
            ),
            SizedBox(height: 20),
            Text(
              "Welcome Back, You've been missed!",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter the email";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade600)),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.grey.shade600),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: TextFormField(
                      controller: pwController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter the password";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade600)),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.grey.shade600),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true; //  Start Loading
                        });

                        bool success = await Provider.of<AuthViewModel>(
                            context,
                            listen: false)
                            .login(
                            emailController.text.trim(),
                            pwController.text.trim());

                        setState(() {
                          isLoading = false; // Stop Loading
                        });

                        if (success) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileView()));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                Text('Login failed. Try again.')),
                          );
                        }
                      }
                    },
                    child: Text('Login',
                        style: TextStyle(color: Colors.black)),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?",
                          style: TextStyle(color: Colors.grey.shade600)),
                      SizedBox(width: 10),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpView()));
                          },
                          child: Text('SignUp',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
