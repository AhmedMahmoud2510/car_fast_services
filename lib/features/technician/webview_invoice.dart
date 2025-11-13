import 'package:quick_cars_service/barrel.dart';

class InvoiceWebViewScreen extends StatefulWidget {
  const InvoiceWebViewScreen({super.key, required this.invoiceId});
  final String invoiceId;

  @override
  State<InvoiceWebViewScreen> createState() => _InvoiceWebViewScreenState();
}

class _InvoiceWebViewScreenState extends State<InvoiceWebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() => _isLoading = true);
          },
          onPageFinished: (String url) async {
            setState(() => _isLoading = false);

            await _controller.runJavaScript('''
  // إزالة أي إعدادات سابقة للعرض
  document.querySelectorAll('meta[name="viewport"]').forEach(e => e.remove());
  // ضبط حجم الصفحة لتناسب عرض الجهاز
  var meta = document.createElement('meta');
  meta.name = "viewport";
  meta.content = "width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no";
  document.head.appendChild(meta);

  // ضبط عرض المحتوى ليلائم الشاشة بالكامل
  document.body.style.overflowX = 'hidden';
  document.documentElement.style.overflowX = 'hidden';
  document.body.style.width = '100%';
  document.documentElement.style.width = '100%';

  // تصغير تلقائي لو عرض المحتوى أكبر من الجهاز
  document.body.style.zoom = (window.innerWidth / document.body.scrollWidth);
''');

            await _controller.runJavaScript("""
              document.querySelectorAll('button, a').forEach(e => e.style.display = 'block');
            """);
          },
        ),
      )
      ..loadRequest(
        Uri.parse(
          'https://fast-service.sitksa-eg.com/mobile/maintenance-requests/print/${widget.invoiceId}',
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'invoice'.tr(),
          style: Styles.style16W600.copyWith(color: AppColors.secondaryColor),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        iconTheme: const IconThemeData(color: AppColors.secondaryColor),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
