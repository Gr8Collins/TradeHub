<?php
session_start();
require 'config.php';
require_once 'cloudinary_helper.php';

if (!isset($_SESSION['logged_in']) || $_SESSION['logged_in'] !== true) {
    header('Location: login.php');
    exit();
}

$user_id = $_SESSION['user_id'];

// ============================================
// Handle profile picture upload - stored on Cloudinary, URL saved in avatar_url
// ============================================
$avatar_path = null;

if (isset($_FILES['avatar_url']) && $_FILES['avatar_url']['error'] !== UPLOAD_ERR_NO_FILE) {

    $upload_error = $_FILES['avatar_url']['error'];

    if ($upload_error !== UPLOAD_ERR_OK) {
        // Give a specific reason instead of failing silently
        $upload_errors = [
            UPLOAD_ERR_INI_SIZE   => 'The file is larger than this server allows (upload_max_filesize).',
            UPLOAD_ERR_FORM_SIZE  => 'The file is larger than the form allows.',
            UPLOAD_ERR_PARTIAL    => 'The file was only partially uploaded. Try again.',
            UPLOAD_ERR_NO_TMP_DIR => 'Server is missing a temporary folder for uploads.',
            UPLOAD_ERR_CANT_WRITE => 'Server failed to write the file to disk.',
            UPLOAD_ERR_EXTENSION  => 'A server extension blocked the upload.',
        ];
        $_SESSION['settings_message'] = 'Profile picture upload failed: ' . ($upload_errors[$upload_error] ?? 'Unknown upload error.');
        $_SESSION['settings_type'] = 'error';
    } else {
        $file_ext = strtolower(pathinfo($_FILES['avatar_url']['name'], PATHINFO_EXTENSION));
        $allowed  = ['jpg', 'jpeg', 'png', 'gif', 'webp'];
        $max_size = 2 * 1024 * 1024; // 2MB

        if (!in_array($file_ext, $allowed, true)) {
            $_SESSION['settings_message'] = 'Invalid file type. Use JPG, PNG, GIF or WEBP.';
            $_SESSION['settings_type'] = 'error';
        } elseif ($_FILES['avatar_url']['size'] > $max_size) {
            $_SESSION['settings_message'] = 'File is too large. Max size is 2MB.';
            $_SESSION['settings_type'] = 'error';
        } else {
            $uploaded_url = cloudinary_upload_single($_FILES['avatar_url'], 'ebonyi_market_hub/avatars', $max_size);

            if ($uploaded_url) {
                // Remove the old avatar only if it is a local file (old Cloudinary images are left in place)
                $old_avatar = $_SESSION['avatar_url'] ?? '';
                if (!empty($old_avatar) && !preg_match('#^https?://#i', $old_avatar) && file_exists(__DIR__ . '/' . $old_avatar)) {
                    @unlink(__DIR__ . '/' . $old_avatar);
                }
                $avatar_path = $uploaded_url;
            } else {
                $_SESSION['settings_message'] = 'Profile picture could not be uploaded. Please try again.';
                $_SESSION['settings_type'] = 'error';
            }
        }
    }
}

// ============================================
// Profile fields
// ============================================
$first_name        = trim($_POST['first_name'] ?? '');
$last_name         = trim($_POST['last_name'] ?? '');
$email             = trim($_POST['email'] ?? '');
$phone             = trim($_POST['phone'] ?? '');
$store_name        = trim($_POST['store_name'] ?? '');
$store_slogan      = trim($_POST['store_slogan'] ?? '');
$store_description = trim($_POST['store_description'] ?? '');

// ============================================
// Build dynamic prepared statement
// ============================================
$fields = [];   // column = ? fragments
$types  = '';   // bind_param type string
$values = [];   // bind_param values

if ($avatar_path !== null) {
    $fields[] = 'avatar_url = ?';
    $types   .= 's';
    $values[] = $avatar_path;
}
if ($first_name !== '') {
    $fields[] = 'first_name = ?';
    $types   .= 's';
    $values[] = $first_name;
}
if ($last_name !== '') {
    $fields[] = 'last_name = ?';
    $types   .= 's';
    $values[] = $last_name;
}
if ($email !== '') {
    $fields[] = 'email = ?';
    $types   .= 's';
    $values[] = $email;
}
if ($phone !== '') {
    $fields[] = 'phone = ?';
    $types   .= 's';
    $values[] = $phone;
}
if ($store_name !== '') {
    $fields[] = 'store_name = ?';
    $types   .= 's';
    $values[] = $store_name;
}
if ($store_slogan !== '') {
    $fields[] = 'store_slogan = ?';
    $types   .= 's';
    $values[] = $store_slogan;
}
if ($store_description !== '') {
    $fields[] = 'store_description = ?';
    $types   .= 's';
    $values[] = $store_description;
}

// Nothing to update
if (empty($fields)) {
    if (!isset($_SESSION['settings_message'])) {
        $_SESSION['settings_message'] = 'No changes were made.';
        $_SESSION['settings_type'] = 'error';
    }
    header('Location: dashboard.php');
    exit();
}

// WHERE id = ?
$types   .= 'i';
$values[] = $user_id;

$sql = "UPDATE users SET " . implode(', ', $fields) . " WHERE id = ?";

if ($stmt = $conn->prepare($sql)) {

    // Reliable reference-based binding (works on every PHP version)
    $bind_params = [$types];
    foreach ($values as $key => $value) {
        $bind_params[] = &$values[$key];
    }
    call_user_func_array([$stmt, 'bind_param'], $bind_params);

    if ($stmt->execute()) {
        // Update session AFTER a successful DB write
        if ($avatar_path !== null)        $_SESSION['avatar_url'] = $avatar_path;
        if ($first_name !== '')           $_SESSION['first_name'] = $first_name;
        if ($last_name !== '')            $_SESSION['last_name'] = $last_name;
        if ($email !== '')                $_SESSION['email'] = $email;
        if ($phone !== '')                $_SESSION['phone'] = $phone;
        if ($store_name !== '')           $_SESSION['store_name'] = $store_name;
        if ($store_slogan !== '')         $_SESSION['store_slogan'] = $store_slogan;
        if ($store_description !== '')    $_SESSION['store_description'] = $store_description;

        // Don't overwrite an upload error message set above
        if (!isset($_SESSION['settings_type']) || $_SESSION['settings_type'] !== 'error') {
            $_SESSION['settings_message'] = 'Settings updated successfully!';
            $_SESSION['settings_type'] = 'success';
        }
    } else {
        $_SESSION['settings_message'] = 'Error updating settings: ' . $stmt->error;
        $_SESSION['settings_type'] = 'error';
    }

    $stmt->close();
} else {
    $_SESSION['settings_message'] = 'Error preparing update: ' . $conn->error;
    $_SESSION['settings_type'] = 'error';
}

header('Location: dashboard.php');
exit();