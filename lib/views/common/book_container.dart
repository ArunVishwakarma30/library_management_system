import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:library_management_system/constants/constants.dart';

class BookContainer extends StatelessWidget {
  const BookContainer({
    Key? key,
    required this.name,
    required this.author,
    required this.image,
    this.onDetailsTap,
  }) : super(key: key);
  final String name;
  final String author;

  final String image;
  final VoidCallback? onDetailsTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onDetailsTap,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            // margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
                color: mainColor, borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  height: 130,
                  child: Center(child: Image.network(fit: BoxFit.fill, image)),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: 6,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        author,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
