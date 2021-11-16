import 'dart:async';

import 'package:flutter/material.dart';
import 'package:publico/presentation/pages/admin/edit/edit_sources_page.dart';
import 'package:publico/presentation/widgets/primary_button.dart';
import 'package:publico/styles/colors.dart';
import 'package:publico/styles/text_styles.dart';

class InfographicEditPage extends StatefulWidget {
  static const routeName = '/admin-infographic-edit';
  final String postId;
  const InfographicEditPage({Key? key, required this.postId}) : super(key: key);

  @override
  _InfographicEditPageState createState() => _InfographicEditPageState();
}

class _InfographicEditPageState extends State<InfographicEditPage> {
  final _titleController = TextEditingController();
  List sources = [];
  String? selectedTheme;
  bool isValidate = false;

  void formCheck() {
    if (_titleController.text.isNotEmpty &&
        sources.isNotEmpty &&
        selectedTheme != null) {
      if (isValidate) {
        return;
      } else {
        setState(() {
          isValidate = true;
        });
      }
    } else {
      setState(() {
        isValidate = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kRichWhite,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: kRichBlack,
            size: 20,
          ),
        ),
        title: Text(
          'Tambah Infografis',
          style: kTextTheme.subtitle1!.copyWith(
            fontSize: 16,
            color: kRichBlack,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '   Tema',
                style: kTextTheme.caption!.copyWith(
                  color: kMikadoOrange,
                ),
              ),
              DropdownButtonFormField(
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                items: List.generate(
                  1,
                  (dropdownData) => DropdownMenuItem(
                    child: Text(
                      '$dropdownData',
                      style: kTextTheme.bodyText2!.copyWith(
                        color: kMikadoOrange,
                      ),
                    ),
                    value: dropdownData,
                    onTap: () {
                      selectedTheme = dropdownData.toString();
                      formCheck();
                    },
                  ),
                ).toList(),
                isDense: true,
                dropdownColor: kLightGrey2,
                elevation: 0,
                iconEnabledColor: kMikadoOrange,
                autofocus: false,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: kMikadoOrange,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                ),
                onChanged: (value) {},
                hint: Text(
                  'Pilih Tema',
                  style: kTextTheme.bodyText2!.copyWith(
                    color: kGrey,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                '   Judul',
                style: kTextTheme.caption!.copyWith(
                  color: kMikadoOrange,
                ),
              ),
              TextField(
                controller: _titleController,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'Masukkan judul',
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: kMikadoOrange,
                    ),
                  ),
                ),
                onChanged: (value) {
                  Timer(const Duration(milliseconds: 750), () {
                    formCheck();
                  });
                },
                style: kTextTheme.bodyText2!.copyWith(
                  color: kRichBlack,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                '   Sumber',
                style: kTextTheme.caption!.copyWith(
                  color: kMikadoOrange,
                ),
              ),
              Column(
                children: sources
                    .map(
                      (source) => TextField(
                        readOnly: true,
                        onTap: () {},
                        controller: TextEditingController(
                          text: source,
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: kMikadoOrange,
                            ),
                          ),
                        ),
                        style: kTextTheme.bodyText2!.copyWith(
                          color: kRichBlack,
                        ),
                      ),
                    )
                    .toList(),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    EditSourcesPage.routeName,
                    arguments: 'secret',
                  );
                },
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: const BorderSide(
                    color: kMikadoOrange,
                  ),
                ),
                child: SizedBox(
                  height: 45,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add, color: kMikadoOrange, size: 16),
                      Text(
                        ' Tambah Sumber',
                        style: kTextTheme.button!,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              PrimaryButton(
                borderRadius: 10,
                child: SizedBox(
                  height: 45,
                  child: Center(
                    child: Text(
                      'Simpan',
                      style: kTextTheme.button!.copyWith(
                        color: kRichWhite,
                      ),
                    ),
                  ),
                ),
                onPressed: !isValidate ? null : () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}