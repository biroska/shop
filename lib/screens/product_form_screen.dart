import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductFormScreen extends StatefulWidget {
  const ProductFormScreen({Key? key}) : super(key: key);

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  // Manipulando o manualmente o foco dos inputs
  final _urlFocus = FocusNode();
  final _urlController = TextEditingController();
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _urlFocus.addListener( updateImage );
  }

  @override
  void dispose() {
    super.dispose();
    _urlFocus.dispose();
    _urlFocus.removeListener( updateImage );
    _priceFocus.dispose();
    _descriptionFocus.dispose();
  }

  void updateImage() {
    setState(() {});
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Formulário Produtos'),
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
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_priceFocus);
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Preço',
                    ),
                    focusNode: _priceFocus,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_descriptionFocus);
                    },
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
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _urlController,
                            decoration: const InputDecoration(
                              labelText: 'URL da Imagem',
                            ),
                            keyboardType: TextInputType.url,
                            focusNode: _urlFocus,
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                        Container(
                          height: 100, width: 100,
                          margin: const EdgeInsets.only(
                              top:  10,
                              left: 10
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey,
                                  width: 1
                              )
                          ),
                          alignment: Alignment.center,
                          child: _urlController.text.isEmpty ? const Text('Informe a url') : FittedBox(
                            child: Image.network(_urlController.text),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ]),
                ],
              )),
        ),
      );
    }
}
