import 'dart:async';
import 'Model.dart';
import 'package:mysql1/mysql1.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static MySqlConnection _databaseConnection;

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<MySqlConnection> get databaseConnection async {
    try {
      var host = '<ip address>'; //e.g. 196.70.125.43
      var user = '<user name>';
      var db = '<db name>';
      var password = '';

      assert(host != '<ip address>');

      _databaseConnection = await MySqlConnection.connect(ConnectionSettings(
          host: host, port: 3306, user: user, db: db, password: password));
    } catch (e) {
      print(e.toString());
      rethrow;
    }
    return _databaseConnection;
  }

  Future<void> insertContact(Contact contact) async {
    MySqlConnection connection = await this.databaseConnection;

    if (connection != null) {
      try {
        await connection.query(
            'insert into Contacts (Name, Address, Phone, Phone_mobile, Email, Notes) values (?, ?, ?, ?, ?, ?)',
            [
              contact.name,
              contact.address,
              contact.homePhone,
              contact.mobilePhone,
              contact.email,
              contact.notes
            ]);
        connection.close();
      } catch (e) {
        print(e.toString());
        rethrow;
      }
    }
  }

  Future<int> updateContact(Contact contact) async {
    MySqlConnection connection = await this.databaseConnection;

    if (connection != null) {
      try {
        // Update query format is: Update <table> Set Address = 'New Address', Zip = 'New Zip' where Name is 'Pete'
        String queryString =
            "update Contacts set Address = '${contact.address}', Phone = '${contact.homePhone}', Phone_mobile = '${contact.mobilePhone}', Email = '${contact.email}', Notes = '${contact.notes}' where name = '${contact.name}'";
        await connection.query(queryString);
        connection.close();
      } catch (e) {
        print(e.toString());
      }
    }
    return 0;
  }

  Future<void> deleteContact(Contact contact) async {
    MySqlConnection connection = await this.databaseConnection;

    if (connection != null) {
      try {
        // Delete also requires quotes around strings
        String queryString =
            "delete from Contacts where name = '${contact.name}'";
        await connection.query(queryString);
        connection.close();
      } catch (e) {
        print(e.toString());
        rethrow;
      }
    }
  }

  Future<List<Contact>> getContactsList() async {
    MySqlConnection connection = await this.databaseConnection;

    List<Contact> listResults = [];

    if (connection != null) {
      Results results = await connection.query(
          'select Name, Address, Phone, Phone_mobile, Email, Notes from Contacts order by Name');

      connection.close();

      for (var row in results) {
        listResults
            .add(Contact(row[0], row[1], row[2], row[3], row[4], row[5]));
      }
    }
    return listResults;
  }
}
