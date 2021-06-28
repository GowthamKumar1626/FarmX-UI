import 'package:farmx/CommonWidgets/ExceptionAlertDialogue.dart';
import 'package:farmx/Screens/SignIn/Models/PhoneSignInModel.dart';
import 'package:farmx/Screens/SignIn/PhoneSignInBloc.dart';
import 'package:farmx/Screens/SignIn/validators.dart';
import 'package:farmx/Services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhoneSignInFormBloc extends StatefulWidget
    with EmailAndPasswordValidators {
  PhoneSignInFormBloc({required this.bloc});
  final PhoneSignInBloc bloc;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Provider<PhoneSignInBloc>(
      create: (_) => PhoneSignInBloc(auth: auth, context: context),
      child: Consumer<PhoneSignInBloc>(
        builder: (_, bloc, __) => PhoneSignInFormBloc(bloc: bloc),
      ),
      dispose: (_, bloc) => bloc.dispose(),
    );
  }

  @override
  _PhoneSignInFormBlocState createState() => _PhoneSignInFormBlocState();
}

class _PhoneSignInFormBlocState extends State<PhoneSignInFormBloc> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final FocusNode _phoneNumberFocusNode = FocusNode();

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }

  void _submit() async {
    try {
      await widget.bloc.submit();
      FocusScope.of(context).requestFocus(_phoneNumberFocusNode);
    } on FirebaseAuthException catch (error) {
      showExceptionAlertDialog(context,
          title: "Sign in Failed", exception: error);
    }
  }

  List<Widget> _buildChildren(PhoneSignInModel model) {
    final primaryText = "Confirm";

    return [
      _buildPhoneNumberField(model),
      SizedBox(
        height: 15.0,
      ),
      _buildHeader(primaryText, model),
    ];
  }

  TextField _buildPhoneNumberField(PhoneSignInModel model) {
    return TextField(
      controller: _phoneNumberController,
      cursorHeight: 22.0,
      decoration: InputDecoration(
          labelText: "Phone number",
          enabled: model.isLoading == false,
          errorText: model.phoneNumberErrorText),
      autocorrect: false,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      onChanged: (phoneNumber) => widget.bloc.updatePhoneNumber(phoneNumber),
      focusNode: _phoneNumberFocusNode,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PhoneSignInModel>(
        stream: widget.bloc.modelStream,
        initialData: PhoneSignInModel(),
        builder: (context, snapshot) {
          final PhoneSignInModel? model = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: _buildChildren(model!),
                ),
              ),
            ),
          );
        });
  }

  Widget _buildHeader(String primaryText, PhoneSignInModel model) {
    if (model.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return ElevatedButton(
      // onPressed: !_submitted ? _submit : null,
      onPressed:
          widget.phoneNumberValidator.isValidPhoneNumber(model.phoneNumber)
              ? model.isLoading
                  ? null
                  : _submit
              : null,
      child: Text(
        "$primaryText",
        style: TextStyle(
          fontSize: 20.0,
        ),
      ),
    );
  }
}
