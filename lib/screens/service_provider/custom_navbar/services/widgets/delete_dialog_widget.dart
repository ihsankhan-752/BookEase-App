import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../controllers/service_provider_controller.dart';
import '../../../../../utils/show_custom_msg.dart';

void deleteDialogWidget(BuildContext context, String serviceId) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Delete Service'),
      content: const Text('Are you sure you want to delete this service?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            context.read<ServiceController>().deleteService(
              serviceId: serviceId,
              onSuccess: () => showCustomMsg(context, 'Service Deleted'),
              onError: () => showCustomMsg(
                context,
                context.read<ServiceController>().error ?? 'Failed to delete',
              ),
            );
          },
          child: const Text('Delete', style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );
}
