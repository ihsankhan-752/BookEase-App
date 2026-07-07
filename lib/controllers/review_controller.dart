import 'package:flutter/material.dart';

import '../models/review_model.dart';
import '../services/review_services.dart';
import '../services/storage_services.dart';

class ReviewController extends ChangeNotifier {
  final ReviewServices _reviewServices = ReviewServices();
  final StorageService _storageService = StorageService();

  List<ReviewModel> _reviews = [];
  bool _isLoading = false;
  String? _error;

  List<ReviewModel> get reviews => _reviews;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> createReview({
    required String bookingId,
    required String review,
    required int rating,
    required VoidCallback onSuccess,
    required VoidCallback onError,
  }) async {
    if (review.isEmpty) {
      _error = 'Review cannot be empty';
      notifyListeners();
      onError();
      return;
    }
    if (rating == 0) {
      _error = 'Please select a rating';
      notifyListeners();
      onError();
      return;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final token = _storageService.getAccessToken();
      if (token == null) {
        _error = 'Not authenticated';
        onError();
        return;
      }

      final result = await _reviewServices.createReview(
        accessToken: token,
        bookingId: bookingId,
        review: review,
        rating: rating,
      );

      if (result['success'] == true) {
        onSuccess();
      } else {
        _error = result['message'];
        onError();
      }
    } catch (e) {
      _error = 'Something went wrong. Please try again.';
      onError();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getServiceReviews({
    required String serviceId,
    required VoidCallback onError,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _reviewServices.getServiceReviews(
        serviceId: serviceId,
      );

      if (result['success'] == true) {
        _reviews = (result['reviews'] as List)
            .map((r) => ReviewModel.fromJson(r))
            .toList();
      } else {
        _reviews = [];
      }
    } catch (e) {
      _error = 'Something went wrong.';
      onError();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteReview({
    required String reviewId,
    required VoidCallback onSuccess,
    required VoidCallback onError,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final token = _storageService.getAccessToken();
      if (token == null) {
        _error = 'Not authenticated';
        onError();
        return;
      }

      final result = await _reviewServices.deleteReview(
        accessToken: token,
        reviewId: reviewId,
      );

      if (result['success'] == true) {
        _reviews.removeWhere((r) => r.id == reviewId);
        onSuccess();
      } else {
        _error = result['message'];
        onError();
      }
    } catch (e) {
      _error = 'Something went wrong.';
      onError();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearReviews() {
    _reviews = [];
    notifyListeners();
  }
}
