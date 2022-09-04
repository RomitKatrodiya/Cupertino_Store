import 'package:flutter/cupertino.dart';

class Global {
  static List cartList = [];
  static List<Map> productsList = [
    {
      "name": "Laptop",
      "price": "644",
      "image":
          "https://media.istockphoto.com/photos/the-perfect-setting-to-complete-work-picture-id1251629816?b=1&k=20&m=1251629816&s=612x612&w=0&h=39mup4FUdt9ilsVvHkI4nhrQ3LMLy0DDF6z0JhXSR3s=",
    },
    {
      "name": "Smart phone",
      "price": "1029",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWhiK7In157qIWeghzdP8-SEs0UIi-hYo7gA&usqp=CAU",
    },
    {
      "name": "Headphones",
      "price": "31",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYFO8ENI5zf9oEeb0x9RcNwgkqftdv2LFoFA&usqp=CAU",
    },
    {
      "name": "Monitor",
      "price": "129",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWQe8wV-RJv-Ph3c1xpZ1-t0T-Fk0oucQfgA&usqp=CAU",
    },
    {
      "name": "Smart speaker",
      "price": "30",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHVxECbFHtmEewX7iK8h4GOF4ZCh2wVK99kQ&usqp=CAU",
    },
    {
      "name": "Apple Watch Charger",
      "price": "9",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPCt5D-NOfcJHa9k6v8IEjNvKDiE0f3iOo3A&usqp=CAU",
    },
    {
      "name": "TV",
      "price": "205",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQqXSC5IeoHxs0ahdUkPjbCMZV9lyiEpvKO0A&usqp=CAU",
    },
    {
      "name": "Home Theater",
      "price": "249",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRq3rDEb2lIIW-WKB8OcG8642UtvhzqO-P4bg&usqp=CAU",
    },
    {
      "name": "Bluetooth Projector",
      "price": "199",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOJZEa1ytghZK_Twivsl6Ot5nBRKt6GalMYg&usqp=CAU",
    },
    {
      "name": "SAMSUNG Galaxy Tab",
      "price": "149",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQXUz-9wJdn9Y3-ph-h_z4bPSzWdx8Du9MUA&usqp=CAU",
    },
  ];
}

titleText(String title) {
  return Container(
    padding: const EdgeInsets.all(12),
    alignment: Alignment.bottomLeft,
    child: Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 34),
    ),
  );
}
