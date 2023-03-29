import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;
import 'package:untitled56/Acceuil/first.dart';
import 'package:untitled56/Login/Login.dart';
import 'package:untitled56/Login/Registre.dart';
class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  GlobalKey<FormState> fo =GlobalKey<FormState>();
  TextEditingController emaill =TextEditingController();
  TextEditingController passwordd =TextEditingController();
  bool existe =false;
  void send()async{
    String url="http://192.168.1.25/registre.php";
    if(fo.currentState!.validate()){

  http.Response data =await http.post(Uri.parse(url),
      body:jsonEncode({
        "email":emaill.text,
        "password":passwordd.text,
      }));
  if(data.statusCode==200){
    print(jsonDecode(data.body));
    Navigator.push(context, MaterialPageRoute(builder:(context)=>first()));
  }else{
    print(data.statusCode);
    print("laafsa");
  }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFF0041c4),
      body:Form(
        key: fo,
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            Container(
              height: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                    child: IconButton(onPressed:(){
                      Navigator.push(context,MaterialPageRoute(builder:(context)=>Login()));
                    }, icon:Icon(Icons.arrow_back,color: Colors.white,)),
                  )
                , Padding(
                  padding: const EdgeInsets.only(left: 20.0,bottom: 20),
                  child: Text('Sign In',style:TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold,letterSpacing: 1),),
                ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 580,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft:  Radius.circular(40),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset('lib/assets/téléchargement (1).png'),
                    ),
                    SizedBox(height: 20,),
                    Text('Welcome Back',style:TextStyle(color:Color(0xFF032351),fontSize: 30,fontWeight: FontWeight.bold,letterSpacing: 1),),
                    SizedBox(height: 10,),
                    Text('Hello there in to be continue',style:TextStyle(color:Color(0xFFa2abb9),letterSpacing: 1),),
                    SizedBox(height: 15,),
                    Text('Email',style:TextStyle(color: Colors.blue,letterSpacing: 1),),
                    SizedBox(height: 15,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFFf6f7f9)
                      ),
                      child: TextFormField(
                        controller:emaill,
                        validator:(text){
                          if(text!.isEmpty){
                            return "Email field must not be empty ";
                          }
                          else if(!EmailValidator.validate(text)){
                            return "Please enter a valid email address";
                          }
                        },
                        decoration: InputDecoration(
                            isCollapsed: false,

                            prefixIcon:Icon(Icons.mail,),
                            hintText: "Entrer your email",
                            border: InputBorder.none
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Text('Password',style:TextStyle(color: Colors.blue,letterSpacing: 1),),
                    SizedBox(height: 15,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFFf6f7f9)
                      ),
                      child: TextFormField(
                        controller: passwordd,
                        validator:(text){
                          if(text!.isEmpty){
                            return "password field must not be empty ";
                          }
                          if(text!.length<4 && text!.length>0){
                            return "password must contain at least 4 characters ";
                          }
                        },
                        obscureText:true,
                        decoration: InputDecoration(
                          isCollapsed: false,
                          prefixIcon: Icon(Icons.lock_outline,),
                            hintText: "Entrer your password",
                            border: InputBorder.none
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Text('Forget Password?',style:TextStyle(color:Color(0xFF1651c8),letterSpacing: 1,fontWeight: FontWeight.bold),),
                    SizedBox(height: 30,),
                    Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Color(0xFF0041c4),
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 5,)
                          ,GestureDetector(
                      onTap:(){
                        send();
                      }
                    ,child: Text('Sign in ',style:TextStyle(color:Colors.white,fontWeight: FontWeight.bold)))
                        ],
                      ),
                    ),
                    Expanded(child: Container(
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account?',style:TextStyle(color:Color(0xFF1651c8)),),
                        SizedBox(width: 5,),
                        GestureDetector(
                        onTap:(){
                          Navigator.push(context,MaterialPageRoute(builder:(context)=>Registre()));
                        }
                        ,child: Text('Sign UP',style:TextStyle(color:Color(0xFF1651c8),fontWeight: FontWeight.bold),)),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
