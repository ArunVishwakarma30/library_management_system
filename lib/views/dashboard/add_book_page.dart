import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:library_management_system/controllers/menu_provider.dart';
import 'package:library_management_system/models/req_models/upload_book_req_model.dart';
import 'package:library_management_system/views/common/app_style.dart';
import 'package:provider/provider.dart';

class AddBook extends StatefulWidget {
  const AddBook({Key? key}) : super(key: key);

  @override
  _AddBookState createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  // TextEditingController for each input field
  TextEditingController _bookNameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _authorNameController = TextEditingController();
  TextEditingController _coverImageController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();
  TextEditingController _publishYearController = TextEditingController();
  TextEditingController _publisherController = TextEditingController();
  TextEditingController _editionController = TextEditingController();
  TextEditingController _pageCountController = TextEditingController();

  String _selectedLanguage = 'English';
  String _selectedSemesterCategory = 'First Semester';

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuProvider>(
        builder: (context, menuProvider, child) => Scaffold(
              appBar: AppBar(
                title: Text('Add Book'),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _bookNameController,
                        style: roundFont(18, Colors.black, FontWeight.normal),
                        decoration: InputDecoration(
                          labelText: 'Book Name',
                          labelStyle:
                              roundFont(18, Colors.black, FontWeight.normal),
                        ),
                      ),
                      TextFormField(
                        controller: _descriptionController,
                        style: roundFont(18, Colors.black, FontWeight.normal),
                        decoration: InputDecoration(
                          labelText: 'Description',
                          labelStyle:
                              roundFont(18, Colors.black, FontWeight.normal),
                        ),
                      ),
                      TextFormField(
                        controller: _authorNameController,
                        style: roundFont(18, Colors.black, FontWeight.normal),
                        decoration: InputDecoration(
                          labelText: 'Author Name',
                          labelStyle:
                              roundFont(18, Colors.black, FontWeight.normal),
                        ),
                      ),
                      TextFormField(
                        controller: _coverImageController,
                        style: roundFont(18, Colors.black, FontWeight.normal),
                        decoration: InputDecoration(
                          labelText: 'Cover Image URL',
                          labelStyle:
                              roundFont(18, Colors.black, FontWeight.normal),
                        ),
                      ),
                      TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: _quantityController,
                        keyboardType: TextInputType.number,
                        style: roundFont(18, Colors.black, FontWeight.normal),
                        decoration: InputDecoration(
                          labelText: 'Quantity',
                          labelStyle:
                              roundFont(18, Colors.black, FontWeight.normal),
                        ),
                      ),
                      TextFormField(
                        controller: _publishYearController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        style: roundFont(18, Colors.black, FontWeight.normal),
                        decoration: InputDecoration(
                          labelText: 'Publish Year',
                          labelStyle:
                              roundFont(18, Colors.black, FontWeight.normal),
                        ),
                      ),
                      TextFormField(
                        controller: _publisherController,
                        style: roundFont(18, Colors.black, FontWeight.normal),
                        decoration: InputDecoration(
                          labelText: 'Publisher',
                          labelStyle:
                              roundFont(18, Colors.black, FontWeight.normal),
                        ),
                      ),
                      TextFormField(
                        controller: _editionController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        style: roundFont(18, Colors.black, FontWeight.normal),
                        decoration: InputDecoration(
                          labelText: 'Edition',
                          labelStyle:
                              roundFont(18, Colors.black, FontWeight.normal),
                        ),
                      ),
                      TextFormField(
                        controller: _pageCountController,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        style: roundFont(18, Colors.black, FontWeight.normal),
                        decoration: InputDecoration(
                          labelText: 'Page Count',
                          labelStyle:
                              roundFont(18, Colors.black, FontWeight.normal),
                        ),
                      ),
                      DropdownButtonFormField<String>(
                        value: _selectedLanguage,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedLanguage = newValue!;
                          });
                        },
                        items: <String>[
                          'English',
                          'Hindi',
                          'Sanskrit',
                          'Marathi'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style: roundFont(
                                    18, Colors.black, FontWeight.normal)),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelStyle:
                              roundFont(18, Colors.black, FontWeight.normal),
                        ),
                      ),
                      DropdownButtonFormField<String>(
                        value: _selectedSemesterCategory,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedSemesterCategory = newValue!;
                          });
                        },
                        items: <String>[
                          'First Semester',
                          'Second Semester',
                          'Third Semester',
                          'Fourth Semester',
                          'Fifth Semester',
                          'Sixth Semester'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,
                                  style: roundFont(
                                      18, Colors.black, FontWeight.normal)));
                        }).toList(),
                        decoration: InputDecoration(
                          labelStyle:
                              roundFont(18, Colors.black, FontWeight.normal),
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          menuProvider.setWaiting(true);
                          UploadBookReqModel model = UploadBookReqModel(
                              bookName: _bookNameController.text,
                              bookDescription: _descriptionController.text,
                              authorName: _authorNameController.text,
                              coverImage: _coverImageController.text,
                              quantity: int.parse(_quantityController.text),
                              available: int.parse(_quantityController.text),
                              publishYear:
                                  int.parse(_publishYearController.text),
                              publisher: _publisherController.text,
                              language: _selectedLanguage.toString(),
                              edition: _editionController.text,
                              pageCount: _pageCountController.text,
                              semCategoty:
                                  _selectedSemesterCategory.toString());
                          menuProvider.uploadBook(model);
                        },
                        child: menuProvider.waiting ? const CircularProgressIndicator() :  Text(
                          'Add Book',
                          style: roundFont(18, Colors.black, FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  @override
  void dispose() {
    // Dispose controllers
    _bookNameController.dispose();
    _descriptionController.dispose();
    _authorNameController.dispose();
    _coverImageController.dispose();
    _quantityController.dispose();
    _publishYearController.dispose();
    _publisherController.dispose();
    _editionController.dispose();
    _pageCountController.dispose();
    super.dispose();
  }
}
