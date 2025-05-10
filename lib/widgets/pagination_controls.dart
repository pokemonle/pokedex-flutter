import 'package:flutter/material.dart';

class PaginationControls extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final int perPage;
  final List<int> perPageOptions;
  final ValueChanged<int> onPageChange;
  final ValueChanged<int> onPerPageChange;

  const PaginationControls({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.perPage,
    this.perPageOptions = const [12, 24, 36, 48, 60],
    required this.onPageChange,
    required this.onPerPageChange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed:
              currentPage > 1 ? () => onPageChange(currentPage - 1) : null,
        ),
        Text('Page $currentPage of $totalPages'),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed:
              currentPage < totalPages
                  ? () => onPageChange(currentPage + 1)
                  : null,
        ),
        DropdownButton<int>(
          value: perPage,
          onChanged: (newValue) => onPerPageChange(newValue!),
          items:
              perPageOptions.map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
        ),
      ],
    );
  }
}
