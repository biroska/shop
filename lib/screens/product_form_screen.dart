import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductFormScreen extends StatefulWidget {
  const ProductFormScreen({Key? key}) : super(key: key);

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {

  // Manipulando o manualmente o foco dos inputs
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário Produtos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
            child: ListView(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nome',
              ),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_){ FocusScope.of(context).requestFocus( _priceFocus ); },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Preço',
              ),
              focusNode: _priceFocus,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_){ FocusScope.of(context).requestFocus( _descriptionFocus ); },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Descrição',
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              focusNode: _descriptionFocus,
              textInputAction: TextInputAction.next,
            ),
          ],
        )),
      ),
    );
  }
}
