<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Not Found</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .error-container {
            text-align: center;
            background-color: #ffffff;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .error-container h1 {
            font-size: 2rem;
            color: #dc3545;
        }
        .error-container p {
            font-size: 1rem;
            color: #6c757d;
        }
        .error-container a {
            display: inline-block;
            margin-top: 15px;
            padding: 10px 20px;
            font-size: 1rem;
            color: #ffffff;
            background-color: #007bff;
            text-decoration: none;
            border-radius: 5px;
        }
        .error-container a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <h1>Product Not Found</h1>
        <p>Sorry, the product you are looking for does not exist or is no longer available.</p>
        <a href="/home">Go Back to Home</a>
    </div>
</body>
</html>