import 'package:address_book/Data/Model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ContactDetail extends StatefulWidget {
  final String _appBarTitle;
  final Contact _contact;

  ContactDetail(this._contact, this._appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return ContactDetailState(this._contact, this._appBarTitle);
  }
}

class ContactDetailState extends State<ContactDetail> {
  Model _model = Model();

  final String _appBarTitle;
  Contact _contact;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _mobilePhoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _mobilePhoneFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _notesFocus = FocusNode();

  ContactDetailState(this._contact, this._appBarTitle);

  @override
  void initState() {
    super.initState();

    if (_appBarTitle == "Edit Contact") {
      _nameController.text = _contact.name;
      _phoneController.text = _contact.homePhone;
      _mobilePhoneController.text = _contact.mobilePhone;
      _addressController.text = _contact.address;
      _emailController.text = _contact.email;
      _notesController.text = _contact.notes;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _mobilePhoneController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _notesController.dispose();

    _nameFocus.dispose();
    _phoneFocus.dispose();
    _mobilePhoneFocus.dispose();
    _emailFocus.dispose();
    _addressFocus.dispose();
    _notesFocus.dispose();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return WillPopScope(
      onWillPop: () {
        // For when user presses Back navigation button in device navigationBar (Android)
        _returnToHomePage(false);
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            _appBarTitle,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                _returnToHomePage(false);
              }),
        ),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                child: ListView(
                  children: <Widget>[
                    // Name
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 30.0, bottom: 15.0, left: 6.0, right: 6.0),
                      child: TextFormField(
                        controller: _nameController,
                        autocorrect: false,
                        textInputAction: TextInputAction.next,
                        focusNode: _nameFocus,
                        enabled: (_appBarTitle ==
                            'Add Contact'), // name is the key. can't change it. must delete and re-create.
                        onFieldSubmitted: (term) {
                          _nameFocus.unfocus();
                          FocusScope.of(context).requestFocus(_phoneFocus);
                        },
                        onSaved: (String value) {
                          print("OnSaved: $value");
                          _contact.name = value;
                        },
                        validator: (String value) {
                          _contact.name = _nameController.text;
                          if (value.isEmpty) {
                            return 'Gotta have a name';
                          } else if (value.length > 79) {
                            return 'Name must be less than 80 characters';
                          }
                        },
                        style: textStyle,
                        decoration: _inputDecoration(textStyle, "Name"),
                      ),
                    ),
                    // Home and Mobile Phones
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 170,
                          height: 50,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(bottom: 15.0, left: 6.0),
                            child: TextFormField(
                              controller: _phoneController,
                              //keyboardType: TextInputType.number,
                              autocorrect: false,
                              textInputAction: TextInputAction.next,
                              focusNode: _phoneFocus,
                              onFieldSubmitted: (term) {
                                _phoneFocus.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(_mobilePhoneFocus);
                              },
                              style: textStyle,
                              validator: (String value) {
                                _contact.homePhone = _phoneController.text;
                                if (value.length > 29) {
                                  return "Phone numbers must be less than 30 characters";
                                }
                              },
                              decoration:
                                  _inputDecoration(textStyle, "Home Phone"),
                            ),
                          ),
                        ),
                        Container(
                          width: 170,
                          height: 50,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(bottom: 15.0, right: 6.0),
                            child: TextFormField(
                              controller: _mobilePhoneController,
                              //keyboardType: TextInputType.phone,
                              autocorrect: false,
                              textInputAction: TextInputAction.next,
                              focusNode: _mobilePhoneFocus,
                              onFieldSubmitted: (term) {
                                _mobilePhoneFocus.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(_emailFocus);
                              },
                              style: textStyle,
                              validator: (String value) {
                                _contact.mobilePhone =
                                    _mobilePhoneController.text;
                                if (value.length > 29) {
                                  return "Phone numbers must be less than 30 characters";
                                }
                              },
                              decoration:
                                  _inputDecoration(textStyle, "Mobile Phone"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Email
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 30.0, bottom: 15.0, left: 6.0, right: 6.0),
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        textInputAction: TextInputAction.next,
                        focusNode: _emailFocus,
                        onFieldSubmitted: (term) {
                          _emailFocus.unfocus();
                          FocusScope.of(context).requestFocus(_addressFocus);
                        },
                        validator: (String value) {
                          _contact.email = _emailController.text;
                          if (value.length > 59) {
                            return 'Email must be less than 60 characters';
                          }
                        },
                        style: textStyle,
                        decoration: _inputDecoration(textStyle, "Email"),
                      ),
                    ),
                    // Address
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15.0, left: 6.0, right: 6.0),
                      child: TextFormField(
                        controller: _addressController,
                        autocorrect: false,
                        maxLines: 3,
                        textInputAction: TextInputAction.newline,
                        focusNode: _addressFocus,
                        onEditingComplete: () {
                          _addressFocus.unfocus();
                          FocusScope.of(context).requestFocus(_notesFocus);
                        },
                        validator: (String value) {
                          _contact.address = _addressController.text;
                          if (value.length > 254) {
                            return 'Address must be less than 255 characters';
                          }
                        },
                        style: textStyle,
                        decoration: _inputDecoration(textStyle, "Address"),
                      ),
                    ),
                    // Notes
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15.0, left: 6.0, right: 6.0),
                      child: TextFormField(
                        controller: _notesController,
                        autocorrect: false,
                        maxLines: 3,
                        textInputAction: TextInputAction.newline,
                        focusNode: _notesFocus,
                        onFieldSubmitted: (term) {
                          _notesFocus.unfocus();
                          //FocusScope.of(context).requestFocus(_nameFocus);
                        },
                        validator: (String value) {
                          _contact.notes = _notesController.text;
                          if (value.length > 254) {
                            return 'Notes must be less than 255 characters';
                          }
                        },
                        style: textStyle,
                        decoration: _inputDecoration(textStyle, "Notes"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                      child: RaisedButton(
                        color: Theme.of(context).accentColor,
                        textColor: Theme.of(context).primaryColorDark,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Text(
                          'Save',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            if (_formKey.currentState.validate()) {
                              _saveorUpdateContact();
                            }
                          });
                        },
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

  InputDecoration _inputDecoration(TextStyle textStyle, String text) {
    return InputDecoration(
        labelText: text,
        labelStyle: textStyle,
        errorStyle: TextStyle(color: Colors.yellowAccent, fontSize: 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)));
  }

  void _saveorUpdateContact() async {
    if (_appBarTitle != "Add Contact") {
      try {
        await _model.updateContact(_contact);
        _returnToHomePage(true);
      } catch (e) {
        print(e);
        showAlertDialog(context, 'Status', 'Error updating contact.');
      }
    } else {
      try {
        await _model.insertContact(_contact);
        _returnToHomePage(true);
      } catch (e) {
        print(e);
        showAlertDialog(context, 'Status', 'Error adding contact.');
      }
    }
  }

  void _returnToHomePage(bool refreshListDisplay) {
    Navigator.pop(context, refreshListDisplay);
  }
}

void showAlertDialog(BuildContext context, String title, String message) {
  AlertDialog alertDialog = AlertDialog(
    title: Text(title),
    content: Text(message),
  );
  showDialog(context: context, builder: (_) => alertDialog);
}
