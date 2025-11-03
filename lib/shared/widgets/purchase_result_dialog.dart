import 'package:flutter/material.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';

enum PurchaseStatus { success, failure }

class PurchaseResultDialog extends StatelessWidget {
  final PurchaseStatus status;
  final String? transactionId;
  final VoidCallback onClose;
  final VoidCallback onRetry;

  const PurchaseResultDialog({
    Key? key,
    required this.status,
    this.transactionId,
    required this.onClose,
    required this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSuccess = status == PurchaseStatus.success;
    final String title = isSuccess
        ? 'Successful Purchased'
        : 'Failed to Purchase';
    final String message = isSuccess
        ? 'transaction id: ${transactionId ?? "#N/A"}'
        : "Don't worry – your details are safe. Try again or use another payment method.";
    final String buttonText = isSuccess ? 'Close' : 'Retry Now';

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        padding: const EdgeInsets.all(24),
        width: 340,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Tick Icon inside blue rounded background
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: isSuccess
                    ? AppColors.primary.withValues(alpha: 0.1)
                    : AppColors.error.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  isSuccess ? Icons.check_circle : Icons.error,
                  color: isSuccess ? AppColors.primary : AppColors.error,
                  size: 48,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Poppins',
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              style: TextStyle(
                fontSize: isSuccess ? 15 : 14,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: isSuccess ? onClose : onRetry,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
