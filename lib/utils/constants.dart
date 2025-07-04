import 'package:flutter/material.dart';

/// Colores utilizados según género
const Color maleColor = Colors.blue;
const Color femaleColor = Colors.pink;

/// Categorías de edad
enum AgeCategory { joven, adulto, anciano }

/// Imágenes por categoría de edad
const Map<AgeCategory, String> ageCategoryImages = {
  AgeCategory.joven: 'assets/images/young.png',
  AgeCategory.adulto: 'assets/images/adult.png',
  AgeCategory.anciano: 'assets/images/elderly.png',
};

/// Ciudad y país por defecto para clima
const String defaultCity = 'Santo Domingo';
const String defaultCountryCode = 'DO';

/// API Key de OpenWeatherMap (REEMPLAZA ESTA)
const String openWeatherApiKey = '8099c78a9f52dfae903344df1f48795f';

/// API completa de OpenWeatherMap
String get openWeatherApiUrl =>
    'https://api.openweathermap.org/data/2.5/weather?q=Santo+Domingo,DO&appid=8099c78a9f52dfae903344df1f48795f&units=metric&lang=es';

/// API base de WordPress (puedes cambiarla por otra)
const String wordpressApiUrl = 'https://techcrunch.com/wp-json/wp/v2/posts?per_page=3';

/// Imagen del logo de WordPress
const String wordpressLogo = 'assets/images/wordpress_logo.png';

/// Imagen del icono de la app (foto personal)
const String appIcon = 'assets/icons/app_icon.png';
