import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../shared/constants.dart';


class CustomSpecificDropDown extends StatelessWidget {
  String? initialValue;
  final List<String> listItems;
  final FormFieldValidator validator;
  final void Function(String?)? onChange;
  final bool suffixIcon;
  final double? dropBottomWidth;
  final double? dropBottomHeight;
  final String hintText;
  final Color? borderColor;
  double? fontSize;
  bool? isExpanded;
  String? image;
  String? label;
  double? hintFontSize;
  double? containerWidth;
  final Color hintColor;

  CustomSpecificDropDown(
      {Key? key,
      this.dropBottomWidth,
      this.fontSize,
      this.isExpanded,
      this.borderColor,
      this.dropBottomHeight,
      this.hintFontSize,
      required this.hintText,
      required this.listItems,
      this.initialValue,
      required this.validator,
      required this.onChange,
      this.suffixIcon = true,
      this.label,
      this.image,
      required this.hintColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return label != null
        ? Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                height: 70.h,
              ),
              SizedBox(
                  width: dropBottomWidth,
                  height: 35.h,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      hint: Text(
                        initialValue ?? "",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      items: listItems
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      onChanged: onChange,
                      buttonStyleData: ButtonStyleData(
                        height: 56,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black,
                          ),
                          color: Colors.white,
                        ),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down,
                        ),
                        iconSize: 20,
                        iconEnabledColor: Colors.grey,
                        iconDisabledColor: Colors.grey,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 200,
                        width: MediaQuery.of(context).size.width * 0.7,
                        padding: null,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        elevation: 8,
                        offset: const Offset(-20, 0),
                        scrollbarTheme: ScrollbarThemeData(
                          radius: const Radius.circular(10),
                          thickness: MaterialStateProperty.all<double>(6),
                          thumbVisibility:
                              MaterialStateProperty.all<bool>(true),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 40),
                      ),
                    ),
                  )),
              Positioned(
                top: 4,
                right: 8,
                child: Container(
                  width: 85.w,
                  height: 23.h,
                  decoration: BoxDecoration(
                      color: kDarkGoldColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(28.r),
                        topLeft: Radius.circular(28.r),
                      )),
                  child: Center(
                      child: Text(
                    label!,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w300),
                  )),
                ),
              )
            ],
          )
        : SizedBox(
            width: dropBottomWidth,
            height: 35.h,
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                isExpanded: true,
                style: const TextStyle(
                  color: Colors.black,
                ),
                hint: Text(
                  initialValue ?? "",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                items: listItems.map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                )).toList(),
                onChanged: onChange,
                buttonStyleData: ButtonStyleData(
                  height: 56,
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black,
                    ),
                    color: Colors.white,
                  ),
                ),
                iconStyleData: const IconStyleData(
                  icon: Icon(
                    Icons.arrow_drop_down,
                  ),
                  iconSize: 20,
                  iconEnabledColor: Colors.grey,
                  iconDisabledColor: Colors.grey,
                ),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 200,
                  width: MediaQuery.of(context).size.width * 0.7,
                  padding: null,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  elevation: 8,
                  offset: const Offset(-20, 0),
                  scrollbarTheme: ScrollbarThemeData(
                    radius: const Radius.circular(10),
                    thickness: MaterialStateProperty.all<double>(6),
                    thumbVisibility: MaterialStateProperty.all<bool>(true),
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 40),
                ),

              ),
            ));
  }
}
