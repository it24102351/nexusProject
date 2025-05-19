<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Welcome Students</title>
  <!-- Tailwind CSS CDN -->
  <script src="https://cdn.tailwindcss.com"></script>
  <!-- Custom animation -->
  <style>
    @keyframes fadeSlide {
      0% {
        opacity: 0;
        transform: translateY(40px);
      }
      100% {
        opacity: 1;
        transform: translateY(0);
      }
    }
    .fade-slide {
      animation: fadeSlide 1.5s ease-out forwards;
    }
  </style>
</head>
<body class="bg-gradient-to-br from-blue-900 via-blue-800 to-gray-900 text-white min-h-screen flex flex-col items-center justify-center">

<!-- Welcome message -->
<div class="text-center fade-slide">
  <h1 class="text-4xl md:text-6xl font-bold mb-4">👋 Welcome Future Coders!</h1>
  <p class="text-lg md:text-2xl mb-6">Unlock your coding journey with Java, Python, and more.</p>

  <!-- Explore Button -->
  <a href="2ndpage.jsp"
     class="px-6 py-3 bg-blue-600 hover:bg-blue-500 text-white rounded-2xl shadow-lg transition transform hover:scale-105 duration-300">
    🚀 Explore
  </a>
</div>
</body>
</html>

