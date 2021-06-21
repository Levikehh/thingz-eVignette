import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:thingz_evignette/constants.dart';
import 'package:thingz_evignette/screens/login/otpVerification.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  CountryCode _countryCode = CountryCode.fromCountryCode("HU");
  String _phoneNumber = "";
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: defaultPadding * 3),
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: width,
              height: 60 + defaultPadding * 2,
              child: Center(
                child: Text(
                  "Enter your phone number",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              width: width * .8,
              height: 70,
              padding: EdgeInsets.all(defaultPadding * .2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
                border: Border.all(
                  color: Theme.of(context).primaryColor.withOpacity(.2),
                  width: 2,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CountryCodePicker(
                    onChanged: (code) => setState(() {
                      _countryCode = code;
                    }),
                    initialSelection: _countryCode.toString(),
                    showCountryOnly: true,
                    hideMainText: true,
                    favorite: [_countryCode.toString(), 'US'],
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          _countryCode.toString(),
                          style: TextStyle(fontSize: 16),
                        ),
                        Expanded(
                          child: TextField(
                            controller: phoneController,
                            onChanged: (phoneNumber) => setState(() {
                              _phoneNumber = phoneNumber;
                            }),
                            onSubmitted: (submitData) =>
                                Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => OTPVerification(
                                    phoneNumber:
                                        '${_countryCode.toString()}$_phoneNumber'),
                              ),
                            ),
                            keyboardType: TextInputType.phone,
                            maxLength: 15,
                            style: TextStyle(fontSize: 16),
                            decoration: new InputDecoration(
                              counterText: "",
                              contentPadding: EdgeInsets.only(left: 5),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            CustomButton(
              countryCode: _countryCode,
              phoneNumber: _phoneNumber,
              width: width,
            ),
            SizedBox(
              height: defaultPadding,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {},
                    child: Text("Create one here"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key key,
    @required CountryCode countryCode,
    @required String phoneNumber,
    @required this.width,
  })  : _countryCode = countryCode,
        _phoneNumber = phoneNumber,
        super(key: key);

  final CountryCode _countryCode;
  final String _phoneNumber;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => OTPVerification(
              phoneNumber: '${_countryCode.toString()}$_phoneNumber'),
        ),
      ),
      child: Container(
        width: width * .8,
        height: 70,
        padding: EdgeInsets.all(defaultPadding * .2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          color: Theme.of(context).primaryColor,
        ),
        child: Center(
          child: Text(
            "Continue",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class SignInOption extends StatelessWidget {
  const SignInOption({
    Key key,
    @required this.width,
    @required this.icon,
    @required this.providerName,
  }) : super(key: key);

  final double width;
  final Icon icon;
  final String providerName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var user =
            await FirebaseAuth.instance.signInWithPopup(GoogleAuthProvider());
        print(user.user.email);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: defaultPadding * .4),
        padding: EdgeInsets.symmetric(
            horizontal: defaultPadding, vertical: defaultPadding * .5),
        width: width * .8,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Colors.black.withOpacity(.3),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: icon,
            ),
            Align(
              alignment: Alignment.center,
              child: Text("Sign in with $providerName"),
            ),
          ],
        ),
      ),
    );
  }
}

/*

TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: "Password",
              ),
            ),
            TextButton(
              onPressed: () {
                context.read<AuthenticationService>().signIn(
                      email: emailController.text,
                      password: passwordController.text,
                    );
              },
              child: Text(
                "Sign in",
              ),
            ),
*/
