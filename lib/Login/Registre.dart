import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:date_format/date_format.dart';
import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:untitled56/Login/Sign_in.dart';

import '../Acceuil/first.dart';
class Registre extends StatefulWidget {
  const Registre({Key? key}) : super(key: key);

  @override
  State<Registre> createState() => _RegistreState();
}

class _RegistreState extends State<Registre> {
  TextEditingController name =TextEditingController();
  TextEditingController username =TextEditingController();
  TextEditingController password =TextEditingController();
  TextEditingController cin =TextEditingController();
  TextEditingController email =TextEditingController();
  TextEditingController date =TextEditingController();
  TextEditingController phone =TextEditingController();
  GlobalKey<FormState> fo = GlobalKey<FormState>();

  PostData()async{
    String url="";
    http.MultipartRequest response =await http.MultipartRequest('POST',Uri.parse(url));
    var imageField = await http.MultipartFile.fromPath('image', imag!.path);
    response.files.add(imageField);
    response.fields['name'] =name.text;
    response.fields['username'] =username.text;
    response.fields['password'] =password.text;
    response.fields['cin'] =cin.text;
    response.fields['date'] =date.text;
    response.fields['phone'] =phone.text;
    var data =await response.send();
    if(data.statusCode==200){
      print("sss");
    }


  }

  signin(){
    if(fo.currentState!.validate()){
      Navigator.push(context,MaterialPageRoute(builder:(context)=>first()));
    }
  }
  File? imag ;

  void PickImage() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img == null)return;
    else{
      setState(() {
        imag = File(img.path);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0041c4),
      body:SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: fo,
          child: Column(
            children: [
              Container(
                height: 100,
                width: double.infinity,
                child:Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                          radius: 50,
                          backgroundImage:imag==null?AssetImage('lib/assets/téléchargement.png'):AssetImage(imag!.path)
                      ),
                      Positioned(
                          left: 60,
                          bottom: 0
                          ,child:IconButton(onPressed:(){
                         PickImage();
                      },icon:Icon(Icons.camera_alt_outlined,size: 30,color: Colors.white,),))
                    ],
                  ),
                ),
              ),
              Container(
                height: 640,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft:Radius.circular(40),topRight:Radius.circular(40))
                ),
                padding: EdgeInsets.symmetric(horizontal: 40,vertical: 20),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name',style:TextStyle(color: Colors.blue,letterSpacing: 1),),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFFf6f7f9)
                      ),
                      child: TextFormField(
                        controller: name,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]+")),
                        ],
                        validator:(text){
                          if(text!.isEmpty){
                            return "name cannot be vide";
                          }
                        },
                        decoration: InputDecoration(
                          prefixIcon:Icon(Icons.person),
                            hintText: "Entrer your Name",
                            border: InputBorder.none
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text('UserName',style:TextStyle(color: Colors.blue,letterSpacing: 1),),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFFf6f7f9)
                      ),
                      child: TextFormField(
                        controller: username,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]+")),
                        ],
                        validator:(text){
                          if(text!.isEmpty){
                            return "username cannot be vide";
                          }
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                            hintText: "Entrer your Username",
                            border: InputBorder.none
                        ),
                      ),
                    ),
                    Text('Date',style:TextStyle(color: Colors.blue,letterSpacing: 1),),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFFf6f7f9)
                      ),
                      child: TextFormField(
                        controller: date,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          prefixIcon:IconButton(icon:Icon(Icons.date_range_sharp),onPressed:()async{
                          DateTime? dat=await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now());
                          if(dat!=null){
                            setState(() {
                              String formattedDate =
                              DateFormat('dd/MM/yyyy').format(dat);
                              date.text=formattedDate.toString();
                            });
                          }
                          },),
                            hintText: "Entrer your Date Of Birth",
                            border: InputBorder.none
                        ),
                      ),
                    ),
                    Text('Email',style:TextStyle(color: Colors.blue,letterSpacing: 1),),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFFf6f7f9)
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (text){
                          if(text!.isEmpty){
                            return " Email is not valid";
                          }
                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            hintText: "Entrer your Email",
                            border: InputBorder.none
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text('Password',style:TextStyle(color: Colors.blue,letterSpacing: 1),),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFFf6f7f9)
                      ),
                      child: TextFormField(
                        controller: password,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]+")),
                        ],
                        validator:(text){
                          if(text!.isEmpty){
                            return "password cannot be vide";
                          }
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            prefixIcon:Icon(Icons.lock_outline),
                            hintText: "Entrer your Password",
                            border: InputBorder.none
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text('Confirm Password',style:TextStyle(color: Colors.blue,letterSpacing: 1),),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFFf6f7f9)
                      ),
                      child: TextFormField(
                        controller: password,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]+")),
                        ],
                        validator:(text){
                          if(text!.isEmpty){
                            return "Password cannot be vide";
                          }else if(!EmailValidator.validate(text)){
                          return "Email cannot be vide";
                          }
                          },
                        decoration: InputDecoration(
                          prefixIcon:Icon(Icons.lock),
                            hintText: "Confirm your password",
                            border: InputBorder.none
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text('Phone',style:TextStyle(color: Colors.blue,letterSpacing: 1),),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFFf6f7f9)
                      ),
                      child: TextFormField(
                        controller: phone,
                        validator: (text){
                          if(text!.isEmpty || text.length<8){
                            return "Phone is not Valid";
                          }
                        },
                        maxLength: 8,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            prefixIcon:Icon(Icons.phone),
                            hintText: "Entrer your Phone Number",
                            border: InputBorder.none
                        ),

                      ),
                    ),

                    SizedBox(height: 20,),
                    GestureDetector(
                      onTap:(){
                        signin();
                      },
                      child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Color(0xFF0041c4),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Sign in ',style:TextStyle(color:Colors.white,fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account?',style:TextStyle(color:Color(0xFF628bdc)),),
                        SizedBox(width: 5,),
                        GestureDetector(
                          onTap:(){
                            Navigator.push(context,MaterialPageRoute(builder:(context)=>Signin()));
                          }
                            ,child: Text('Sign up',style:TextStyle(color:Colors.blue),)),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
