import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sirbanks_driver/model/car_model.dart';
import 'package:sirbanks_driver/provider/auth.dart';
import 'package:sirbanks_driver/utils/shared/rounded_raisedbutton.dart';

import '../../constants.dart';

class CompleteRegistrationScreen extends StatefulWidget {
  // const CompleteRegistrationScreen({ Key? key }) : super(key: key);

  @override
  _CompleteRegistrationScreenState createState() =>
      _CompleteRegistrationScreenState();
}

class _CompleteRegistrationScreenState
    extends State<CompleteRegistrationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  PageController _uploadPageController = PageController(initialPage: 0);
  GlobalKey<FormState> _page1FormKey = GlobalKey();
  GlobalKey<FormState> _page2FormKey = GlobalKey();
  TextEditingController _startdate = new TextEditingController();
  TextEditingController _enddate = new TextEditingController();
  CarModel _mycar;
  CarModel _mycarmodel;
  List<Widget> pages;
  int pageIndex = 0;
  bool _isLoading = false;
  bool _isInit = true;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      await Provider.of<Auth>(context, listen: false).getCountryList();
      setState(() {
        _isInit = false;
      });
    }
    super.didChangeDependencies();
  }

  File _imageavatar, _imagelicence, _imageinsurance, _imagevehiclePaper;
  var avatarImage, licenceImage, insuranceImage, vehiclePaperImage;
  String avatarname, licencename, insurancename, vehiclename;
  String make, carId, model, licenceNo, issueDate, expDate, color, numberPlate;
  int year;

  Future getavatarImage(ImgSource source) async {
    var image = await ImagePickerGC.pickImage(
      context: context,
      source: source,
      maxHeight: 200,
      maxWidth: 200,
      imageQuality: 60,
      cameraIcon: Icon(
        Icons.add,
        color: Colors.red,
      ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
    );
    setState(() {
      avatarname = image.path.toString().split('/').last;
      _imageavatar = image;
      avatarImage = "data:image/${image.path.toString().split('.').last};base64,${base64Encode(_imageavatar.readAsBytesSync())}";
      print(avatarImage);
      print("data:image/${image.path.toString().split('.').last};base64,${base64Encode(_imageavatar.readAsBytesSync())}");
    });
  }

  Future getlicenceImage(ImgSource source) async {
    File image = await ImagePickerGC.pickImage(
      context: context,
      source: source,
      maxHeight: 200,
      maxWidth: 200,
      imageQuality: 60,
      cameraIcon: Icon(
        Icons.add,
        color: Colors.red,
      ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
    );
    setState(() {
      licencename = image.path.toString().split('/').last;
      _imagelicence = image;
      licenceImage = "data:image/${image.path.toString().split('.').last};base64,${base64Encode(_imagelicence.readAsBytesSync())}";
    });
  }

  Future getinsuranceImage(ImgSource source) async {
    File image = await ImagePickerGC.pickImage(
      context: context,
      source: source,
      maxHeight: 200,
      maxWidth: 200,
      imageQuality: 60,
      cameraIcon: Icon(
        Icons.add,
        color: Colors.red,
      ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
    );
    setState(() {
      insurancename = image.path.toString().split('/').last;
      _imageinsurance = image;
      // _image3Extension = image.path.toString().split("/").last.split(".").last;
      insuranceImage = "data:image/${image.path.toString().split('.').last};base64,${base64Encode(_imageinsurance.readAsBytesSync())}";
    });
  }

  Future getvehiclePaperImage(ImgSource source) async {
    File image = await ImagePickerGC.pickImage(
      context: context,
      source: source,
      maxHeight: 200,
      maxWidth: 200,
      imageQuality: 60,
      cameraIcon: Icon(
        Icons.add,
        color: Colors.red,
      ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
    );
    setState(() {
      vehiclename = image.path.toString().split('/').last;
      _imagevehiclePaper = image;
      vehiclePaperImage = "data:image/${image.path.toString().split('.').last};base64,${base64Encode(_imagevehiclePaper.readAsBytesSync())}";
    });
  }

  _showShackBar(errorMessage) {
    final snackBar = new SnackBar(
      content: new Text(
        errorMessage,
        textAlign: TextAlign.center,
      ),
      duration: new Duration(seconds: 3),
      backgroundColor: Colors.blueGrey,
    );

    _scaffoldkey.currentState.showSnackBar(snackBar);
  }

  void validatePage(int index) {
    if (index == 0) {
      if (!_page1FormKey.currentState.validate()) {
        _showShackBar("Fill the required fields");
        throw "error";
      } else if (_mycar == null) {
        _showShackBar("Please select your Car Name");
        throw "error";
      } else if (_mycarmodel == null) {
        _showShackBar("Please select your Car Model");
        throw "error";
      }
      _page1FormKey.currentState.save();
    }
    // if (pageIndex == 1) {
    //   if (!_page2FormKey.currentState.validate()) {
    //     _showShackBar("Fill the required fields");
    //     throw "error";
    //   }
    //   // if (_mycountry == null) {
    //   //   _showShackBar("Select Country");
    //   //   throw "error";
    //   // }
    //   _page2FormKey.currentState.save();
    // }
  }

  Future<Null> _selectDate(BuildContext context, String data) async {
    DateFormat formatter = DateFormat.yMd(); //specifies day/month/year format
    DateTime selectedDate = DateTime.now();

    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2002),
        lastDate: DateTime(2030));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        if (data == 'start') {
          _startdate.value = TextEditingValue(text: formatter.format(picked));
        } else {
          _enddate.value = TextEditingValue(text: formatter.format(picked));
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    final country1 = Provider.of<Auth>(context);
    List<CarModel> countrydata = country1.carvalue;
    List<CarModel> statedata = country1.carmodelvalue;

    Widget page1 = SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Card(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Form(
              key: _page1FormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<CarModel>(
                            hint: Text(
                              "Car Name",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xffC3BBBB),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            value: _mycar,
                            onChanged: (CarModel value) {
                              setState(() {
                                _mycar = value;
                                make = value.name;
                                carId = value.id;
                                // statedata.clear();
                                _mycarmodel = null;
                                print(carId);
                              });
                              Provider.of<Auth>(context, listen: false)
                                  .getcarModel(carId);
                            },
                            items: countrydata.map<DropdownMenuItem<CarModel>>(
                                (CarModel item) {
                              return DropdownMenuItem<CarModel>(
                                child: new Text(item.name.toString()),
                                value: item,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<CarModel>(
                            hint: Text(
                              "Car Model",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xffC3BBBB),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            value: _mycarmodel,
                            onChanged: (CarModel value) {
                              setState(() {
                                _mycarmodel = value;
                                model = value.name;
                                // carId = value.id;
                                // // statedata.clear();
                                // _mycarmodel = null;
                                // print(carId);
                              });
                            },
                            items: statedata.map<DropdownMenuItem<CarModel>>(
                                (CarModel item) {
                              return DropdownMenuItem<CarModel>(
                                child: new Text(item.name.toString()),
                                value: item,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      TextFormField(
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusColor: Colors.black,
                          hintText: "Year",
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Color(0xffC3BBBB),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "First name required";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          year = int.parse(value);
                        },
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.black,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      TextFormField(
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusColor: Colors.black,
                          hintText: "Licence Number",
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Color(0xffC3BBBB),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Licence Number required";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          licenceNo = value;
                        },
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.black,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _selectDate(context, 'start');
                        },
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: _startdate,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusColor: Colors.black,
                              hintText: "Issue Date",
                              hintStyle: TextStyle(
                                fontSize: 16,
                                color: Color(0xffC3BBBB),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "First name required";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              issueDate = value;
                            },
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.black,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _selectDate(context, 'end');
                        },
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: _enddate,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusColor: Colors.black,
                              hintText: "Expire Date",
                              hintStyle: TextStyle(
                                fontSize: 16,
                                color: Color(0xffC3BBBB),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Expire Date required";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              expDate = value;
                            },
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.black,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      TextFormField(
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusColor: Colors.black,
                          hintText: "Expire Date Plate no.",
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Color(0xffC3BBBB),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "First name required";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          // user.email = value;
                        },
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.black,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      TextFormField(
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusColor: Colors.black,
                          hintText: "color",
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Color(0xffC3BBBB),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "First name required";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          color = value;
                        },
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.black,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      TextFormField(
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusColor: Colors.black,
                          hintText: "Plate no.",
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Color(0xffC3BBBB),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "First name required";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          numberPlate = value;
                        },
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.black,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );

    Widget page2 = SingleChildScrollView(
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(20),
        child: Form(
          key: _page2FormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Driver’s image',
                    style: TextStyle(
                        color: Color(0xffC3BBBB),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      getavatarImage(ImgSource.Both);
                    },
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      dashPattern: [6, 6],
                      color: Color(0xff24414D),
                      radius: Radius.circular(10),
                      strokeWidth: 0.6,
                      child: Container(
                        height: 60,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _imageavatar == null
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Upload image here or ',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color(0xffC3BBBB),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal),
                                        ),
                                        Text(
                                          'Browse',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.blueGrey,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      avatarname,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Color(0xffC3BBBB),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal),
                                    ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Max size file: 1mb',
                                style: TextStyle(
                                    color: Color(0xffC3BBBB),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Driver’s licence image',
                    style: TextStyle(
                        color: Color(0xffC3BBBB),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      getlicenceImage(ImgSource.Both);
                    },
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      dashPattern: [6, 6],
                      color: Color(0xff24414D),
                      radius: Radius.circular(10),
                      strokeWidth: 0.6,
                      child: Container(
                        height: 60,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _imagelicence == null
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Upload image here or ',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color(0xffC3BBBB),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal),
                                        ),
                                        Text(
                                          'Browse',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.blueGrey,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      licencename,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Color(0xffC3BBBB),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal),
                                    ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Max size file: 1mb',
                                style: TextStyle(
                                    color: Color(0xffC3BBBB),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Driver’s insurance image',
                    style: TextStyle(
                        color: Color(0xffC3BBBB),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      getinsuranceImage(ImgSource.Both);
                    },
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      dashPattern: [6, 6],
                      color: Color(0xff24414D),
                      radius: Radius.circular(10),
                      strokeWidth: 0.6,
                      child: Container(
                        height: 60,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _imageinsurance == null
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Upload image here or ',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color(0xffC3BBBB),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal),
                                        ),
                                        Text(
                                          'Browse',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.blueGrey,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      insurancename,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Color(0xffC3BBBB),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal),
                                    ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Max size file: 1mb',
                                style: TextStyle(
                                    color: Color(0xffC3BBBB),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Driver’s Vehicle Paper image',
                    style: TextStyle(
                        color: Color(0xffC3BBBB),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      getvehiclePaperImage(ImgSource.Both);
                    },
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      dashPattern: [6, 6],
                      color: Color(0xff24414D),
                      radius: Radius.circular(10),
                      strokeWidth: 0.6,
                      child: Container(
                        height: 60,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _imagevehiclePaper == null
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Upload image here or ',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color(0xffC3BBBB),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal),
                                        ),
                                        Text(
                                          'Browse',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.blueGrey,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      vehiclePaperImage,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Color(0xffC3BBBB),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal),
                                    ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Max size file: 1mb',
                                style: TextStyle(
                                    color: Color(0xffC3BBBB),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    pages = [
      page1,
      page2,
    ];

    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Color(0xffF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xffF2F2F2),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
                child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(kDashboard, (route) => false);
              },
              child: Text(
                'Skip',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            )),
          )
        ],
      ),
      body: _isInit
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xff24414D),
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Kindly fill in your details ',
                            style: TextStyle(
                                fontSize: 26,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: PageView(
                      controller: _uploadPageController,
                      onPageChanged: (index) {
                        setState(() {
                          pageIndex = index;
                        });
                      },
                      children: [...pages],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                          child: RoundedRaisedButton(
                            title: pageIndex == pages.length - 1
                                ? "Complete"
                                : "Next",
                            buttonColor: Color(0xff252529),
                            isLoading: _isLoading,
                            titleColor: Colors.white,
                            onPress: pageIndex == pages.length - 1
                                ? () async {
                                    if (_imageavatar == null) {
                                      _showShackBar(
                                          "Please upload the Driver's image");
                                      return;
                                    }
                                    if (_imagelicence == null) {
                                      _showShackBar(
                                          "Please upload the Driver's lincence image");
                                      return;
                                    }
                                    if (_imageinsurance == null) {
                                      _showShackBar(
                                          "Please upload the Driver's insurance image");
                                      return;
                                    }
                                    if (_imagevehiclePaper == null) {
                                      _showShackBar(
                                          "Please upload the Driver's vehicle paper image");
                                      return;
                                    }
                                    try {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      await Provider.of<Auth>(context,
                                              listen: false)
                                          .completeReg(
                                              make,
                                              model,
                                              year,
                                              licenceNo,
                                              issueDate,
                                              expDate,
                                              color,
                                              numberPlate,
                                              avatarImage,
                                              licenceImage,
                                              insuranceImage,
                                              vehiclePaperImage);
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      showDialog(
                                          context: context,
                                          builder: (ctx) {
                                            return AlertDialog(
                                              title: Text(
                                                "Document Submitted",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              content: Text(
                                                  "Your Info Submitted Successfully \n Pending Approval"),
                                              actions: [
                                                FlatButton(
                                                  child: Text("OK",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  color: Color(0xff24414D),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pushNamedAndRemoveUntil(
                                                            kDashboard,
                                                            (route) => false);
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                      // Navigator.of(context).pushReplacementNamed(
                                      //     KOtpScreen,
                                      //     arguments: {'phone': user.phone});
                                    } catch (error) {
                                      showDialog(
                                          context: context,
                                          builder: (ctx) {
                                            return AlertDialog(
                                              title: Text(
                                                "Error",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              content:
                                                  Text("${error.toString()}"),
                                              actions: [
                                                FlatButton(
                                                  child: Text("OK",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  color: Color(0xff24414D),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                    } finally {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    }
                                  }
                                : () {
                                    if (pageIndex < pages.length - 1) {
                                      try {
                                        validatePage(pageIndex);
                                        _uploadPageController.animateToPage(
                                          ++pageIndex,
                                          duration: Duration(microseconds: 200),
                                          curve: Curves.easeIn,
                                        );
                                      } catch (error) {}
                                    }
                                  },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
