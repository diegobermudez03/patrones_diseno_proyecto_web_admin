import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_admin/core/app_strings.dart';
import 'package:web_admin/features/bookings/presentation/state/bookings_bloc.dart';
import 'package:web_admin/shared/entities/occasion_entity.dart';

class BookingsTable extends StatelessWidget {
  final List<OccasionEntity> bookings;

  BookingsTable({
    super.key,
    required this.bookings,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title and icon
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              children: [
                Icon(
                  Icons.book_online,
                  color: colorScheme.primary,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  '${AppStrings.bookings} (${bookings.length})',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),

          // Table header with decorative divider
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _buildHeaderCells(context, colorScheme),
              ),
            ),
          ),
          const Divider(),

          // Booking rows
          Expanded(
            child: bookings.isNotEmpty
                ? ListView.builder(
                    itemCount: bookings.length,
                    itemBuilder: (context, index) => _buildBookingRow(
                      bookings[index],
                      context,
                      colorScheme,
                      index,
                    ),
                  )
                : Center(
                    child: Text(
                      AppStrings.noBookingsAvailable,
                      style: TextStyle(color: colorScheme.onSurfaceVariant),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildHeaderCells(BuildContext context, ColorScheme colorScheme) {
    const headers = [
      AppStrings.email,
      AppStrings.phone,
      AppStrings.residenceType,
      AppStrings.address,
      AppStrings.entryDate,
      AppStrings.exitDate,
      AppStrings.state,
    ];

    return headers
        .map(
          (header) => Expanded(
            child: Text(
              header,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurfaceVariant,
                fontSize: 14,
              ),
            ),
          ),
        )
        .toList();
  }

  Widget _buildBookingRow(
    OccasionEntity book,
    BuildContext context,
    ColorScheme colorScheme,
    int index,
  ) {
    final Color rowBackground = index % 2 == 0
        ? colorScheme.surfaceContainer
        : colorScheme.surfaceContainerHigh;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: rowBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: _buildCellText(book.user.email, colorScheme.primary)),
          Expanded(child: _buildCellText(book.user.number, colorScheme.secondary)),
          Expanded(child: _buildCellText(book.booking!.isHouse ? AppStrings.house : AppStrings.apartment, colorScheme.tertiary)),
          Expanded(child: _buildCellText(book.booking!.address, colorScheme.onSurface)),
          Expanded(child: _buildCellText('${_formatDate(book.booking!.entryDate)}', colorScheme.onSurfaceVariant)),
          Expanded(child: _buildCellText('${_formatDate(book.booking!.exitDate)}', colorScheme.onSurfaceVariant)),
          _buildAction(book.state.stateName, context, book.booking!.id, colorScheme),
        ],
      ),
    );
  }

  Widget _buildCellText(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: color,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildAction(String state, BuildContext context, int bookingId, ColorScheme colorScheme) {
    if (state == AppStrings.registeredState) {
      return ElevatedButton(
        onPressed: () => BlocProvider.of<BookingsBloc>(context).inviteBooking(bookingId),
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primaryContainer,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          AppStrings.invite,
          style: TextStyle(
            color: colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    if (state == AppStrings.invitedState) {
      return _buildStateBadge(AppStrings.invited, colorScheme.secondary);
    } else {
      return _buildStateBadge(AppStrings.confirmed, colorScheme.primary);
    }
  }

  Widget _buildStateBadge(String text, Color badgeColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: badgeColor,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}'; // Customize as needed
  }
}
