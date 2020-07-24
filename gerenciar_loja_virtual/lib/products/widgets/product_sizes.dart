import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerenciar_loja_virtual/products/widgets/add_size_dialog.dart';

class ProductSizes extends FormField<List> {
  ProductSizes({
    BuildContext context,
    List initialValue,
    FormFieldSetter<List> onSaved,
    FormFieldValidator<List> validator,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          builder: (state) {
            return SizedBox(
              height: 34,
              child: GridView(
                padding: const EdgeInsets.symmetric(vertical: 4),
                scrollDirection: Axis.horizontal,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.5,
                ),
                children: state.value.map<Widget>((size) {
                  return GestureDetector(
                    onLongPress: () {
                      state.didChange(state.value..remove(size));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        border: Border.all(
                          color: Colors.pinkAccent,
                          width: 3,
                        ),
                      ),
                      child: Text(
                        size,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                }).toList()
                  ..add(
                    GestureDetector(
                      onTap: () async {
                        String size = await showDialog(
                          context: context,
                          builder: (context) => AddSizeDialog(),
                        );
                        if (size != null) {
                          state.didChange(state.value..add(size));
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          border: Border.all(
                            color:
                                state.hasError ? Colors.red : Colors.pinkAccent,
                            width: 3,
                          ),
                        ),
                        child: Text(
                          "+",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
              ),
            );
          },
        );
}
