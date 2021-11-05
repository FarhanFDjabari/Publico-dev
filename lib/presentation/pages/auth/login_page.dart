import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:publico/presentation/pages/auth/forget_password_page.dart';
import 'package:publico/presentation/widgets/primary_button.dart';
import 'package:publico/styles/colors.dart';
import 'package:publico/styles/text_styles.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/svg/Publico.svg',
                  height: 50,
                ),
                const SizedBox(height: 20),
                Text(
                  'Masuk Untuk Admin Aplikasi',
                  style: kTextTheme.subtitle1!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: kRichBlack,
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Alamat Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: kTextTheme.bodyText2!.copyWith(
                    color: kRichBlack,
                  ),
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Format email tidak valid';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    hintText: 'Kata Sandi',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                      icon: Icon(_isObscured
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  ),
                  style: kTextTheme.bodyText2!.copyWith(
                    color: kRichBlack,
                  ),
                  obscureText: _isObscured,
                  autofocus: false,
                  autocorrect: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Kata sandi tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                PrimaryButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                  borderRadius: 10,
                  primaryColor: kMikadoOrange,
                  child: SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: Center(
                      child: Text(
                        'Masuk Admin',
                        style: kTextTheme.button!.copyWith(
                          color: kRichWhite,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ForgetPasswordPage(),
                        ));
                  },
                  child: Text('Lupa Kata Sandi Anda?',
                      style: kTextTheme.bodyText2!.copyWith(
                        color: kGrey,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
