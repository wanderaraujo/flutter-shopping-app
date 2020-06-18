import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/Product.dart';
import 'package:shop/providers/products.dart';

class ProductFormScreen extends StatefulWidget {
  @override
  _ProductFormScreenState createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  bool _isLoading = false;

  void changeLoading(bool load) {
    setState(() {
      _isLoading = load;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final product = ModalRoute.of(context).settings.arguments as Product;

      if (product != null) {
        _formData['id'] = product.id;
        _formData['title'] = product.title;
        _formData['description'] = product.description;
        _formData['price'] = product.price;
        _formData['imageUrl'] = product.imageUrl;

        _imageUrlController.text = _formData['imageUrl'];
      } else {
        _formData['price'] = '';
      }
    }
  }

  void _updateImage() {
    if (isValidImageUrl(_imageUrlController.text)) {
      setState(() {});
    }
  }

  bool isValidImageUrl(String url) {
    bool startWithHttp = url.toLowerCase().startsWith("http://");
    bool startWithHttps = url.toLowerCase().startsWith("https://");
    bool endsWithImagePNG = url.toLowerCase().endsWith(".jpg");
    bool endsWithImageJPG = url.toLowerCase().endsWith(".png");
    bool endsWithImageJPEG = url.toLowerCase().endsWith(".png");

    return (startWithHttp || startWithHttps) &&
        (endsWithImagePNG || endsWithImageJPG || endsWithImageJPEG);
  }

  Future<void> _saveForm() async {
    if (!_form.currentState.validate()) {
      return;
    }

    _form.currentState.save();
    final product = Product(
      id: _formData['id'],
      title: _formData['title'],
      description: _formData['description'],
      price: _formData['price'],
      imageUrl: _formData['imageUrl'],
    );

    changeLoading(true);

    final products = Provider.of<Products>(context, listen: false);
    try {
      if (_formData['id'] == null) {
        await products.addProduct(product);
      } else {
        await products.updateProduct(product);
      }
      Navigator.of(context).pop();
    } catch (e) {
      await showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Ocorreu um erro!"),
          content: Text("Ocorreu um erro ao salvar o produto!"),
          actions: <Widget>[
            FlatButton(
              child: Text("Ok"),
              onPressed: () {
                changeLoading(false);
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
    } finally {
      changeLoading(false);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _descriptionFocusNode.removeListener(_updateImage);
    _imageUrlFocusNode.dispose();
  }

  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_updateImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulário Produto"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveForm();
            },
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _formData['title'],
                      decoration: InputDecoration(labelText: "Título"),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      onSaved: (value) => _formData['title'] = value,
                      validator: (value) {
                        if (value.trim().isEmpty) {
                          return 'Informe um titulo';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['price'].toString(),
                      decoration: InputDecoration(labelText: "Preço"),
                      textInputAction: TextInputAction.next,
                      focusNode: _priceFocusNode,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      onSaved: (value) =>
                          _formData['price'] = double.parse(value),
                      validator: (value) {
                        bool isEmpty = value.trim().isEmpty;
                        var newPrice = double.tryParse(value);
                        bool isInvalid = newPrice == null || newPrice <= 0;

                        if (isEmpty || isInvalid) {
                          return 'Informe um valor válido';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['description'],
                      decoration: InputDecoration(labelText: "Descrição"),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.next,
                      onSaved: (value) => _formData['description'] = value,
                      validator: (value) {
                        bool isEmpty = value.trim().isEmpty;
                        int qtd = 5;
                        // bool qtdIsValid = value.trim().length < qtd;

                        if (isEmpty) {
                          return 'Descrição não pode ser em branco';
                        }

                        // if (qtd > 0 && !qtdIsValid) {
                        //   return 'Descrição menor que ${qtd.toString()} caracteres';
                        // }
                        return null;
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            decoration:
                                InputDecoration(labelText: "Url da Imagem"),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            focusNode: _imageUrlFocusNode,
                            controller: _imageUrlController,
                            onSaved: (value) => _formData['imageUrl'] = value,
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            validator: (value) {
                              if (value.trim().isEmpty ||
                                  !isValidImageUrl(value.trim())) {
                                return 'Informe uma url valida';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          margin: EdgeInsets.only(top: 8, left: 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          )),
                          alignment: Alignment.center,
                          child: _imageUrlController.text.isEmpty
                              ? Text("Infome a URL")
                              : Image.network(
                                  _imageUrlController.text,
                                  fit: BoxFit.cover,
                                ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
