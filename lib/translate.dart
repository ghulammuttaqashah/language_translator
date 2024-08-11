import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LanguageTranslator extends StatefulWidget {
  const LanguageTranslator({super.key});

  @override
  State<LanguageTranslator> createState() => _LanguageTranslatorState();
}

class _LanguageTranslatorState extends State<LanguageTranslator> {
  var languages = ["Urdu", "English", "Sindhi"];
  var originLanguage = "From";
  var destinationLanguage = "To";
  var output = "";
  TextEditingController language = TextEditingController();

  void translate(String src, String dst, String input) async {
    GoogleTranslator translator = GoogleTranslator();
    var translation = await translator.translate(input, from: src, to: dst);
    setState(() {
      output = translation.text.toString();
    });
    if (src == "--" || dst == "--") {
      setState(() {
        output = "Failed to translate.";
      });
    }
  }

  String getLanguageCode(String language) {
    if (language == "English") {
      return "en";
    } else if (language == "Urdu") {
      return "ur";
    } else if (language == "Sindhi") {
      return "sd";
    }
    return "--";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff10223d),
      appBar: AppBar(
        title: Text(
          "Language Translator",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff10223d),
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        focusColor: Colors.white,
                        iconDisabledColor: Colors.white,
                        iconEnabledColor: Colors.white,
                        hint: Text(
                          originLanguage,
                          style: TextStyle(color: Colors.white),
                        ),
                        dropdownColor: Colors.white,
                        icon: Icon(Icons.keyboard_arrow_down),
                        items: languages.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            child: Text(dropDownStringItem),
                            value: dropDownStringItem,
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            originLanguage = value!;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Icon(
                      Icons.arrow_right_alt_outlined,
                      color: Colors.white,
                      size: 40.0,
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        focusColor: Colors.white,
                        iconDisabledColor: Colors.white,
                        iconEnabledColor: Colors.white,
                        hint: Text(
                          destinationLanguage,
                          style: TextStyle(color: Colors.white),
                        ),
                        dropdownColor: Colors.white,
                        icon: Icon(Icons.keyboard_arrow_down),
                        items: languages.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            child: Text(dropDownStringItem),
                            value: dropDownStringItem,
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            destinationLanguage = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: TextFormField(
                  maxLength: 200,
                  cursorColor: Colors.white,
                  autofocus: false,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Please Enter Your Text",
                    labelStyle: TextStyle(fontSize: 15.0, color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1),
                    ),
                    counterStyle: TextStyle(
                      color: Colors
                          .white, // Change color of the character counter text
                      fontSize:
                          14.0, // Change the font size of the counter text
                    ),
                    errorStyle: TextStyle(color: Colors.red, fontSize: 15),
                  ),
                  controller: language,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter text to translate";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff2b3c5a),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0))),
                  onPressed: () {
                    translate(
                      getLanguageCode(originLanguage),
                      getLanguageCode(destinationLanguage),
                      language.text.toString(),
                    );
                  },
                  child: Text(
                    "Translate",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 15.0),
                  child: Center(
                    child: Text(
                      "\n$output",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
