import 'package:demo_booking_app/utils/color_constant.dart';
import 'package:demo_booking_app/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pick_calendar_button.dart';

class AppBarSearch extends StatefulWidget {
  const AppBarSearch({super.key});

  @override
  State<AppBarSearch> createState() => _AppBarSearchState();
}

class _AppBarSearchState extends State<AppBarSearch> {
  final TextEditingController searchController = TextEditingController();
  bool _hasText = false;
  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {
        _hasText = searchController.text.isNotEmpty; // Kiểm tra nếu có văn bản
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: DimensionUtils.PADDING_SIZE_EXTRA_LARGE),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Nhập địa chỉ ...",
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: DimensionUtils.FONT_SIZE_OVER_OVER_LARGE,
            ),
          ),
          TextFormField(
            controller: searchController,
            autofocus: true,
            cursorColor: ColorConstant.getPrimaryColor(),
            cursorHeight: 30,
            style: GoogleFonts.roboto(
              fontSize: DimensionUtils.FONT_SIZE_OVER_LARGE,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              suffixIcon: _hasText
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      color: Colors.grey,
                      onPressed: () {
                        searchController
                            .clear(); // Xóa nội dung khi nhấn vào dấu X
                        setState(() {
                          _hasText = false; // Ẩn nút X sau khi xóa
                        });
                      },
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
