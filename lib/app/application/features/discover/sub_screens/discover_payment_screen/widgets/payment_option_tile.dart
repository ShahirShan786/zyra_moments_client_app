import 'package:flutter/material.dart';
import 'package:zyra_momments_app/application/config/theme.dart';

class PaymentOptionTile extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final List<Color> indicatorColors;

  const PaymentOptionTile({
    required this.title,
    required this.isSelected,
    required this.onTap,
    this.indicatorColors = const [],
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          color: AppTheme.darkPrimaryColor,
          border: Border.all(color: AppTheme.darkBorderColor),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Radio<bool>(
              value: true,
              groupValue: isSelected,
              onChanged: (value) => onTap(),
              activeColor: AppTheme.darkBlackColor,
              fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                if (states.contains(WidgetState.selected)) {
                  return AppTheme.darkTextColorSecondary;
                }
                return AppTheme.darkBorderColor;
              }),
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: AppTheme.darkTextColorSecondary,
                  fontSize: 16.0,
                ),
              ),
            ),
            if (indicatorColors.isNotEmpty) ...[
              const SizedBox(width: 8.0),
              Row(
                children: indicatorColors
                    .map((color) => Container(
                          width: 25.0,
                          height: 20.0,
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
