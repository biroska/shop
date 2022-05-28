import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';

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

  final _formKey = GlobalKey<FormState>();

  final _formData = Map<String, Object>();

  @override
  void initState() {
    super.initState();
    _urlFocus.addListener(updateImage);
  }

  @override
  void dispose() {
    super.dispose();
    _urlFocus.removeListener(updateImage);
    _urlFocus.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final product = arg as Product;

        _formData['id'] = product.id;
        _formData['name'] = product.name;
        _formData['price'] = product.price;
        _formData['description'] = product.description;
        _formData['imageUrl'] = product.imageUrl;

        _urlController.text = product.imageUrl;
      }
    }
  }

  void updateImage() {
    setState(() {});
  }

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    String rulLowCase = url.toLowerCase();

    bool endsWithFile = rulLowCase.endsWith('.png') ||
        rulLowCase.endsWith('.jpg') ||
        rulLowCase.endsWith('.jpeg');

    return isValidUrl && endsWithFile;
  }

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    Provider.of<ProductList>(context, listen: false).saveProduct(_formData);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário Produtos'),
        actions: [
          IconButton(onPressed: _submitForm, icon: const Icon(Icons.save)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  initialValue: _formData['name']?.toString(),
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocus);
                  },
                  onSaved: (name) => _formData['name'] = name ?? '',
                  validator: (_name) {
                    final name = _name ?? '';
                    if (name.trim().isEmpty) {
                      return 'Nome é obrigatório';
                    }
                    if (name.trim().length < 3) {
                      return 'Nome precisa no mínimo 3 letras';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: _formData['price']?.toString(),
                  decoration: const InputDecoration(
                    labelText: 'Preço',
                  ),
                  focusNode: _priceFocus,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  textInputAction: TextInputAction.next,
                  onSaved: (price) =>
                      _formData['price'] = double.parse(price ?? '0'),
                  validator: (_price) {
                    final priceString = _price ?? '';
                    final price = double.tryParse(priceString) ?? -1;
                    if (price <= 0) {
                      return 'Informe um preço válido';
                    }
                    return null;
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocus);
                  },
                ),
                TextFormField(
                  initialValue: _formData['description']?.toString(),
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  focusNode: _descriptionFocus,
                  textInputAction: TextInputAction.next,
                  onSaved: (description) =>
                      _formData['description'] = description ?? '',
                  validator: (_name) {
                    final name = _name ?? '';
                    if (name.trim().isEmpty) {
                      return 'Descrição é obrigatória';
                    }
                    if (name.trim().length < 10) {
                      return 'Descrição precisa no mínimo 10 letras';
                    }
                    return null;
                  },
                ),
                Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Expanded(
                    child: TextFormField(
                      controller: _urlController,
                      decoration: const InputDecoration(
                        labelText: 'URL da Imagem',
                      ),
                      keyboardType: TextInputType.url,
                      focusNode: _urlFocus,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _submitForm(),
                      onSaved: (url) => _formData['url'] = url ?? '',
                      validator: (_url) {
                        String url = _url ?? '';
                        if (!isValidImageUrl(url)) {
                          return 'Informe uma url válida';
                          // https://uploads.metropoles.com/wp-content/uploads/2021/06/09110407/cachorro-fofo-usando-oculos_23-2148917262-1-600x380.jpg
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.only(top: 10, left: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1)),
                    alignment: Alignment.center,
                    child: _urlController.text.isEmpty
                        ? const Text('Informe a url')
                        : Container(
                            width: 100,
                            height: 100,
                            child: FittedBox(
                              child: Image.network(_urlController.text),
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ]),
              ],
            )),
      ),
    );
  }
}
