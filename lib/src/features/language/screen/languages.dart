import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc/language_bloc.dart';
import '../bloc/bloc/language_event.dart';
import '../bloc/bloc/language_state.dart';
// import 'package:libraryapp/src/features/language/bloc/index.dart';

languageModal(context) {
  List options = [
    {"name": "ខ្មែរ", "code": Language.KH},
    {"name": "English", "code": Language.EN}
  ];
  int index = 0;

  return showCupertinoModalPopup(
    context: context,
    builder: (context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color(0xffffffff),
              border: Border(
                bottom: BorderSide(
                  color: Color(0xff999999),
                  width: 0.0,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CupertinoButton(
                  child: Text("Cancel"
                      // AppLocalizations.of(context).translate("cancel"),
                      ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 5.0,
                  ),
                ),
                CupertinoButton(
                  child: Text("Confirm"
                      // AppLocalizations.of(context).translate("confirm"),
                      ),
                  onPressed: () {
                    BlocProvider.of<LanguageBloc>(context)
                      ..add(
                        LanguageSeleted(options[index]["code"]),
                      );
                    Navigator.of(context).pop();
                  },
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 5.0,
                  ),
                )
              ],
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height / 3,
              color: Color(0xfff7f7f7),
              child: CupertinoPicker(
                itemExtent: 50,
                children: options
                    .map((option) => Center(
                          child: Text(option["name"]),
                        ))
                    .toList(),
                onSelectedItemChanged: (indexx) {
                  index = indexx;

                  // BlocProvider.of<AddressFormBloc>(context).add(SelectDistrict(
                  //     district: BlocProvider.of<AddressFormBloc>(context)
                  //         .districts[index]));
                },
              ))
        ],
      );
    },
  );
}