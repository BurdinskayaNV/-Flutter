
// apod_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../cubit/nasa_cubit.dart';

class MarsRoverPhotosScreen extends StatelessWidget {
  const MarsRoverPhotosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Curiosity (Sol 100)')),
      body: BlocBuilder<MarsRoverCubit, MarsRoverState>(
        builder: (context, state) {
          if (state is MarsRoverLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is MarsRoverError) {
            return Center(child: Text(state.message));
          }
          if (state is MarsRoverLoaded) {
            return _buildPhotosList(state.photos);
          }
          return const Center(child: Text('Press button to load photos'));
        },
      ),
    );
  }

  Widget _buildPhotosList(List<Map<String, dynamic>> photos) {
    return ListView.builder(
      itemCount: photos.length,
      itemBuilder: (context, index) {
        final photo = photos[index];
        return Card(
          margin: const EdgeInsets.all(8),
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: photo['url'],
                placeholder: (_, __) => Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (_, __, ___) => Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: const Icon(Icons.error),
                ),
                fit: BoxFit.cover,
                height: 200,
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(photo['title'], 
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text('Earth Date: ${photo['date']}'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}