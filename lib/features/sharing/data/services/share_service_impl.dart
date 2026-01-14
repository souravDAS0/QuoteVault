import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../home_feed/domain/entities/quote.dart';
import '../../domain/entities/share_template.dart';
import '../../application/services/share_service.dart';
import '../generators/quote_image_generator.dart';

/// Implementation of ShareService
/// Handles text sharing, image sharing, and saving images to device
class ShareServiceImpl implements ShareService {
  final QuoteImageGenerator _imageGenerator;

  ShareServiceImpl({QuoteImageGenerator? imageGenerator})
    : _imageGenerator = imageGenerator ?? QuoteImageGenerator();

  @override
  Future<void> shareAsText(Quote quote) async {
    final text = '"${quote.text}" - ${quote.authorName}';
    await SharePlus.instance.share(ShareParams(text: text));
  }

  @override
  Future<void> shareAsImage(
    Quote quote,
    ShareTemplate template, {
    bool isDark = false,
  }) async {
    final imageBytes = await _imageGenerator.generateImage(
      quote,
      template,
      isDark: isDark,
    );
    if (imageBytes == null) {
      throw Exception('Failed to generate image');
    }

    final tempDir = await getTemporaryDirectory();
    final fileName =
        'quote_${quote.id}_${DateTime.now().millisecondsSinceEpoch}.png';
    final file = File('${tempDir.path}/$fileName');
    await file.writeAsBytes(imageBytes);

    final params = ShareParams(
      text: '${quote.text} by ${quote.authorName}',
      files: [XFile(file.path)],
    );

    await SharePlus.instance.share(params);
  }

  @override
  Future<String?> saveImageToDevice(
    Quote quote,
    ShareTemplate template, {
    bool isDark = false,
  }) async {
    final imageBytes = await _imageGenerator.generateImage(
      quote,
      template,
      isDark: isDark,
    );
    if (imageBytes == null) {
      return null;
    }

    final fileName =
        'quote_${quote.text}_${quote.id}_${DateTime.now().millisecondsSinceEpoch}.png';
    return await _saveImageBytes(imageBytes, fileName);
  }

  Future<String?> _saveImageBytes(Uint8List imageBytes, String fileName) async {
    try {
      Directory? directory;
      if (Platform.isAndroid) {
        directory = await getExternalStorageDirectory();
        // Navigate to Downloads directory
        // External storage path is typically /storage/emulated/0/Android/data/package/files
        // We need to go up and access Download folder
        final downloadsDir = Directory(
          '/storage/emulated/0/Download/QuoteVault',
        );
        if (!await downloadsDir.exists()) {
          await downloadsDir.create(recursive: true);
        }
        directory = downloadsDir;
      } else if (Platform.isIOS) {
        // On iOS, use the app's documents directory
        // iOS doesn't have a public Downloads folder
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = await getApplicationDocumentsDirectory();
      }

      final file = File('${directory.path}/$fileName');
      await file.writeAsBytes(imageBytes);
      return file.path;
    } catch (e) {
      return null;
    }
  }
}
