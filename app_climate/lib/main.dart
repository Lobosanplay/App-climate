import 'package:app_climate/providers/OpenWeatherMap_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const climate());
}

class climate extends StatelessWidget {
  const climate({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App climate',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'App climate'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    final climas = Provider.of<ClimaProviders>(context, listen: false);

    climas.FetchRecipes();
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(0.8, 1),
              colors: <Color>[
                Color.fromRGBO(0, 0, 70, 1),
                Color.fromRGBO(28, 181, 224, 1)
              ],
            ),
          ),
          child: Consumer<ClimaProviders>(
            builder: (context, provider, child) {
              if (provider.isloading){
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
                return ListView.builder(
                itemBuilder: (context, index){
                  return  Text("Gola");
                }
              );
            }
          }
          ),
        ),
    );

    
  }
}
