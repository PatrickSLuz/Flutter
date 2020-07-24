import 'package:flutter/material.dart';
import 'package:gerenciar_loja_virtual/products/widgets/image_source_sheet.dart';

class ImagesWidget extends FormField<List> {
  ImagesWidget({
    BuildContext context,
    FormFieldSetter<List> onSaved,
    FormFieldValidator<List> validator,
    List initialValue,
    bool autoValidate = false,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          autovalidate: autoValidate,
          builder: (state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 16, bottom: 8),
                  height: 124,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: state.value.map<Widget>((img) {
                      return Container(
                        margin: const EdgeInsets.only(right: 8),
                        height: 100,
                        width: 100,
                        child: GestureDetector(
                          child: img is String
                              ? Image.network(img, fit: BoxFit.cover)
                              : Image.file(img, fit: BoxFit.cover),
                          onLongPress: () {
                            state.didChange(state.value..remove(img));
                          },
                        ),
                      );
                    }).toList()
                      ..add(
                        GestureDetector(
                          child: Container(
                            color: Colors.white.withAlpha(50),
                            height: 100,
                            width: 100,
                            child: Icon(Icons.add_a_photo, color: Colors.white),
                          ),
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => ImageSourceSheet(
                                onImageSelected: (image) {
                                  state.didChange(state.value..add(image));
                                  Navigator.of(context).pop();
                                },
                              ),
                            );
                          },
                        ),
                      ),
                  ),
                ),
                state.hasError
                    ? Text(
                        state.errorText,
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      )
                    : Container()
              ],
            );
          },
        );
}
