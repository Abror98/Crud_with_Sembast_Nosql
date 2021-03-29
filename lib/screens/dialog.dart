import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sembast_nosql/bloc/dialog/dialog_bloc.dart';
import 'package:sembast_nosql/data/fruit.dart';

class DialogScreen extends StatefulWidget {
  final bool type;
  final Fruit fruit;

  static Widget screen(bool type, Fruit fruit) => BlocProvider(
    create: (context) => DialogBloc(context: context),
    child: DialogScreen(type: type, fruit: fruit,),
  );

  DialogScreen({this.type, this.fruit});
  @override
  _DialogScreenState createState() => _DialogScreenState();
}

class _DialogScreenState extends State<DialogScreen> {
  DialogBloc bloc;
 final TextEditingController nameController = TextEditingController();


  @override
  void initState() {
    bloc = BlocProvider.of<DialogBloc>(context);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(10),
        height: 130,
        width: 200,
        child: Column(
            children: [
              Text(widget.type ? "Add" : "Update", style: TextStyle(fontSize: 20, color: Colors.yellow)),
              Row(
                children: [
                  Text("Name: "),
                  Expanded(
                    child: Container(
                      height: 30,
                      child: Center(
                        child: TextField(
                          decoration: new InputDecoration.collapsed(
                              hintText: 'name',
                            hintStyle: TextStyle(color: Colors.black38)
                          ),
                          controller: nameController,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(child: SizedBox()),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    child: MaterialButton(
                      color: Colors.blue,
                      onPressed: (){
                        bloc.add(BackEvent());
                      }, child: Text("cancel", style: TextStyle(color: Colors.white),),),
                  ),
                  Expanded(child: SizedBox()),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    child: MaterialButton(
                      color: Colors.blue,
                      onPressed: (){
                        if(nameController != null) {
                          if(widget.type){
                          bloc.add(SaveEvent(name: nameController.text,
                              isSweet: false));}
                              else {
                                Fruit model = new Fruit(name: nameController.text, isSweet: false);
                               bloc.add(UpdateEvent(oldItems: widget.fruit, newItems: model));
                        }
                        }
                      }, child: Text(widget.type ? "save" : "update", style: TextStyle(color: Colors.white),),),
                  ),
                ],
              )
            ],
        ),
      ),
    );
  }
}
