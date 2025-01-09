import 'package:crud_app/Screens/ProductUpdateScreen.dart';
import 'package:crud_app/Style/Style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../RestAPI/RestClient.dart';
import 'ProductCreateScreen.dart';

class ProductGridViewScreen extends StatefulWidget {
  const ProductGridViewScreen({super.key});

  @override
  State<ProductGridViewScreen> createState() => _ProductGridViewScreenState();
}

class _ProductGridViewScreenState extends State<ProductGridViewScreen> {
  List productList = [];
  bool loading = true;

  @override
  void initState() {
    callData();
    super.initState();
  }

  callData() async {
    loading = true;
    var Data = await createGridViewRequest();
    setState(() {
      productList = Data;
      loading = false;
    });
  }

  DeleteItem(id) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Delete!'),
            content: const Text('Do you want to Delete?'),
            actions: [
              OutlinedButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    setState(() {
                      loading = true;
                    });
                    await deleteProductRequest(id);
                    await callData();
                  },
                  child: const Text('Yes')),
              const SizedBox(
                width: 4,
              ),
              OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('No')),
            ],
          );
        });
  }

  GotoUpdate(context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (builder) => const ProductUpdateScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: Stack(
        children: [
          screenBackground(context),
          Container(
              child: loading
                  ? (const Center(
                      child: CircularProgressIndicator(),
                    ))
                  : RefreshIndicator(
                      onRefresh: () async {
                        await callData();
                      },
                      child: (GridView.builder(
                          gridDelegate: ProductGridViewStyle(),
                          itemCount: productList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                      child: Image.network(
                                    productList[index]["Img"],
                                    fit: BoxFit.fill,
                                  )),
                                  Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 5, 5, 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(productList[index]["ProductName"]),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text('Price' +
                                            productList[index]["UnitPrice"]),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            OutlinedButton(
                                                onPressed: () {
                                                  GotoUpdate(context);
                                                },
                                                child: const Icon(
                                                  CupertinoIcons
                                                      .ellipsis_vertical_circle,
                                                  size: 18,
                                                  color: Colors.green,
                                                )),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            OutlinedButton(
                                                onPressed: () {
                                                  DeleteItem(productList[index]
                                                      ["_id"]);
                                                },
                                                child: const Icon(
                                                  CupertinoIcons.delete,
                                                  size: 18,
                                                  color: Colors.red,
                                                )),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          })),
                    ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (builder) => const ProductCreateScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
