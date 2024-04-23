import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/constants/colors.dart';

class SearchPageInput extends StatelessWidget {
  const SearchPageInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 100.w,
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 10.0),
      child: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 2.h),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    onTap: () async {

                    },
                    style: TextStyle(
                      fontSize: 18.sp,
                    ),

                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        onPressed: (){

                        },
                        icon: const Icon(
                          FontAwesomeIcons.magnifyingGlass,
                          size: 20.0,
                          color: darkGrey,
                        ),
                      ),
                      hintText: "Search News, Categories, etc..",
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      filled: true,
                      fillColor: Colors.grey[350],
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                        vertical: 2.h,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
