import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:m2m_coin/components/text_field_container.dart';
import 'package:m2m_coin/services/AuthService.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flushbar/flushbar.dart';

import '../../constants.dart';

class FormLoginBuilder extends StatelessWidget {
  FormLoginBuilder({Key key}) : super(key: key);

  //ตัวแปล
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final FocusNode passwordFocusNode = FocusNode();
  AuthService authService = AuthService();
  ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    pr.style(message: 'Please wait...');

    return FormBuilder(
      key: _fbKey,
      initialValue: {
        'username': 'demo',
        'password': 'demo',
      },
      //autovalidateMode: AutovalidateMode.always,
      child: Column(
        children: <Widget>[
          TextFieldContainer(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: FormBuilderTextField(
                attribute: "username",
                maxLines: 1,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  hintText: "User Name",
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                  ),
                  border: InputBorder.none,
                  errorStyle: TextStyle(color: Colors.white),
                ),
                validators: [
                  FormBuilderValidators.required(
                      errorText: 'Please enter user name.'),
                ],
                onFieldSubmitted: (String value) {
                  FocusScope.of(context).requestFocus(passwordFocusNode);
                },
              ),
            ),
          ),
          TextFieldContainer(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: FormBuilderTextField(
                focusNode: passwordFocusNode,
                attribute: "password",
                obscureText: true,
                maxLines: 1,
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  hintText: "Password",
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                  ),
                  border: InputBorder.none,
                  errorStyle: TextStyle(color: Colors.white),
                ),
                validators: [
                  FormBuilderValidators.required(
                      errorText: 'please enter password.'),
                  FormBuilderValidators.minLength(3,
                      errorText:
                          'please enter a password of at least 3 characters.'),
                ],
              ),
            ),
          ),
          Container(
            width: size.width * 0.8,
            margin: EdgeInsets.symmetric(vertical: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(29),
              child: FlatButton(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                color: kPrimaryColor,
                onPressed: () {
                  if (_fbKey.currentState.saveAndValidate()) {
                    print(">>>>>>>>>>>>>>> Click Login");
                    pr.show();

                    authService.login(_fbKey.currentState.value).then((result) {
                      pr.hide();

                      if (result == true) {
                        print('result==> $result');
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/', (Route<dynamic> route) => false);
                      } else {
                        print('result==> $result');

                        Flushbar(
                          title: result['status'],
                          message: result['message'],
                          icon: Icon(
                            Icons.info_outline,
                            size: 28.0,
                            color: result['color'],
                          ),
                          duration: Duration(seconds: 3),
                          leftBarIndicatorColor: result['color'],
                        )..show(context);
                      }
                    });
                  }
                },
                child: Text(
                  'LOGIN',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
