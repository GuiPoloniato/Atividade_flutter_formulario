import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CadastroPage(),
    );
  }
}

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();

  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final cpfController = TextEditingController();
  final telefoneController = TextEditingController();
  final senhaController = TextEditingController();

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    cpfController.dispose();
    telefoneController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  void cadastrar() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cadastro realizado com sucesso!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Usuário'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      // CENTRALIZA O FORMULÁRIO NA TELA
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),

            // LIMITA A LARGURA DO FORMULÁRIO
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 450,
              ),

              child: Form(
                key: _formKey,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    const Icon(
                      Icons.person_add,
                      size: 80,
                      color: Colors.blue,
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'Crie sua conta',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // CAMPO NOME
                    TextFormField(
                      controller: nomeController,
                      keyboardType: TextInputType.name,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(100),
                      ],

                      decoration: const InputDecoration(
                        labelText: 'Nome completo',
                        hintText: 'Digite seu nome',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),

                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Digite seu nome';
                        }

                        if (value.trim().length < 3) {
                          return 'O nome deve ter pelo menos 3 caracteres';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // CAMPO E-MAIL
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(254),
                      ],

                      decoration: const InputDecoration(
                        labelText: 'E-mail',
                        hintText: 'Digite seu e-mail',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),

                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Digite seu e-mail';
                        }

                        if (!value.contains('@')) {
                          return 'Digite um e-mail válido';
                        }

                        final emailRegex = RegExp(
                          r'^[\w\.-]+@([\w-]+\.)+[\w]{2,}$',
                        );

                        if (!emailRegex.hasMatch(value.trim())) {
                          return 'E-mail inválido';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // CAMPO CPF
                    TextFormField(
                      controller: cpfController,
                      keyboardType: TextInputType.number,

                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(11),
                      ],

                      decoration: const InputDecoration(
                        labelText: 'CPF',
                        hintText: 'Digite os 11 números do CPF',
                        prefixIcon: Icon(Icons.badge),
                        border: OutlineInputBorder(),
                      ),

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Digite seu CPF';
                        }

                        if (value.length != 11) {
                          return 'O CPF deve ter 11 números';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // CAMPO TELEFONE
                    TextFormField(
                      controller: telefoneController,
                      keyboardType: TextInputType.phone,

                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(11),
                      ],

                      decoration: const InputDecoration(
                        labelText: 'Telefone',
                        hintText: 'Digite seu telefone com DDD',
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                      ),

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Digite seu telefone';
                        }

                        if (value.length < 10 || value.length > 11) {
                          return 'Telefone deve ter 10 ou 11 números';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // CAMPO SENHA
                    TextFormField(
                      controller: senhaController,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,

                      decoration: const InputDecoration(
                        labelText: 'Senha',
                        hintText: 'Digite sua senha',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                      ),

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Digite uma senha';
                        }

                        if (value.length < 6) {
                          return 'A senha deve ter pelo menos 6 caracteres';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 30),

                    // BOTÃO CADASTRAR
                    SizedBox(
                      width: double.infinity,
                      height: 50,

                      child: ElevatedButton(
                        onPressed: cadastrar,

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),

                        child: const Text(
                          'CADASTRAR',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}