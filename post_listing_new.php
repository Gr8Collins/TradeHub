<?php
session_start();
require 'config.php';
require_once 'cloudinary_helper.php';

// Check if user is logged in
if (!isset($_SESSION['logged_in']) || $_SESSION['logged_in'] !== true) {
    header('Location: index.php?msg=error&error=Please login to post a listing');
    exit();
}

// Check if form was submitted
if (isset($_POST['post_ad'])) {
    $user_id = $_SESSION['user_id'];

    // Get form data (no manual escaping: prepared statements below handle it)
    $category      = trim($_POST['category'] ?? '');
    $title         = trim($_POST['title'] ?? '');
    $description   = trim($_POST['description'] ?? '');
    $price         = !empty($_POST['price']) ? floatval($_POST['price']) : null;
    $location      = trim($_POST['location'] ?? '');
    $contact_name  = trim($_POST['contact_name'] ?? '');
    $contact_phone = trim($_POST['contact_phone'] ?? '');
    $contact_email = trim($_POST['contact_email'] ?? '');

    // Generate slug from title
    $slug = strtolower(trim(preg_replace('/[^A-Za-z0-9-]+/', '-', $title), '-')) . '-' . time();

    // Property-specific fields
    $bedrooms  = !empty($_POST['bedrooms'])  ? intval($_POST['bedrooms'])    : null;
    $bathrooms = !empty($_POST['bathrooms']) ? intval($_POST['bathrooms'])   : null;
    $area      = !empty($_POST['area'])      ? floatval($_POST['area'])      : null;

    // Item-specific fields
    $condition = isset($_POST['condition']) ? trim($_POST['condition']) : 'used';
    $brand     = isset($_POST['brand'])     ? trim($_POST['brand'])     : '';

    // Set property_type and listing_type based on category
    $property_type = 'house';
    $listing_type  = 'sale';

    if ($category == 'apartment') {
        $property_type = 'apartment';
        $listing_type  = 'rent';
    } elseif ($category == 'land') {
        $property_type = 'land';
        $listing_type  = 'sale';
    } elseif ($category == 'property') {
        $property_type = 'house';
        $listing_type  = 'sale';
    } elseif ($category == 'item') {
        $property_type = 'other';
        $listing_type  = 'sale';
    }

    // ============================================
    // IMAGE UPLOAD TO CLOUDINARY (max 5 images)
    // ============================================
    $image_urls = [];
    $images_selected = isset($_FILES['images']['name'][0]) && $_FILES['images']['name'][0] !== '';

    if ($images_selected) {
        $image_urls = cloudinary_upload_multiple($_FILES['images'], 'ebonyi_market_hub/listings', 5);

        // The user picked images but none could be uploaded
        if (empty($image_urls)) {
            header('Location: index.php?msg=error&error=' . urlencode('Image upload failed. Use JPG, PNG, GIF or WEBP files under 5MB and try again.'));
            exit();
        }
    }

    // First image is the main image shown on cards and listings
    $image_path = !empty($image_urls) ? $image_urls[0] : null;

    // Get category_id from categories table based on category name
    $category_id = null;
    $category_id_query = "SELECT id FROM categories WHERE LOWER(name) = LOWER(?) OR LOWER(slug) = LOWER(?)";
    $stmt = $conn->prepare($category_id_query);
    if ($stmt) {
        $cat_name = $category;
        if ($category == 'property')  $cat_name = 'Real Estate';
        if ($category == 'apartment') $cat_name = 'Apartments';
        if ($category == 'land')      $cat_name = 'Lands';
        if ($category == 'item')      $cat_name = 'Used Items';

        $stmt->bind_param("ss", $cat_name, $cat_name);
        $stmt->execute();
        $result = $stmt->get_result();
        if ($row = $result->fetch_assoc()) {
            $category_id = $row['id'];
        }
        $stmt->close();
    }

    $query = "INSERT INTO listings (
        user_id, category, category_id, title, slug, description,
        price, location, property_type, listing_type,
        bedrooms, bathrooms, floor_area,
        item_condition, brand, image,
        contact_name, contact_phone, contact_email,
        status, created_at
    ) VALUES (
        ?, ?, ?, ?, ?, ?,
        ?, ?, ?, ?,
        ?, ?, ?,
        ?, ?, ?,
        ?, ?, ?,
        'active', NOW()
    )";

    $stmt = $conn->prepare($query);
    if (!$stmt) {
        header('Location: index.php?msg=error&error=' . urlencode('Database error: ' . $conn->error));
        exit();
    }

    $stmt->bind_param("isisssdsssiidssssss",
        $user_id,           // 1. int
        $category,          // 2. string
        $category_id,       // 3. int
        $title,             // 4. string
        $slug,              // 5. string
        $description,       // 6. string
        $price,             // 7. double
        $location,          // 8. string
        $property_type,     // 9. string
        $listing_type,      // 10. string
        $bedrooms,          // 11. int
        $bathrooms,         // 12. int
        $area,              // 13. double
        $condition,         // 14. string
        $brand,             // 15. string
        $image_path,        // 16. string (Cloudinary URL of first image)
        $contact_name,      // 17. string
        $contact_phone,     // 18. string
        $contact_email      // 19. string
    );

    if ($stmt->execute()) {
        $listing_id = $stmt->insert_id;

        // Save every Cloudinary URL in listing_images (first one is primary)
        if (!empty($image_urls)) {
            $image_query = "INSERT INTO listing_images (listing_id, image_url, is_primary, sort_order) VALUES (?, ?, ?, ?)";
            $image_stmt = $conn->prepare($image_query);

            if ($image_stmt) {
                foreach ($image_urls as $sort_order => $url) {
                    $is_primary = ($sort_order === 0) ? 1 : 0;
                    $image_stmt->bind_param("isii", $listing_id, $url, $is_primary, $sort_order);
                    $image_stmt->execute();
                }
                $image_stmt->close();
            }
        }

        header('Location: index.php?msg=success');
    } else {
        header('Location: index.php?msg=error&error=' . urlencode($stmt->error));
    }

    $stmt->close();
} else {
    header('Location: index.php');
}

$conn->close();
?>