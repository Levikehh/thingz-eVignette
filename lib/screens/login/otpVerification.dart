import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:thingz_evignette/constants.dart';

class OTPVerification extends StatefulWidget {
  final String phoneNumber;

  const OTPVerification({
    Key key,
    this.phoneNumber,
  }) : super(key: key);
  @override
  _OTPVerificationState createState() => _OTPVerificationState(phoneNumber);
}

class _OTPVerificationState extends State<OTPVerification> {
  _OTPVerificationState(this.phoneNumber);

  final formKey = GlobalKey<FormState>();
  final String phoneNumber;

  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType> errorController;

  String currentText = "";
  bool hasError = false;

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }

  snackBar(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            SizedBox(height: defaultPadding * 3),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding,
                vertical: 8,
              ),
              child: Text(
                "Enter the 4 digit code we sent to you",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.background,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: defaultPadding),
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: defaultPadding,
                ),
                child: PinCodeTextField(
                  appContext: context,
                  length: 4,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  cursorColor: Theme.of(context).colorScheme.background,
                  animationDuration: Duration(milliseconds: 300),
                  enableActiveFill: true,
                  errorAnimationController: errorController,
                  controller: textEditingController,
                  keyboardType: TextInputType.number,
                  pastedTextStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 60,
                    fieldWidth: 55,
                    activeFillColor: hasError
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                    inactiveFillColor: Colors.white,
                    selectedFillColor: Colors.white,
                    activeColor: hasError
                        ? Theme.of(context).colorScheme.error
                        : Theme.of(context).primaryColor,
                    selectedColor:
                        Theme.of(context).primaryColor.withOpacity(.4),
                    inactiveColor: Theme.of(context)
                        .colorScheme
                        .background
                        .withOpacity(.4),
                  ),
                  boxShadows: [
                    BoxShadow(
                      offset: Offset(0, 1),
                      color: Theme.of(context)
                          .colorScheme
                          .background
                          .withOpacity(.2),
                      blurRadius: 10,
                    )
                  ],
                  onCompleted: (v) {
                    validate();
                  },
                  onChanged: (value) {
                    print(value);
                    setState(() {
                      currentText = value;
                    });
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding * .5,
              ),
              child: Text(
                hasError ? "Bad code" : "",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Didn't receive the code? ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.background,
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  onPressed: () => snackBar("OTP resend!!"),
                  child: Text(
                    "Resend",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
            Spacer(),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 30,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).primaryColor.withOpacity(.2),
                    offset: Offset(1, -2),
                    blurRadius: 5,
                  ),
                  BoxShadow(
                    color: Theme.of(context).primaryColor.withOpacity(.2),
                    offset: Offset(-1, 2),
                    blurRadius: 5,
                  )
                ],
              ),
              child: ButtonTheme(
                height: 50,
                child: TextButton(
                  onPressed: () => validate(),
                  child: Center(
                    child: Text(
                      "Verify",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: defaultPadding),
          ],
        ),
      ),
    );
  }

  validate() {
    formKey.currentState.validate();
    // conditions for validating
    if (currentText.length != 4 || currentText != "1234") {
      errorController.add(
        ErrorAnimationType.shake,
      ); // Triggering error shake animation
      setState(() {
        hasError = true;
      });
    } else {
      setState(
        () {
          hasError = false;
          snackBar("OTP Verified!!");
        },
      );
    }
  }
}
