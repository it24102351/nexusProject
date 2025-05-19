<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Submit Your Testimonial</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(to right, #ffffff, #c0c0c0);
            color: #333;
        }
        .testimonial-form-container {
            max-width: 500px;
            margin: 4rem auto;
            background: rgba(20,30,60,0.7);
            border-radius: 16px;
            padding: 2rem 2.5rem;
            box-shadow: 0 4px 16px rgba(0,0,0,0.10);
        }
        .testimonial-form label {
            color: #fff;
        }
        .testimonial-form h2 {
            color: #fff;
        }
    </style>
</head>
<body>
    <div class="testimonial-form-container">
        <h2 class="mb-4 text-center">Share Your Experience</h2>
        <form class="testimonial-form" action="testimonials" method="post">
            <div class="mb-3">
                <label for="name" class="form-label">Your Name</label>
                <input type="text" class="form-control" name="name" id="name" required>
            </div>
            <div class="mb-3">
                <label for="photo" class="form-label">Photo URL (optional)</label>
                <input type="text" class="form-control" name="photo" id="photo" placeholder="https://example.com/photo.jpg">
            </div>
            <div class="mb-3">
                <label for="message" class="form-label">Your Testimonial</label>
                <textarea class="form-control" name="message" id="message" rows="3" required></textarea>
            </div>
            <div class="text-center">
                <button type="submit" class="btn btn-primary">Submit Testimonial</button>
            </div>
        </form>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 