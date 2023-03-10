import 'package:ai_ecard/import.dart';
import 'package:flutter_svg/svg.dart';

class SvgViewer extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit fit;
  final bool matchTextDirection;
  final String? package;

  const SvgViewer({Key? key, required this.url, this.width, this.height, this.color, this.fit = BoxFit.contain,  this.matchTextDirection = false, this.package}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(url.indexOf('http') == 0){
      return SvgPicture.network(
          url,
        height: height,
        width: width,
        color: color,
        fit: fit,
        matchTextDirection: matchTextDirection,
      );
    }
    return SvgPicture.asset(
      url,
      matchTextDirection: matchTextDirection,
      fit: fit,
      color: color,
      width: width,
      height: height,
      package: package,
    );
  }
}
