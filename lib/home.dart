import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_pro_movil/_cubit.dart';
import 'package:proyecto_pro_movil/_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<FormState> _signInKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final RegExp emailValid =
      RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 100, 67, 122),
        title: Text("TerapiaChat"),
      ),
        body: BlocProvider(
          create: (_) => StringCubit(),
          child: BlocBuilder<StringCubit, StringState>(
            builder: (context, state) {
              return Form(
                key: _signInKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/your_logo.png', // Asegúrate de tener el logo en la carpeta 'assets'
                      height: 200, // Ajusta la altura según sea necesario
                    ),
                    Text(
                      "Login",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: const EdgeInsets.all(15),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Enter an Email',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field is required.";
                          } else if (!emailValid.hasMatch(value)) {
                            return "Please enter a valid email";
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(15),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Write a Password',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field is required.";
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      width: 250,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 212, 50, 91),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextButton(
                        onPressed: () async {
                          if (_signInKey.currentState!.validate()) {
                            if (_emailController.text == 'correo@example.com' &&
                                _passwordController.text == 'contrasenia') {
                              // El usuario está autenticado con éxito
                              debugPrint("Email: ${_emailController.text}");

                              // Guardar la sesión de autenticación en SharedPreferences
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setBool('isAuthenticated', true);
                            await prefs.setString('username', _emailController.text);

                            // Obtener el valor del nombre de usuario
                            String? username = prefs.getString('username');

                            if (username != null) {
                              // Muestra el nombre de usuario en un SnackBar
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('¡Bienvenido, $username!'),
                                ),
                              );
                            } else {
                              // Manejar el caso en el que el nombre de usuario no se pudo obtener
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Error al obtener el nombre de usuario'),
                                ),
                              );
                            }

                              // Navegar a otra pantalla o realizar alguna acción de autenticación
                            }
                            else {
                              // Si la autenticación falla, muestra un mensaje de error
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Error de autenticación'),
                                ),
                              );
                            }
                          }
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
