import 'package:flutter/material.dart';
import 'package:prueba_de_proyecto/services/services.dart';
import 'package:prueba_de_proyecto/ui/input_decoration.dart';
import 'package:prueba_de_proyecto/widgets/widgets.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
            child: SingleChildScrollView(
          //me permite hacer un scroll si los hijos sobrepasan el espacio disponible en el dispositivo
          // ignore: prefer_const_literals_to_create_immutables
          child: Column(
            children: [
              const SizedBox(
                height: 250,
              ),
              CardContainer(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        'Login',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      const SizedBox(height: 30),
                      ChangeNotifierProvider(
                        create: (_) => LoginFormProvider(),
                        child: _LoginForm(),
                      ),
                    ],
                  )
                ),

                const SizedBox(
                  height: 20,
                ),
              
              /*Icono Sitrack */
                const FadeInImage(placeholder: AssetImage('assets/jar-loading.gif'), image: AssetImage('assets/logo.jpg')),
                //const AssetImage('SitrackLOGO.jpg');
                const SizedBox(
                  height: 50,
                ),
            ]
          ),
        )
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {


  @override
  State<_LoginForm> createState() => _LoginFormState();
}
/*Formulario de Login */
class _LoginFormState extends State<_LoginForm> {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      child: Form(
          key: loginForm.formKey,
          autovalidateMode: AutovalidateMode
              .onUserInteraction, //permite validar lo que entre en el email
          child: Column(
            children: <Widget>[
              TextFormField(
                  //!Email
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecorations.authInputDecoration(
                      hintText: 'email@sitrack.com',
                      labelText: 'Correo Electronico',
                      prefixIcon: Icons.alternate_email_rounded),
                  onChanged: (value) => loginForm.email = value,    
                  //!Permite hacer la validacion con la expresion regular descrita
                  validator: (value) {
                    String pattern =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regExp = RegExp(pattern);
                    return regExp.hasMatch(value ?? '')
                        ? null
                        : 'Debe ingresar un correo electronico'; //toma la expresion regular y fijate si coincide con lo que ha escrito
                  }),
              const SizedBox(height: 30),
              TextFormField(
                  //!Contraseña
                  autocorrect: false,
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecorations.authInputDecoration(
                      hintText: '******',
                      labelText: 'Contraseña',
                      prefixIcon: Icons.lock_outlined
                    ),
                  onChanged: (value) => loginForm.password = value,    
                  //!Permite hacer la validacion con la expresion regular descrita
                  validator: (value) {
                    return (value != null && value.length >= 6)
                        ? null
                        : 'La contraseña debe contener 6 caracteres';
                  }
                ),
              const SizedBox(
                height: 30,
              ),
              MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                  
                  disabledColor: Colors.grey,
                  
                  elevation: 0,
                  
                  color: Colors.deepPurple,

                  onPressed: loginForm.isLoadding ? null : () async {

                    FocusScope.of(context).unfocus();//quita el teclado cuando presiono el boton. 
                    
                    final authService = Provider.of<AuthService>(context, listen: false);

                    if (!loginForm.isValidForm()) return;

                    loginForm.conexionFail= false;
                    loginForm.isLoadding = true;

                    //Valiar si es correcto el login. 
                    final bool? status = await authService.loginUser(loginForm.email, loginForm.password);
                    if (status==true) {
                      loginForm.isLoadding = false;
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacementNamed(context, 'home'); //Si el formulario es correcto ir al home.   
                    }else{
                      loginForm.conexionFail=true;
                      loginForm.isLoadding = false;
                      _showMyDialog();
                    }
                    
                  },
                  
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 15),
                      child: Text(
                        loginForm.isLoadding? 'Espere...':'Ingresar',
                        style: const TextStyle(color: Colors.white)
                      )
                    )
                ),
            ], 
          )
        ),
    );
  }
  /*Pop up en caso de que no se encuentre el usuario, es necesario un Statefull Widget para usarlo*/
  Future<void> _showMyDialog() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Email y/o contraseña incorrecto',style: TextStyle(color: Colors.deepPurple)),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Verifique si ha introducido correctamente su Email o contraseña'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK',style: TextStyle(color: Colors.deepPurple),),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
        
      );
    },
  );
}
}

