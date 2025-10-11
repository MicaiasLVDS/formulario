import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(home: Formulario(), debugShowCheckedModeBanner: false));
}

class Formulario extends StatefulWidget {
  Formulario({Key? key}) : super(key: key);

  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  final _formkey = GlobalKey<FormState>();
  final controladoraNome = TextEditingController();
  final controladoraEmail = TextEditingController();
  final controladoraSenha = TextEditingController();
  final idade = TextEditingController();
  bool mostrarSenha = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Primeiro Formulario'))),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            key: _formkey,
            children: [
              SizedBox(height: 10),
              TextFormField(
                controller: controladoraNome,
                decoration: InputDecoration(
                  labelText: 'Digite Seu Nome',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor insira seu Nome';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: controladoraEmail,
                decoration: InputDecoration(
                  labelText: 'Digite Seu E-mail',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor coloque Seu E-mail';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: controladoraSenha,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  suffix: IconButton(
                    onPressed: () {
                      setState(() {
                        mostrarSenha = !mostrarSenha;
                      });
                    },
                    icon: mostrarSenha
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                  ),
                  labelText: 'Digite Sua Senha',
                  border: OutlineInputBorder(),
                ),
                obscureText: mostrarSenha,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor Digite Sua Senha';
                  }
                  if (value.length < 5) {
                    return 'A senha deve ter no Minimo 5 caracteres';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: idade,
                decoration: InputDecoration(
                  labelText: 'Qual sua idade?',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  int? idade = int.tryParse(value!);
                  if (idade == null) {
                    return 'Digite sua idade';
                  }
                  if (idade > 130 || idade < 0) {
                    return 'Idade Invalida';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
