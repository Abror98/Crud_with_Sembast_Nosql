import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sembast_nosql/bloc/fruit/fruit_bloc.dart';
import 'package:sembast_nosql/data/fruit.dart';
import 'package:sembast_nosql/screens/dialog.dart';


class HomePage extends StatefulWidget {

  static Widget screen() => BlocProvider(
    create: (context) => FruitBloc(),
    child: HomePage(),
  );


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FruitBloc _fruitBloc;

  @override
  void initState() {
    super.initState();
    _fruitBloc = BlocProvider.of<FruitBloc>(context);
    _fruitBloc.add(LoadFruits());
  }

  openDialog(bool type, Fruit fruit){
    showDialog(context: context, builder: (BuildContext context){
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50, left: 20, right: 20, top: 50),
          child: DialogScreen.screen(type, fruit),
        ),
      );
    }).then((_) => _fruitBloc.add(LoadFruits()));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fruit app'),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          openDialog(true, Fruit());
        },
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder(
      bloc: _fruitBloc,
      // Whenever there is a new state emitted from the bloc, builder runs.
      builder: (BuildContext context, FruitState state) {
        if (state is FruitLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is FruitLoadedState) {
          return ListView.builder(
            itemCount: state.fruits.length,
            itemBuilder: (context, index) {
              final displayedFruit = state.fruits[index];
              return ListTile(
                title: Text(displayedFruit.name),
                subtitle:
                Text(displayedFruit.isSweet ? 'Very sweet!' : 'Sooo sour!'),
                trailing: _buildUpdateDeleteButtons(displayedFruit),
              );
            },
          );
        }
      },
    );
  }

  Row _buildUpdateDeleteButtons(Fruit displayedFruit) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(onPressed: (){
          openDialog(false, displayedFruit);
        },
        icon: Icon(Icons.edit)),
        IconButton(
          icon: Icon(Icons.delete_outline),
          onPressed: () {
            _fruitBloc.add(DeleteEvent(displayedFruit));
          },
        ),
      ],
    );
  }
}