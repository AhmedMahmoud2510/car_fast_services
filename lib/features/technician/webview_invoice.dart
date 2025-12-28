// ignore_for_file: deprecated_member_use

import 'package:http/http.dart' as http;
import 'package:printing/printing.dart';
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

  // الرابط الخاص بالفاتورة
  String get invoiceUrl =>
      'https://fast-service.sitksa-eg.com/mobile/maintenance-requests/print/${widget.invoiceId}';

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) => setState(() => _isLoading = true),
          onPageFinished: (String url) async {
            setState(() => _isLoading = false);
            // تحسين العرض للموبايل (الكود الخاص بك)
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
          },
        ),
      )
      ..loadRequest(Uri.parse(invoiceUrl));
  }

  // Future<void> _handlePdfAction() async {
  //   setState(() => _isLoading = true);

  //   try {
  //     // 1. استخراج الـ HTML من الـ WebView
  //     final String rawHtml =
  //         await _controller.runJavaScriptReturningResult(
  //               'document.documentElement.outerHTML',
  //             )
  //             as String;

  //     // 2. تنظيف النص
  //     String htmlContent = rawHtml;
  //     if (htmlContent.startsWith('"') && htmlContent.endsWith('"')) {
  //       htmlContent = jsonDecode(htmlContent);
  //     }

  //     // 3. بدلاً من الحفظ المباشر، نفتح واجهة الطباعة
  //     // هذه الواجهة تسمح للمستخدم بحفظ الملف PDF في أي مكان يختاره
  //     await Printing.layoutPdf(
  //       onLayout: (PdfPageFormat format) async => await Printing.convertHtml(
  //         format: format,
  //         html: htmlContent,
  //         baseUrl: 'https://fast-service.sitksa-eg.com/',
  //       ),
  //       name: 'Invoice_${widget.invoiceId}',
  //     );

  //     setState(() => _isLoading = false);
  //   } catch (e) {
  //     setState(() => _isLoading = false);
  //     debugPrint('Error: $e');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('عذراً، لا يمكن معالجة الفاتورة حالياً')),
  //     );
  //   }
  // }

  // دالة تصدير الـ PDF
  Future<void> _printInvoice() async {
    try {
      // إظهار مؤشر تحميل بسيط أثناء معالجة الطلب
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('جاري تحضير الفاتورة...')));

      // نقوم بجلب محتوى الصفحة كـ HTML للطباعة،
      // أو إذا كان السيرفر يدعم تحويل الرابط لـ PDF مباشرة يفضل استخدامه
      await Printing.layoutPdf(
        onLayout: (format) async => await Printing.convertHtml(
          format: format,
          html: await _getHtmlContent(),
        ),
      );
    } catch (e) {
      debugPrint('Error printing PDF: $e');
    }
  }

  // جلب محتوى الـ HTML من الرابط
  Future<String> _getHtmlContent() async {
    final response = await http.get(Uri.parse(invoiceUrl));
    if (response.statusCode == 200) {
      return response.body;
    }
    return '';
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
        // --- إضافة زر التصدير هنا ---
        actions: [
          // زر الطباعة (الذي أضفناه سابقاً)
          IconButton(
            icon: const Icon(Icons.print, color: AppColors.scaffoldBackground),
            onPressed: _printInvoice,
          ),
          10.horizontalSpace,
          // زر التحميل الجديد
          // IconButton(
          //   icon: const Icon(
          //     Icons.download_for_offline,
          //     color: AppColors.scaffoldBackground,
          //   ),
          //   onPressed: _handlePdfAction,
          // ),
        ],
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
