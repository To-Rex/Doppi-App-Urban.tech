import 'package:doppi/sample_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../register_page.dart';
import 'package:http/http.dart' as http;

class LoginFragment extends StatefulWidget {
  const LoginFragment({super.key});

  @override
  _LoginFragmentState createState() => _LoginFragmentState();
}

class _LoginFragmentState extends State<LoginFragment> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  login() async {
    final response = await http.post(
      Uri.parse(
          "https://doppi-backend-production.up.railway.app/api/auth/sign-in"),
      body: {
        'email': _emailController.text,
        'password': _passwordController.text,
      },
    );
    if (response.statusCode == 200) {
      var jwttoken = response.body.split("token\":\"")[1].split("\"}")[0];
      //var jwt = JwtDecoder.decode(jwttoken);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', jwttoken);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const SamplePage();
      }));
    } else {
      print("error");
    }
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.values[1],
        children: <Widget>[
          const Expanded(child: Text('')),
          Stack(
            children: <Widget>[
              SvgPicture.asset(
                'assets/svgs/doppi_logo.svg',
                height: 150,
                width: 150,
              ),
              //text center
              const Positioned(
                top: 100,
                left: 38,
                child: Text(
                  'Sign In',
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
                labelText: 'Email *',
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.055,
            child: TextField(
              controller: _passwordController,
              textInputAction: TextInputAction.done,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
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
                labelText: 'Password *',
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.03,
              ),
              Checkbox(
                value: false,
                onChanged: (bool? value) {},
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              ),
              const Text('Remember me'),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: ElevatedButton(
              onPressed: () {
                login();
              },
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              child: const Text('Sign In'),
            ),
          ),
          //forgot password text and text style color blue
          const SizedBox(
            height: 10,
          ),
          //forgot password text and text style color blue and start with text 10%
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              const Text(
                'Forgot Password?',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
              //Don't have an account? Sign Up
              const Expanded(child: Text('')),
              const Text('Don\'t have an account?'),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.001,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPage()));
                },
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          //const Text("Or", style: TextStyle(fontSize: 20)),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  //facebook login
                },
                icon: const Icon(
                  Icons.facebook,
                  color: Colors.blue,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              IconButton(
                onPressed: () {
                },
                icon: SvgPicture.asset(
                  'assets/svgs/googles.svg',
                  height: 30,
                  width: 30,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              IconButton(
                onPressed: () {
                  //apple sign in
                },
                icon: const Icon(
                  Icons.apple,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const Expanded(child: Text(""))
        ],
      ),
    );
  }
}
