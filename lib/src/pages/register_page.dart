import 'package:chat_pc/src/providers/auth_provider.dart';
import 'package:chat_pc/src/widgets/show_alert_widget.dart';
import 'package:flutter/material.dart';
import 'package:chat_pc/src/widgets/button_login.dart';
import 'package:chat_pc/src/widgets/logo_login_widget.dart';
import 'package:chat_pc/src/widgets/labels_login_widget.dart';
import 'package:chat_pc/src/widgets/custom_input.dart';
import 'package:provider/provider.dart';



class RegisterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        //minimum: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LogoLoginWidget(
                  title: 'Register',
                ),
                _Form(),
                LabelsLoginWidget(
                  title: '¿Ya tienes cuenta?',
                  titleButton: 'Ingresa ahora!',
                  route: 'login',
                ), 
                Text('Términos y condiciones de uso', style: TextStyle(fontWeight: FontWeight.w200),),
              ],
            ),
          ),
        ),
      )
     );
  }
}

class _Form extends StatefulWidget {
  //const _Form({ Key? key }) : super(key: key);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {

  final nameController     = TextEditingController();
  final emailController    = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context);

    return Container(
      margin: EdgeInsets.only(top: 40.0),
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.perm_identity_rounded,
            placeHolder: 'Nombre',
            keyBoardType: TextInputType.text,
            textController: nameController,
          ),
          CustomInput(
            icon: Icons.mail_outline,
            placeHolder: 'Email',
            keyBoardType: TextInputType.emailAddress,
            textController: emailController,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeHolder: 'Password',
            textController: passwordController,
            isPassword: true,
          ),
          ButtonLoginWidget(
            texto: 'Registrar',
            color: Colors.blue,
            widthButton: double.infinity,
            heightButton: 55.0,
            onPressed: authProvider.auth ? null : () async {
              //print(emailController.text);
              //print(passwordController.text);
              FocusScope.of(context).unfocus();
              final loginOk = await authProvider.register(emailController.text.trim(), passwordController.text.trim(),nameController.text.trim());
              if(loginOk.ok){
                //TODO conectar a socket server
                Navigator.pushReplacementNamed(context, 'users');
              }else{
                showAlert(context, 'Error en el Registro', loginOk.msg);
              }
            },
          ),
        ],
      ),
    );
  }
}

