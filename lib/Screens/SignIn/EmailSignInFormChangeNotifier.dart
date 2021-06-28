import 'package:farmx/CommonWidgets/ExceptionAlertDialogue.dart';
import 'package:farmx/Screens/SignIn/Models/EmailSignInChangeModel.dart';
import 'package:farmx/Screens/SignIn/Models/EmailSignInModel.dart';
import 'package:farmx/Services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailSignInFormChangeNotifier extends StatefulWidget {
  EmailSignInFormChangeNotifier({required this.model});
  final EmailSignInChangeModel model;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    // final database = Provider.of<Database>(context, listen: false);
    return ChangeNotifierProvider<EmailSignInChangeModel>(
      create: (_) => EmailSignInChangeModel(auth: auth),
      child: Consumer<EmailSignInChangeModel>(
        builder: (_, model, __) => EmailSignInFormChangeNotifier(model: model),
      ),
    );
  }

  @override
  _EmailSignInFormChangeNotifierState createState() =>
      _EmailSignInFormChangeNotifierState();
}

class _EmailSignInFormChangeNotifierState
    extends State<EmailSignInFormChangeNotifier> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _passwordConfirmFocusNode = FocusNode();

  EmailSignInChangeModel get model => widget.model;

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

  void _submit() async {
    try {
      await model.submit();
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (error) {
      showExceptionAlertDialog(context,
          title: model.formType == EmailSignInFormType.signIn
              ? "Sing in Failed"
              : "Account creation Failed",
          exception: error);
    }
  }

  void _emailEditingComplete() {
    final newFocus = model.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _passwordEditingComplete() {
    FocusScope.of(context).requestFocus(_passwordConfirmFocusNode);
  }

  void _toggleFormType() {
    model.toggleFormType();

    FocusScope.of(context).requestFocus(_emailFocusNode);
    _emailController.clear();
    _passwordController.clear();
    _passwordConfirmController.clear();
  }

  List<Widget> _buildChildren() {
    return [
      _buildEmailTextField(),
      SizedBox(
        height: 8.0,
      ),
      _buildPasswordTextField(),
      SizedBox(
        height: 8.0,
      ),
      model.formType == EmailSignInFormType.register
          ? Column(
              children: <Widget>[
                _buildPasswordConfirmTextField(),
                SizedBox(
                  height: 8.0,
                ),
              ],
            )
          : SizedBox(
              height: 1.0,
            ),
      ElevatedButton(
        onPressed: model.canSubmit ? _submit : null,
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

  TextField _buildPasswordConfirmTextField() {
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
      onEditingComplete: _submit,
      onChanged: (confirmPassword) =>
          model.updateConfirmPassword(confirmPassword),
    );
  }

  TextField _buildPasswordTextField() {
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
          ? _submit
          : _passwordEditingComplete,
      onChanged: (password) => model.updatePassword(password),
    );
  }

  TextField _buildEmailTextField() {
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
      onEditingComplete: () => _emailEditingComplete(),
      onChanged: (email) => model.updateEmail(email),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),
    );
  }
}
