import 'package:farmx/CommonWidgets/ExceptionAlertDialogue.dart';
import 'package:farmx/Screens/SignIn/EmailSignInBloc.dart';
import 'package:farmx/Screens/SignIn/Models/EmailSignInModel.dart';
import 'package:farmx/Services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailSignInFormBlocBased extends StatefulWidget {
  EmailSignInFormBlocBased({required this.bloc});
  final EmailSignInBloc bloc;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Provider<EmailSignInBloc>(
      create: (_) => EmailSignInBloc(auth: auth),
      child: Consumer<EmailSignInBloc>(
        builder: (_, bloc, __) => EmailSignInFormBlocBased(bloc: bloc),
      ),
      dispose: (_, bloc) => bloc.dispose(),
    );
  }

  @override
  _EmailSignInFormBlocBasedState createState() =>
      _EmailSignInFormBlocBasedState();
}

class _EmailSignInFormBlocBasedState extends State<EmailSignInFormBlocBased> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _passwordConfirmFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();

    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _passwordConfirmFocusNode.dispose();
    super.dispose();
  }

  void _submit(EmailSignInModel model) async {
    try {
      await widget.bloc.submit();
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (error) {
      showExceptionAlertDialog(context,
          title: model.formType == EmailSignInFormType.signIn
              ? "Sing in Failed"
              : "Account creation Failed",
          exception: error);
    }
  }

  void _emailEditingComplete(EmailSignInModel model) {
    final newFocus = model.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _passwordEditingComplete() {
    FocusScope.of(context).requestFocus(_passwordConfirmFocusNode);
  }

  void _toggleFormType() {
    widget.bloc.toggleFormType();

    FocusScope.of(context).requestFocus(_emailFocusNode);
    _emailController.clear();
    _passwordController.clear();
    _passwordConfirmController.clear();
  }

  List<Widget> _buildChildren(EmailSignInModel model) {
    return [
      _buildEmailTextField(model),
      SizedBox(
        height: 8.0,
      ),
      _buildPasswordTextField(model),
      SizedBox(
        height: 8.0,
      ),
      model.formType == EmailSignInFormType.register
          ? Column(
              children: <Widget>[
                _buildPasswordConfirmTextField(model),
                SizedBox(
                  height: 8.0,
                ),
              ],
            )
          : SizedBox(
              height: 1.0,
            ),
      ElevatedButton(
        onPressed: model.canSubmit ? () => _submit(model) : null,
        child: Text(
          model.primaryButtonText,
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),
      SizedBox(
        height: 8.0,
      ),
      TextButton(
        onPressed: !model.isLoading ? _toggleFormType : null,
        child: Text(model.secondaryButtonText),
      ),
    ];
  }

  TextField _buildPasswordConfirmTextField(EmailSignInModel model) {
    return TextField(
      controller: _passwordConfirmController,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Confirm Password",
        enabled: model.isLoading == false,
        errorText: model.passwordConfirmErrorText,
      ),
      textInputAction: TextInputAction.done,
      focusNode: _passwordConfirmFocusNode,
      onEditingComplete: () => _submit(model),
      onChanged: (confirmPassword) =>
          widget.bloc.updateConfirmPassword(confirmPassword),
    );
  }

  TextField _buildPasswordTextField(EmailSignInModel model) {
    return TextField(
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        enabled: model.isLoading == false,
        errorText: model.passwordErrorText,
      ),
      textInputAction: model.formType == EmailSignInFormType.signIn
          ? TextInputAction.done
          : TextInputAction.next,
      focusNode: _passwordFocusNode,
      onEditingComplete: model.formType == EmailSignInFormType.signIn
          ? () => _submit(model)
          : _passwordEditingComplete,
      onChanged: (password) => widget.bloc.updatePassword(password),
    );
  }

  TextField _buildEmailTextField(EmailSignInModel model) {
    return TextField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "test@email.com",
        enabled: model.isLoading == false,
        errorText: model.emailErrorText,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      focusNode: _emailFocusNode,
      onEditingComplete: () => _emailEditingComplete(model),
      onChanged: (email) => widget.bloc.updateEmail(email),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EmailSignInModel>(
        stream: widget.bloc.modelStream,
        initialData: EmailSignInModel(),
        builder: (context, snapshot) {
          final EmailSignInModel? model = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: _buildChildren(model!),
            ),
          );
        });
  }
}
