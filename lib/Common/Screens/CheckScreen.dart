import '/Common/Helper/FavouriteSelectionDialogCubit/favouriteselectiondialogbox_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';

class CheckScreen extends StatefulWidget {
  const CheckScreen({Key? key}) : super(key: key);

  @override
  _CheckScreenState createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen> {
  List<String> local = [
    'car',
    'Bus',
    'van',
    'Aeroplane',
    'HeloCopter',
    'cycle',
    'ship'
  ];
  List<String>? fav = ['car', 'ship', 'van'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AlertDialog(
            title: Text('Add Favourites'),
            content: GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(8),
                itemCount: local.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: (MediaQuery.of(context).orientation ==
                            Orientation.portrait)
                        ? 3
                        : 4),
                itemBuilder: (context, index) {
                  return BlocProvider(
                      create: (context) => FavouriteselectiondialogboxCubit(),
                      child: check(
                        v3: local[index],
                        v1: fav,
                        v2: local[index],
                      ));
                })));
  }
}

class check extends StatelessWidget {
  String? v2;
  String? v3;
  List? v1;
  check({Key? key, this.v3, this.v1, this.v2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = BlocProvider.of<FavouriteselectiondialogboxCubit>(context);
    c.initialValue(v1!, v2);
    return BlocBuilder<FavouriteselectiondialogboxCubit,
        FavouriteselectiondialogboxState>(
      builder: (context, state) {
        print('nnn val ${state.val}');
        return state.val!
            ? v3
                .toString()
                .text
                .bold
                .makeCentered()
                .box
                .p16
                .amber400
                .square(200)
                .makeCentered()
            : v3
                .toString()
                .text
                .bold
                .makeCentered()
                .box
                .p16
                .red400
                .square(100)
                .makeCentered();
      },
    );
  }
}
































/* import '/Common/Helper/LoadDataPartByPartCubit/loaddatapartbypart_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CheckScreen extends StatefulWidget {
  const CheckScreen({Key? key}) : super(key: key);

  @override
  _CheckScreenState createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen> {
  List<DocumentSnapshot> list = [];
  int perPage = 10;
  int docLength = 0;
  DocumentSnapshot? lastDocData;
  ScrollController scrollController = ScrollController();

  // getMoreProducts() async {
  //   if (moreproductsAvailable == false) {
  //     return;
  //   }
  //   if (getmoreproducts == true) {
  //     return;
  //   }
  //   getmoreproducts = true;
  //   Query qu = await FirebaseFirestore.instance
  //       .collection('CheckColl')
  //       .orderBy('CreatedAt') //, descending: true)
  //       .startAfter([lastDoc!.get('CreatedAt')]).limit(perPage);
  //   QuerySnapshot q = await qu.get();
  //   if (q.docs.length < perPage) {
  //     moreproductsAvailable = false;
  //   }
  //   lastDoc = q.docs[q.docs.length - 1];
  //   _list.addAll(q.docs);

  //   setState(() {});
  //   getmoreproducts = false;

  //   //  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //   //  content: Text('Getting More Data'),
  //   //  ));
  //   //q.docs = [];
  // }

  @override
  void initState() {
    // scrollController.addListener(() {
    //   double maxScroll = scrollController.position.maxScrollExtent;
    //   double currentScroll = scrollController.position.pixels;
    //   double delta = context.screenHeight * 0.25;

    //   if (maxScroll - currentScroll <= delta) {
    //     //getMoreProducts();
    //     if (lastDocData != null) {
    //       if (docLength < perPage) {
    //         context
    //             .read<LoaddatapartbypartCubit>()
    //             .getMoreProducts(list, lastDocData!);
    //       }
    //     }
    //   }
    // });
    //Future.delayed(Duration(seconds: 1), () {
    print('nnn Emtered');
    scrollController.addListener(() async {
      if (scrollController.position.extentAfter == 0) {
        context
            .read<LoaddatapartbypartCubit>()
            .getMoreProducts(list, lastDocData!, context, docLength);
      }
    });
    //});
    print('nnn init build');
    context.read<LoaddatapartbypartCubit>().getProducts();
//    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('nnn build');
    return FutureBuilder(
        future: Future.delayed(Duration(seconds: 3))
            .then((value) => Future.value(true)),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? BlocBuilder<LoaddatapartbypartCubit, LoaddatapartbypartState>(
                  builder: (context, lState) {
                    if (lState.lastDoc != null &&
                        lState.splitedData != null &&
                        lState.docLength != null) {
                      lastDocData = lState.lastDoc;
                      list = lState.splitedData!;
                      docLength = lState.docLength!;
                    }
                    return lState.splitedData != null
                        ? Scaffold(
                            body: Container(
                              height: context.screenHeight,
                              width: context.screenWidth,
                              child: ListView.builder(
                                shrinkWrap: true,
                                controller: scrollController,
                                itemCount: lState.splitedData!.length,
                                itemBuilder: (context, index) {
                                  //print('nnn current index ${scrollController.position.}');
                                  return lState.splitedData![index]
                                      .get('Title')
                                      .toString()
                                      .text
                                      .lg
                                      .make()
                                      .box
                                      .p32
                                      .make();
                                },
                              ),
                            ),
                          )
                        : Container();
                  },
                )
              : Scaffold(
                  body: Center(
                    child: Text('Loading...'),
                  ),
                );
        });
  }
}



















/*import 'package:cloud_firestore/cloud_firestore.dart';
import '/Common/Constant/Constants.dart';
import '/Common/Helper/CheckHelperCubit/checkhelper_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckScreen extends StatefulWidget {
  const CheckScreen({Key? key}) : super(key: key);

  @override
  _CheckScreenState createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen> {
  @override
  Widget build(BuildContext context) {
    //final help = BlocProvider.of<CheckhelperCubit>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Check Screen')),
      body: Container(
        width: getWidth(context),
        height: getHeight(context),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('CheckCollection')
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      //Datamdl2 m = Datamdl2.fromJson(snapshot.data.docs[index]);
                      DocumentSnapshot ds = snapshot.data.docs[index];

                      //                help.getboolForField(ds.id);

                      return Container(
                        margin: EdgeInsets.all(50),
                        child: BlocProvider(
                          create: (context) => CheckhelperCubit(),
                          child:
                              BlocBuilder<CheckhelperCubit, CheckhelperState>(
                            builder: (context, state) {
                              context
                                  .read<CheckhelperCubit>()
                                  .getboolForField(ds.id);

                              print('nnn state Cubit ${ds.id}');
                              return Column(
                                children: [
                                  state.title != null
                                      ? Text(state.title!)
                                      : Container(),
                                  state.desc != null
                                      ? Text(state.desc!)
                                      : Container(),
                                  state.body != null
                                      ? Text(state.body!)
                                      : Container(),
                                  state.error != null
                                      ? Text(state.error!)
                                      : Container(),
                                  state.state != null
                                      ? Text(state.state!)
                                      : Container(),
                                ],
                              );
                            },
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}

class Datamdl {
  String? title, desc, body;

  Datamdl({this.title, this.desc, this.body});

  Datamdl.fromJson(DocumentSnapshot json) {
    title = json['title'];
    desc = json['desc'];
    body = json['body'];
  }
}

class Datamdl2 {
  String? title, desc, body, error;

  Datamdl2({this.title, this.desc, this.body, this.error});

  Datamdl2.fromJson(DocumentSnapshot json) {
    title = json['title'];
    desc = json['desc'];
    body = json['body'];
    error = json['error'];
  }
}
*/ */