import 'package:chat_pc/src/providers/auth_provider.dart';
import 'package:chat_pc/src/services/search_delegate.dart';
import 'package:chat_pc/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AddUserPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final appTheme = Provider.of<ThemeChanger>(context);
    
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: appTheme.darkTheme 
          ? Colors.white
          : Colors.black54, //change your color here
        ),
        title: Text(
          'Contacts', 
          style: TextStyle(
            color:appTheme.darkTheme 
            ? Colors.white
            : Colors.black54
          ),
        ),
        elevation: 1.0,
        backgroundColor: appTheme.darkTheme
          ? appTheme.currentTheme.primaryColor
          : Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search), 
            onPressed: ()
            {
              showSearch(
                context: context, 
                delegate: DataSearch(),
                //query:'Hola',
              );
            }
          )
        ],
      ),
      body: _BodyUsers()
   );
  }
}

class _BodyUsers extends StatelessWidget {
  const _BodyUsers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final appTheme = Provider.of<ThemeChanger>(context);

    return Container(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.person_add_outlined, size: 25.0,),
              title: Text('Inivite Friends', style: TextStyle(fontWeight: FontWeight.w600),),
              onTap: (){
                showSearch(
                  context: context, 
                  delegate: DataSearch(),
                  //query:'Hola',
                );
              },
            ),
            SizedBox(height: 5.0,),
            Container(
              padding: EdgeInsets.only(left: 15.0),
              alignment: Alignment.centerLeft,
              color: appTheme.darkTheme
              ? Colors.blueGrey[800]
              : Colors.grey[200],
              height: 28.0,
              width: double.infinity,
              child: Text('Solicitudes Pendientes', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.grey[500]),),
            ),
            SizedBox(height: 5.0,),
            //TODO Solicitudes realizadas pendientes de aprobación
            Container(),
            Container(
              padding: EdgeInsets.only(left: 15.0),
              alignment: Alignment.centerLeft,
              color: appTheme.darkTheme
              ? Colors.blueGrey[800]
              : Colors.grey[200],
              height: 28.0,
              width: double.infinity,
              child: Text('Solicitudes por aprobación', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.grey[500]),),
            ),
            SizedBox(height: 5.0,),
            //TODO Solicitudes pendientes por aprobación de la persona logeada.
            Container(),
          ],
        )
      ),
    );
  }
}