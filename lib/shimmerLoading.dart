import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class newsShimmerLoading extends StatelessWidget {
  const newsShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    /*
                    I have just added the containers as place holders for the components of each news card when 
                    its in loading state as images and other info are inacessible for that moment here.
                    */
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            color: Colors.grey[300], 
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 16,
                                  color: Colors.grey[300], 
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  height: 14,
                                  width: 150,
                                  color: Colors.grey[300],
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  height: 14,
                                  width: 100,
                                  color: Colors.grey[300], // Placeholder for date
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
  }
}