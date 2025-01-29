import 'package:crud_app/RestAPI/RestClient.dart';
import 'package:crud_app/Screens/ProductGridViewScreen.dart';
import 'package:crud_app/Style/Style.dart';
import 'package:flutter/material.dart';

class ProductCreateScreen extends StatefulWidget {
  const ProductCreateScreen({super.key});

  @override
  State<ProductCreateScreen> createState() => _ProductCreateScreenState();
}

class _ProductCreateScreenState extends State<ProductCreateScreen> {
  Map<String, String> formValue = {
    "Img": "",
    "ProductCode": "",
    "ProductName": "",
    "Qty": "",
    "TotalPrice": "",
    "UnitPrice": ""
  };

  bool loading = false;

  inputOnChange(mapkey, textValue) {
    setState(() {
      formValue.update(mapkey, (value) => textValue);
    });
  }

  formOnSubmit() async {
    if (formValue["ProductName"]!.isEmpty) {
      errorToast('Product Name Required');
    } else if (formValue["ProductCode"]!.isEmpty) {
      errorToast('Product Code Required');
    } else if (formValue["Img"]!.isEmpty) {
      errorToast('Product Image Required');
    } else if (formValue["Qty"]!.isEmpty) {
      errorToast('Product Qty Required');
    } else if (formValue["UnitPrice"]!.isEmpty) {
      errorToast('Unit Price Required');
    } else if (formValue["TotalPrice"]!.isEmpty) {
      errorToast('Total Price Required');
    } else {
      setState(() {
        loading = true;
      });
      await createProductRequest(formValue);
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Product'),
        ),
        body: Stack(
          children: [
            // SvgPicture.asset('assets/images/screen-back.svg'),
            screenBackground(context),
            Container(
                child: loading
                    ? (const Center(
                        child: CircularProgressIndicator(),
                      ))
                    : ((SingleChildScrollView(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            TextFormField(
                              onChanged: (textValue) {
                                inputOnChange("ProductName", textValue);
                              },
                              decoration: appInputDecoration('Product Name'),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              onChanged: (textValue) {
                                inputOnChange("ProductCode", textValue);
                              },
                              decoration: appInputDecoration('Product Code'),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              onChanged: (textValue) {
                                inputOnChange("Img", textValue);
                              },
                              decoration: appInputDecoration('Product Image'),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              onChanged: (textValue) {
                                inputOnChange("Qty", textValue);
                              },
                              decoration: appInputDecoration('Quantity'),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              onChanged: (textValue) {
                                inputOnChange("UnitPrice", textValue);
                              },
                              decoration: appInputDecoration('Unit Price'),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              onChanged: (textValue) {
                                inputOnChange("TotalPrice", textValue);
                              },
                              decoration: appInputDecoration('Total Price'),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              style: appButtonStyle(),
                              onPressed: () {
                                formOnSubmit();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) =>
                                            ProductGridViewScreen()));
                              },
                              child: buttonChildStyle('Submit'),
                            )
                          ],
                        ),
                      ))))
          ],
        ),
      ),
    );
  }
}
