import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:http/http.dart' as http;
import '../sample_page.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late final TextEditingController _productController = TextEditingController();

  late final TextEditingController _productNameController =
      TextEditingController();
  late final TextEditingController _productPriceController =
      TextEditingController();
  late final TextEditingController _productTimeController =
      TextEditingController();
  late final TextEditingController _productWeightController =
      TextEditingController();
  late final TextEditingController _productStatusController =
      TextEditingController();

  var token = '';
  var name = [];
  var iid = [];
  var product = [];
  var pro;
  var l = 0;
  var image = "";

  Future<void> getCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token')!;
    var response = await http.get(
        Uri.parse(
            'https://doppi-backend-production.up.railway.app/api/product/categories'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        });
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      name.clear();
      for (var i = 0; i < data.length; i++) {
        name.add(data[i]['name']);
        iid.add(data[i]['_id']);
        print(iid[i]);
        getProducts(iid[i]);
        l++;
      }
      l = l + 100;
      _tabController = TabController(length: l, vsync: this);
      setState(() {});
    } else {
      print("error");
    }
  }

  Future<void> addCategory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token')!;
    var response = await http.post(
        Uri.parse(
            'https://doppi-backend-production.up.railway.app/api/product/add-category'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({"name": _productController.text, "photo": "Ok"}));
    //print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
    } else {
      print("error");
    }
  }

  Future<void> getProducts(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token')!;
    var response = await http.get(
        Uri.parse(
            'https://doppi-backend-production.up.railway.app/api/product//category/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        });
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      //product.clear();
      for (var i = 0; i < data.length; i++) {
        product.add(data[i]);
        print(product[i]);
      }
      setState(() {});
    } else {
      print("error");
    }
  }

  //delete category
  Future<void> deleteCategory(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token')!;
    var response = await http.delete(
        Uri.parse(
            'https://doppi-backend-production.up.railway.app/api/product/category/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        });
    //print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
    } else {
      print("error");
    }
  }

  Future<void> addProduct(String id) async {
    var response = await http.post(
        Uri.parse(
            'https://doppi-backend-production.up.railway.app/api/product/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "name": _productNameController.text,
          "price": _productPriceController.text,
          "time": _productTimeController.text,
          "weight": _productWeightController.text,
          "status": _productStatusController.text,
          "photo": image,
          //"category": id
        }));
    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonDecode(response.body);
      print(data);
      image = "";
      _productNameController.text = "";
      _productPriceController.text = "";
      _productTimeController.text = "";
      _productWeightController.text = "";
      _productStatusController.text = "";
    } else {
      print("error");
      print(response.body);
    }
  }

  //dialog for delete category
  void _showDialog(String id) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Delete Category"),
            content:
                const Text("Are you sure you want to delete this category?"),
            actions: [
              TextButton(
                child: const Text("Yes"),
                onPressed: () {
                  deleteCategory(id);
                  Navigator.of(context).pop();
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SamplePage(),
                    ),
                  );
                },
              ),
              TextButton(
                child: const Text("No"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  YYDialog yYDialogDemo(BuildContext context) {
    return YYDialog().build(context)
      ..width = MediaQuery.of(context).size.width * 0.8
      ..height = MediaQuery.of(context).size.height * 0.2
      ..borderRadius = 4.0
      ..widget(
        Column(
          children: [
            //add product name
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: const Text(
                'Add Category',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                child: TextField(
                  controller: _productController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Category Name',
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                onPressed: () {
                  addCategory();
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SamplePage(),
                    ),
                  );
                },
                child: const Text('Add Category'),
              ),
            ),
          ],
        ),
      )
      ..show();
  }

  YYDialog deleteDialog(BuildContext context) {
    return YYDialog().build(context)
      ..width = MediaQuery.of(context).size.width * 0.8
      ..height = MediaQuery.of(context).size.height * 0.2
      ..borderRadius = 4.0
      ..widget(
        Column(
          children: [
            //select Category popup menu get all name in category list
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: PopupMenuButton(
                onSelected: (value) {
                  _showDialog(value.toString());
                },
                itemBuilder: (context) {
                  return List.generate(name.length, (index) {
                    return PopupMenuItem(
                      value: iid[index],
                      child: Text(name[index]),
                    );
                  });
                },
                child: const Text('Select Category',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
          ],
        ),
      )
      ..show();
  }

  //dilalog delete and update and no
  void _showDialog1(String id, String name) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Update Category or Delete"),
            content:
                const Text("Do you want to update or delete this category?"),
            actions: [
              TextButton(
                child: const Text("Delete"),
                onPressed: () {
                  deleteProduct(id);
                  Navigator.of(context).pop();
                  _showDialogDelete(id);
                },
              ),
              TextButton(
                child: const Text("Update"),
                onPressed: () {
                  Navigator.of(context).pop();
                  showDialogUpdate(id, name);
                },
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("No"))
            ],
          );
        });
  }

  //delete dialog
  void _showDialogDelete(String id) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Delete Category"),
            content:
                const Text("Are you sure you want to delete this category?"),
            actions: [
              TextButton(
                child: const Text("Yes"),
                onPressed: () {
                  deleteProduct(id);
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text("No"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  deleteProduct(String id) async {
    var response = await http.delete(
        Uri.parse(
            'https://doppi-backend-production.up.railway.app/api/product/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        });
    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonDecode(response.body);
      print(data);
    } else {
      print("error");
      print(response.body);
    }
  }

  void showDialogUpdate(String id, String name) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Update Category"),
            content:
                const Text("Are you sure you want to update this category?"),
            actions: [
              TextButton(
                child: const Text("Yes"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text("No"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _showDialogAddProduct(String id) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add Product"),
            content: const Text("Are you sure you want to add this product?"),
            actions: [
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: MediaQuery.of(context).size.height * 0.055,
                      child: TextField(
                        textInputAction: TextInputAction.next,
                        obscureText: false,
                        controller: _productNameController,
                        toolbarOptions: const ToolbarOptions(
                          cut: false,
                          copy: false,
                          selectAll: false,
                          paste: false,
                        ),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          labelText: 'Product Name',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: MediaQuery.of(context).size.height * 0.055,
                      child: TextField(
                        textInputAction: TextInputAction.next,
                        obscureText: false,
                        controller: _productPriceController,
                        toolbarOptions: const ToolbarOptions(
                          cut: false,
                          copy: false,
                          selectAll: false,
                          paste: false,
                        ),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          labelText: 'Product Price',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: MediaQuery.of(context).size.height * 0.055,
                      child: TextField(
                        textInputAction: TextInputAction.next,
                        obscureText: false,
                        controller: _productTimeController,
                        toolbarOptions: const ToolbarOptions(
                          cut: false,
                          copy: false,
                          selectAll: false,
                          paste: false,
                        ),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          labelText: 'Time',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: MediaQuery.of(context).size.height * 0.055,
                      child: TextField(
                        textInputAction: TextInputAction.next,
                        obscureText: false,
                        controller: _productWeightController,
                        toolbarOptions: const ToolbarOptions(
                          cut: false,
                          copy: false,
                          selectAll: false,
                          paste: false,
                        ),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          labelText: 'Weight',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: MediaQuery.of(context).size.height * 0.055,
                      child: TextField(
                        textInputAction: TextInputAction.next,
                        obscureText: false,
                        controller: _productStatusController,
                        toolbarOptions: const ToolbarOptions(
                          cut: false,
                          copy: false,
                          selectAll: false,
                          paste: false,
                        ),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          labelText: 'Status',
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Expanded(child: Text("")),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: IconButton(
                            onPressed: () {
                              _showPicker(context);
                            },
                            icon: const Icon(Icons.add_a_photo_outlined,
                                color: Color.fromARGB(255, 2, 48, 71)),
                          ),
                        ),
                        const Expanded(child: Text("")),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 2, 48, 71))),
                          ),
                        ),
                        const Expanded(child: Text("")),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: TextButton(
                            onPressed: () {
                              //clear list get data
                              addProduct(id);
                              Navigator.pop(context);
                            },
                            child: const Text('Add Product',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 2, 48, 71))),
                          ),
                        ),
                        const Expanded(child: Text("")),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  //_showPicker(context);
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Photo Library'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  _imgFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      List<int> imageBytes = imageFile.readAsBytesSync();
      image = base64Encode(imageBytes).toString();
      setState(() {});
      print(image);
    }
  }

  _imgFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      List<int> imageBytes = imageFile.readAsBytesSync();
      image = base64Encode(imageBytes);
      setState(() {});
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _productController.dispose();
    _productNameController.dispose();
    _productPriceController.dispose();
    _productTimeController.dispose();
    _productWeightController.dispose();
    _productStatusController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (name.isNotEmpty) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          backgroundColor: const Color.fromARGB(255, 33, 158, 188),
          children: [
            SpeedDialChild(
              child: const Icon(Icons.add),
              backgroundColor: Colors.green,
              onTap: () => yYDialogDemo(context),
              label: 'First Child',
              labelStyle: const TextStyle(fontSize: 18.0),
              labelBackgroundColor: Colors.green,
            ),
            SpeedDialChild(
              child: const Icon(Icons.brush),
              backgroundColor: const Color.fromARGB(255, 33, 158, 188),
              onTap: () => print('SECOND CHILD'),
              label: 'Second Child',
              labelStyle: const TextStyle(fontSize: 18.0),
              labelBackgroundColor: const Color.fromARGB(255, 33, 158, 188),
            ),
            SpeedDialChild(
              child: const Icon(Icons.delete),
              backgroundColor: Colors.red,
              onTap: () => deleteDialog(context),
              label: 'Third Child',
              labelStyle: const TextStyle(fontSize: 18.0),
              labelBackgroundColor: Colors.red,
            ),
          ],
        ),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: AppBar(
            backgroundColor: const Color.fromRGBO(33, 158, 188, 10),
            elevation: 0,
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: const Color.fromARGB(255, 2, 48, 71),
              isScrollable: true,
              labelPadding: const EdgeInsets.only(left: 40, right: 40),
              tabs: [
                for (var i = 0; i < name.length; i++)
                  Tab(
                    child: Text(name[i]),
                  ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            for (var i = 0; i < iid.length; i++)
              Center(
                child: ListView(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showDialogAddProduct(iid[i]);
                      },
                      child: Card(
                        shadowColor: Colors.black,
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: SizedBox(
                              height: 70,
                              child: Center(
                                //child add icon for category
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: SvgPicture.asset(
                                        'assets/svgs/bottab1.svg',
                                        height: 35,
                                        width: 35,
                                      ),
                                    ),
                                    const Text("Add Product"),
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ),
                    for (var j = 0; j < product.length; j++)
                      if (product[j]['category'] == iid[i])
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Column(
                                          children: [
                                            Image.network(
                                              product[j]['photo'],
                                              height: 200,
                                              width: 200,
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height* 0.01,
                                            ),
                                            Text(product[j]['name']),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  40,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    15),
                                              ),
                                              child: Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  const Icon(
                                                    Icons
                                                        .access_time_rounded,
                                                    color: Colors.black,
                                                  ),
                                                  const SizedBox(
                                                    height: 30,
                                                    width: 6,
                                                  ),
                                                  Text(
                                                    product[j]['time']
                                                        .toString(),
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  //delete icons
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(product[j]['price']),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: Card(
                                shadowColor: Colors.black,
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: SizedBox(
                                      height: 70,
                                      child: Center(
                                        //child add icon for category
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.009,
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: Image.network(
                                                product[j]['photo'],
                                                //'https://www.pngitem.com/pimgs/m/31-317029_listtodo-flutter-examples-hd-png-download.png',
                                                height: 35,
                                                width: 35,
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.009,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(product[j]['name']),
                                                Text(product[j]['price']),
                                              ],
                                            ),
                                            Expanded(child: Container()),
                                            Column(
                                              children: [
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.006,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black,
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      const Icon(
                                                        Icons
                                                            .access_time_rounded,
                                                        color: Colors.black,
                                                      ),
                                                      const SizedBox(
                                                        height: 30,
                                                        width: 6,
                                                      ),
                                                      Text(
                                                        product[j]['time']
                                                            .toString(),
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      //delete icons
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.02,
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                //popup
                                                _showDialog1(product[j]['_id'],
                                                    product[j]['name']);
                                              },
                                              icon: const Icon(Icons.edit),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.009,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                  ],
                ),
              ),
          ],
        ),
      );
    } else {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: AppBar(
            backgroundColor: const Color.fromRGBO(33, 158, 188, 10),
            elevation: 3,
          ),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            yYDialogDemo(context);
            // Add your onPressed code here!
          },
          child: const Icon(Icons.add, color: Color.fromARGB(255, 2, 48, 71)),
        ),
      );
    }
  }
}

class AppHome extends StatelessWidget {
  const AppHome({super.key});

  @override
  Widget build(BuildContext context) {
    YYDialog.init(context);
    return const MaterialApp(
      home: ProductPage(),
    );
  }
}
