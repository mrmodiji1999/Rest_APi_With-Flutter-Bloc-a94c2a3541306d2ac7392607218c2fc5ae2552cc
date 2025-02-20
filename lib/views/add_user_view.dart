import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/constants/snack_bar.dart';
import 'package:project/logice/logice.dart';

class AddUserView extends StatefulWidget {
  const AddUserView({super.key});

  @override
  State<AddUserView> createState() => _AddUserViewState();
}

class _AddUserViewState extends State<AddUserView> {
  final TextEditingController _userNameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  @override
  void dispose() {
    _userNameCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add User"),
      ),
      body: _buildBody,
    );
  }

  Widget get _buildBody {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TextField(
            controller: _userNameCtrl,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "User Name"),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TextField(
            controller: _emailCtrl,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "User Email"),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        ElevatedButton(
            onPressed: () {
              if (_emailCtrl.text.isEmpty) {
                snackBar(context, "Please input your email");
              } else if (_userNameCtrl.text.isEmpty) {
                snackBar(context, "Please input your user name");
              } else {
                context.read<LogicalService>().add(AddUserEvent(
                    email: _emailCtrl.text, username: _userNameCtrl.text, context: context));
              }
            },
            child: BlocBuilder<LogicalService, LogicState>(
              builder: (context, state){
                if(state is AddUserLoading){
                  bool isLoading = state.isLoading;
                  return isLoading ? const CircularProgressIndicator(
                    color: Colors.white,
                  ) : const Text("Add User");
                }else{
                  return const Text("Add User");
                }
              }
            ),
          )
      ],
    );
  }
}
