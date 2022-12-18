import 'dart:convert';
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:pet_shop_app/login/Registro.dart';
import 'package:pet_shop_app/pages/HomePage.dart';

import 'Login.dart';

class Registro extends StatelessWidget {
  const Registro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        expansionTileTheme: const ExpansionTileThemeData(
          textColor:  Color(0xFF00916E),
          iconColor: Color(0xFF00916E),
        ),
        primaryColor: const Color(0xAE6529D7),
        /*canvasColor: const Color(0xFFFDF5EC),*/
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xAE6529D7),
          centerTitle: false,
          foregroundColor: Colors.white,
          actionsIconTheme: IconThemeData(color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith(
                    (states) => const Color(0xAE6529D7)),
          ),
        ),

      ),
      home: const MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  //const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var emailController = TextEditingController();
  var passController = TextEditingController();

  bool _isHidden = true;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text("REGISTRATE EN PETSHOP",
            style: TextStyle(fontFamily: 'Coolvetica', fontSize: 30)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: SizedBox(
                    width: 400,
                    height: 300,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('assets/images/img.jpg')),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            /*SizedBox( // <-- SEE HERE
              width: 700,
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nombre de usuario',
                    hintText: 'Ponga un nombre de usuario',
                    prefixIcon: Icon(Icons.person)),
              ),
            ),
            const SizedBox(
              height: 30,
            ),*/
            SizedBox( // <-- SEE HERE
              width: 700,
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Use un email valido',
                    prefixIcon: Icon(Icons.email)),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox( // <-- SEE HERE
              width: 700,
              child: TextFormField(
                controller: passController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Use una contraseña segura',
                  prefixIcon: const Icon(Icons.lock),
                  // suffixIcon: Icon(Icons.visibility_off)),
                  suffixIcon: IconButton(
                      onPressed: _toggleVisibility,
                      icon: _isHidden
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility)),
                ),
                obscureText: _isHidden,
              ),
            ),
            /*Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Use un email valido',
                    prefixIcon: Icon(Icons.email)),
              ),
            ),*/
            /*Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 10),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child:TextFormField(
                controller: passController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Use una contraseña segura',
                  prefixIcon: const Icon(Icons.lock),
                  // suffixIcon: Icon(Icons.visibility_off)),
                  suffixIcon: IconButton(
                      onPressed: _toggleVisibility,
                      icon: _isHidden
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility)),
                ),
                obscureText: _isHidden,
              ),
            ),*/
            const SizedBox(
              height: 10,
            ),
            /*InkWell(
              child: const Text('¿Has olvidado la contraseña?',style: TextStyle(fontFamily:'Coolvetica',fontSize: 18,color: Colors.deepOrange)),
              onTap: () {
                */ /*Navigator.push(
                    context, MaterialPageRoute(
                    builder: (_) => const PasswordOlvidada()));*/ /*
              },
            ),*/
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.deepPurpleAccent,
                  borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () async {
                  //_recordarCorreo();
                  Registrar();
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const Login()));
                },
                child: const Text(
                    'REGISTRARSE',
                    style: TextStyle(fontFamily: 'Coolvetica',
                        fontSize: 18,
                        color: Colors.white)),
              ),
            ),
            const SizedBox(
              height: 130,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> Registrar() async{
    if(kIsWeb){
      if(emailController.text.isNotEmpty || passController.text.isNotEmpty){
        var response = await http.post(Uri.parse("http://192.168.29.2/petshop/actions/Crear_Usuario.php"),
            body: ({
              'correo': emailController.text.toString(),
              'contrasena': passController.text.toString(),
              'rol': 2.toString(),
              'rol_usuario': 0.toString(),
            }));
        Map<String, dynamic> datos = jsonDecode(response.body);
        if (kDebugMode) {
          print(datos);
        }
      }else{
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Campos vacios")));
      }
    }else{
      if(emailController.text.isNotEmpty || passController.text.isNotEmpty){
        var response = await http.post(Uri.parse("http://192.168.29.2/192.168.29.2/petshop/actions/Crear_Usuario.php"),
            body: ({
              'correo': emailController.text.toString(),
              'contrasena': passController.text.toString(),
              'rol': 2,
              'rol_usuario': 0,
            }));
        Map<String, dynamic> datos = jsonDecode(response.body);
        if (kDebugMode) {
          print(datos);
        }
      }else{
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Campos vacios")));
      }
    }
  }
}

