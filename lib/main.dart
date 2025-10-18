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
  String _genero = "outro";
  bool _termos = false;

  void enviar() {
    final bool valido = _formkey.currentState?.validate() ?? false;
    if (!valido) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Não foi possivel enviar, preencha o formulário.'),
          duration: const Duration(seconds: 3),
        ),
      );

      return;
    }

    if (!_termos) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Aceite os Termos'),
          duration: const Duration(seconds: 3),
        ),
      );

      return;
    }

    showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Title'),
          content: Column(
            children: [
              Text(controladoraNome.text),
              Text(controladoraEmail.text),
              Text(controladoraSenha.text),
              Text(idade.text),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  bool mostrarSenha = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Primeiro Acesso'))),
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
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _genero,
                decoration: const InputDecoration(
                  labelText: 'Escolha Seu Genero',
                  border: OutlineInputBorder(),
                ),
                items: [
                  DropdownMenuItem(
                    value: "masculino",
                    child: Text("Masculino"),
                  ),
                  DropdownMenuItem(value: "feminino", child: Text("Feminino")),
                  DropdownMenuItem(value: "outro", child: Text("Outro")),
                ],
                onChanged: (value) {
                  setState(() {
                    _genero = value ?? 'outro';
                  });
                },
              ),
              SizedBox(height: 16),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                title: Text("Aceita os Termos"),
                subtitle: _termos
                    ? null
                    : Text(
                        'Aceite os termos para continuar',
                        style: TextStyle(color: Colors.red),
                      ),
                value: _termos,
                onChanged: (v) {
                  setState(() {
                    _termos = v ?? false;
                  });
                },
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                iconAlignment: IconAlignment.end,
                onPressed: enviar,
                label: Text('Cadastrar'),
                icon: Icon(Icons.send),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
