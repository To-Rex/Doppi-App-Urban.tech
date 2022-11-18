import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _adressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  register() async {
    if (_passwordController.text == _confirmPasswordController.text
        &&_passwordController.text.length>6
        &&_nameController.text.isNotEmpty
        &&_adressController.text.isNotEmpty
        &&_phoneController.text.isNotEmpty
        &&_emailController.text.isNotEmpty) {
      final response = await http.post(
        Uri.parse("https://doppi-backend-production.up.railway.app/api/auth/sign-up-boss"),
        body: {
          'name': _nameController.text,
          'adress': _adressController.text,
          'phone': _phoneController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
          'confirmPassword': _confirmPasswordController.text,
        },
      );
      if (response.statusCode == 200) {
        print("success");
      } else {
        print("error");
      }
    }else{
      print("error");
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _adressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.055,
            ),
            Stack(
              children: <Widget>[
                SvgPicture.asset(
                  'assets/svgs/doppi_logo.svg',
                  height: 200,
                  width: 200,
                ),
                //text center
                const Positioned(
                  top: 150,
                  left: 58,
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.055,
              child: TextField(
                textInputAction: TextInputAction.next,
                obscureText: false,
                controller: _nameController,
                toolbarOptions: const ToolbarOptions(
                  cut: false,
                  copy: false,
                  selectAll: false,
                  paste: false,
                ),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  labelText: 'Dinner name',
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.055,
              child: TextField(
                textInputAction: TextInputAction.next,
                obscureText: false,
                controller: _adressController,
                toolbarOptions: const ToolbarOptions(
                  cut: false,
                  copy: false,
                  selectAll: false,
                  paste: false,
                ),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  labelText: 'Address',
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.055,
              child: TextField(
                textInputAction: TextInputAction.next,
                obscureText: false,
                controller: _phoneController,
                toolbarOptions: const ToolbarOptions(
                  cut: false,
                  copy: false,
                  selectAll: false,
                  paste: false,
                ),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  labelText: 'Phone number',
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.055,
              child: TextField(
                textInputAction: TextInputAction.next,
                obscureText: false,
                controller: _emailController,
                toolbarOptions: const ToolbarOptions(
                  cut: false,
                  copy: false,
                  selectAll: false,
                  paste: false,
                ),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  labelText: 'Email',
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.055,
              child: TextField(
                textInputAction: TextInputAction.next,
                obscureText: false,
                controller: _passwordController,
                toolbarOptions: const ToolbarOptions(
                  cut: false,
                  copy: false,
                  selectAll: false,
                  paste: false,
                ),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  labelText: 'Password',
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.055,
              child: TextField(
                textInputAction: TextInputAction.next,
                obscureText: false,
                controller: _confirmPasswordController,
                toolbarOptions: const ToolbarOptions(
                  cut: false,
                  copy: false,
                  selectAll: false,
                  paste: false,
                ),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  labelText: 'Confirm password',
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.055,
              child: ElevatedButton(
                onPressed: () {
                  if (_passwordController.text ==
                      _confirmPasswordController.text) {
                    register();
                  } else {
                    print('passwords do not match');
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Register'),
              ),
            ),
            const Expanded(child: Text('')),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Already have an account?'),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    ' Sign In',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}
