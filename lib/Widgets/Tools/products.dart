import 'package:flutter/material.dart';

class Product {
  final String image, title, description, isAvailable, price;
  final int id;
  Product(
      {required this.id,
      required this.image,
      required this.title,
      required this.price,
      required this.description,
      required this.isAvailable});
}

List<Product> products = [
  Product(
      id: 1,
      image: "assets/images/tractor.png",
      title: "Tractor",
      price: "4,00,000 - 6,00,000",
      description: dummyText,
      isAvailable: "yes"),
  Product(
      id: 2,
      title: "Shovel & Spade",
      price: "200-500",
      image: "assets/images/shovel.png",
      description: dummyText,
      isAvailable: "yes"),
  Product(
      id: 3,
      title: "Pick Axe",
      price: "100-1500",
      description: dummyText,
      image: "assets/images/pickaxe.png",
      isAvailable: "yes"),
  Product(
      id: 4,
      title: "Hoe",
      price: "500-1000",
      description: dummyText,
      image: "assets/images/hoe.png",
      isAvailable: "yes"),
  Product(
      id: 5,
      title: "Sprinkler",
      price: "17,000 - 54,000",
      description: dummyText,
      image: "assets/images/sprinkler.png",
      isAvailable: "yes"),
  Product(
      id: 6,
      title: "Seeder",
      price: "5000",
      description: dummyText,
      image: "assets/images/seeder.png",
      isAvailable: "yes"),
  Product(
      id: 7,
      title: "Planter machine",
      price: "14,500 - 32,000",
      description: dummyText,
      image: "assets/images/planter.png",
      isAvailable: "yes"),
  Product(
      id: 8,
      title: "Wheelbarrow",
      price: "10,000 - 15,000",
      description: dummyText,
      image: "assets/images/wheelbarrow.png",
      isAvailable: "yes"),
  Product(
      id: 9,
      title: "Harrow",
      price: "69,000 - 1,14,000",
      description: dummyText,
      image: "assets/images/harrow.png",
      isAvailable: "yes"),
  Product(
      id: 10,
      title: "Land Imprinter",
      price: "18,500",
      description: dummyText,
      image: "assets/images/imprinter.jpg",
      isAvailable: "yes"),
  Product(
      id: 11,
      title: "Motocultor",
      price: "500-1500",
      description: dummyText,
      image: "assets/images/motocultor.png",
      isAvailable: "yes"),
  Product(
      id: 12,
      title: "Rake",
      price: "1000-1500",
      description: dummyText,
      image: "assets/images/rake.png",
      isAvailable: "yes"),
  Product(
      id: 13,
      title: "Baler",
      price: "2,25,000-4,50,000",
      description: dummyText,
      image: "assets/images/baler.png",
      isAvailable: "yes"),
  Product(
      id: 14,
      title: "Hand Sickle",
      price: "100-1500",
      description: dummyText,
      image: "assets/images/sickle.png",
      isAvailable: "yes"),
  Product(
      id: 15,
      title: "Plow Tractor",
      price: "10,000-34,000",
      description: dummyText,
      image: "assets/images/plowtractor.png",
      isAvailable: "yes"),
];

String dummyText =
    "It is basically a simple dummy text.U can buy this item and this is the item from the farmer.U are buying at your covinience.Thank you in advance";
