class Constants {

  static const API_KEY = 'AIzaSyBwKs3o7rwCxaT1V7QElEMCtAuI_0h7xzI';

  static const PRODUCT_BASE_URL = 'https://shop-flutter-b913d-default-rtdb.firebaseio.com/produtos';
  static const PEDIDOS_BASE_URL = 'https://shop-flutter-b913d-default-rtdb.firebaseio.com/pedidos';

  static const _AUTH_BASE_URL = 'https://identitytoolkit.googleapis.com/v1/accounts:';
  static const AUTH_FUNCTION_URL = 'https://identitytoolkit.googleapis.com/v1/accounts:@{function}?key=${API_KEY}';
  static const SIGNUP_BASE_URL = '${_AUTH_BASE_URL}signUp?key=${API_KEY}';
  static const SIGNIN_BASE_URL = '${_AUTH_BASE_URL}signInWithPassword?key=${API_KEY}';

  static const PRODUCT_URL = PRODUCT_BASE_URL + '.json';
  static const PEDIDOS_URL = PEDIDOS_BASE_URL + '.json';
}