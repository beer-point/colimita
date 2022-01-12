import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';

final mercadoPagoPROPublicKey = 'TEST-46a10478-b450-4e77-abd8-5440d9349c6d';
final mercadoPagoAPIPublicKey = 'TEST-c376ecc7-0bcb-4101-90ee-76c4b549dbf6';

final mercadoPagoLocalWebpageDefinition = '''
<!DOCTYPE html>
<html lang="en">
<head>
<title>Load file or HTML string example</title>
</head>
<body>

<h1>Local demo page</h1>
<p>
  This is an example page used to demonstrate how to load a local file or HTML 
  string using the <a href="https://pub.dev/packages/webview_flutter">Flutter 
  webview</a> plugin.
</p>

<div id="form-checkout">
  <input id="form-checkout__cardholderName"></input>
</div>

<script src="https://sdk.mercadopago.com/js/v2"></script>
<script>
// Agrega credenciales de SDK
  const mp = new MercadoPago('$mercadoPagoAPIPublicKey', {
        locale: 'es-AR'
  });


  // Inicializa el checkout
  // mp.checkout({
  //     preference: {
  //         id: '303126066-cde1d753-8083-49ee-8911-76bc01eb8acf'
  //     },
  //     render: {
  //           container: '.cho-container', // Indica el nombre de la clase donde se mostrará el botón de pago
  //           label: 'Pagar', // Cambia el texto del botón de pago (opcional)
  //     },
  //   });

MercadopagoProcessController.postMessage("HEY");
  mp.cardForm({
     amount: "100.5",
  autoMount: true,
  form: {
    id: "form-checkout",
    cardholderName: {
      id: "form-checkout__cardholderName",
      placeholder: "Titular de la tarjeta",
    },
    cardholderEmail: {
      id: "form-checkout__cardholderEmail",
      placeholder: "E-mail",
    },
    cardNumber: {
      id: "form-checkout__cardNumber",
      placeholder: "Número de la tarjeta",
    },
    cardExpirationMonth: {
      id: "form-checkout__cardExpirationMonth",
      placeholder: "Mes de vencimiento",
    },
    cardExpirationYear: {
      id: "form-checkout__cardExpirationYear",
      placeholder: "Año de vencimiento",
    },
    securityCode: {
      id: "form-checkout__securityCode",
      placeholder: "Código de seguridad",
    },
    installments: {
      id: "form-checkout__installments",
      placeholder: "Cuotas",
    },
    identificationType: {
      id: "form-checkout__identificationType",
      placeholder: "Tipo de documento",
    },
    identificationNumber: {
      id: "form-checkout__identificationNumber",
      placeholder: "Número de documento",
    },
    issuer: {
      id: "form-checkout__issuer",
      placeholder: "Banco emisor",
    },
  },
  callbacks: {
    onFormMounted: error => {
      if (error) return console.warn("Form Mounted handling error: ", error);
      MercadopagoProcessController.postMessage("Form mounted");
    },
    onSubmit: event => {
      event.preventDefault();
      MercadopagoProcessController.postMessage('Submitt')
      const {
        paymentMethodId: payment_method_id,
        issuerId: issuer_id,
        cardholderEmail: email,
        amount,
        token,
        installments,
        identificationNumber,
        identificationType,
      } = cardForm.getCardFormData();

      MercadopagoProcessController.postMessage(JSON.stringify(cardForm.getCardFormData()))

      // fetch("/process_payment", {
      //   method: "POST",
      //   headers: {
      //     "Content-Type": "application/json",
      //   },
      //   body: JSON.stringify({
      //     token,
      //     issuer_id,
      //     payment_method_id,
      //     transaction_amount: Number(amount),
      //     installments: Number(installments),
      //     description: "Descripción del producto",
      //     payer: {
      //       email,
      //       identification: {
      //         type: identificationType,
      //         number: identificationNumber,
      //       },
      //     },
      //   }),
      // });
    },
    onFetching: (resource) => {
      MercadopagoProcessController.postMessage("Fetching resource: ", resource);

      // Animate progress bar
      const progressBar = document.querySelector(".progress-bar");
      progressBar.removeAttribute("value");

      return () => {
        progressBar.setAttribute("value", "0");
      };
    },
  },
  })

MercadopagoProcessController.postMessage("HEY2");



</script>
</body>
</html>
''';

class PaymentsMercadopagoView extends StatefulWidget {
  const PaymentsMercadopagoView() : super();

  @override
  State<PaymentsMercadopagoView> createState() =>
      _PaymentsMercadopagoViewState();
}

class _PaymentsMercadopagoViewState extends State<PaymentsMercadopagoView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: add this to properties

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: WebView(
            javascriptChannels: <JavascriptChannel>{
              _processControllerJavascriptChannel()
            },

            initialUrl: 'https://www.google.com',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
              _controller.future.then((value) => value.clearCache());
              webViewController
                  .loadHtmlString(mercadoPagoLocalWebpageDefinition);
            },

            // onPageStarted: getCodeFromUrlAndNotify,
            onPageFinished: (String url) {},
            onProgress: (int progress) {
              // TODO(lg): should we show a custom loader?
              print(progress.toString());
            },

            gestureNavigationEnabled: true,
            backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
          ),
        ),
      ),
    );
  }

  JavascriptChannel _processControllerJavascriptChannel() {
    return JavascriptChannel(
        name: 'MercadopagoProcessController',
        onMessageReceived: (JavascriptMessage message) {
          print(message.message);
        });
  }
}
