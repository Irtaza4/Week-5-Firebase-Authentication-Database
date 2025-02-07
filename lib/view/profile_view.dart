import 'package:flutter/material.dart';
import 'package:internship_task_firebase/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: authViewModel.userModel == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                child: Icon(Icons.person,size: 60,))),
            SizedBox(height: 30,),
            Center(child: Text("Name: ${authViewModel.userModel!.name}", style: TextStyle(fontSize: 18))),
            SizedBox(height: 30),
            Center(child: Text("Email: ${authViewModel.userModel!.email}", style: TextStyle(fontSize: 18))),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await authViewModel.logout();
                  Navigator.pop(context); //  Navigate back to login
                },
                child: Text("Logout"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
