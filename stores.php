<?php
session_start();
require 'config.php';

$isLoggedIn = isset($_SESSION['logged_in']) && $_SESSION['logged_in'] === true;
$viewer_id  = $_SESSION['user_id'] ?? 0;

$user_id = intval($_GET['user_id'] ?? 0);

/**
 * Houses, lands and apartments use the property page; everything else uses the item page.
 */
function is_property_category($category) {
    return (bool) preg_match('/\b(propert(y|ies)|lands?|apartments?|houses?|real estate|rentals?)\b/i', (string) $category);
}

// ============================================================
// NO user_id  ->  show the list of ALL vendors and landlords
// (this is what the "Stores" menu link and "View All" buttons open)
// ============================================================
if (!$user_id) {
    $stores = [];
    $stores_query = "SELECT u.id, u.username, u.store_name, u.store_verified, u.store_rating, u.role, u.avatar_url, u.store_description,
                     COUNT(l.id) AS listing_count
                     FROM users u
                     LEFT JOIN listings l ON u.id = l.user_id AND l.status = 'active'
                     WHERE (u.is_vendor = 1 OR u.role = 'landlord') AND u.status = 'active'
                     GROUP BY u.id
                     ORDER BY listing_count DESC, u.store_rating DESC";
    $stores_result = $conn->query($stores_query);
    if ($stores_result) {
        while ($row = $stores_result->fetch_assoc()) {
            $stores[] = $row;
        }
    }
    ?>
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>All Vendors &amp; Landlords - Ebonyi Market Hub</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            :root{--primary:#ff7b00;--secondary:#2c3e50;--gray:#6c757d;--light-gray:#e9ecef;}
            *{box-sizing:border-box;font-family:'Inter',-apple-system,BlinkMacSystemFont,'Segoe UI',Roboto,sans-serif;}
            body{background:#f5f7fa;color:#343a40;margin:0;}
            .mini-nav{background:#fff;box-shadow:0 2px 8px rgba(0,0,0,.05);padding:.9rem 5%;display:flex;align-items:center;justify-content:space-between;}
            .mini-nav a.brand{font-weight:700;color:var(--secondary);text-decoration:none;}
            .mini-nav a.brand i{color:var(--primary);margin-right:.4rem;}
            .mini-nav .actions a{color:var(--secondary);text-decoration:none;font-weight:500;font-size:.9rem;margin-left:1.25rem;}
            .mini-nav .actions a:hover{color:var(--primary);}
            .page-head{background:linear-gradient(135deg,var(--secondary),#1a2632);color:#fff;padding:3rem 5%;text-align:center;}
            .page-head h1{font-size:clamp(1.5rem,4vw,2.2rem);font-weight:700;}
            .grid{max-width:1100px;margin:2rem auto;padding:0 5%;display:grid;grid-template-columns:repeat(auto-fill,minmax(210px,1fr));gap:1.2rem;}
            .card-store{background:#fff;border-radius:12px;padding:1.2rem 1rem;text-align:center;box-shadow:0 2px 8px rgba(0,0,0,.05);text-decoration:none;color:inherit;transition:.25s;}
            .card-store:hover{transform:translateY(-4px);box-shadow:0 10px 25px rgba(0,0,0,.12);color:inherit;}
            .av{width:64px;height:64px;border-radius:50%;background:var(--primary);color:#fff;display:flex;align-items:center;justify-content:center;font-weight:700;font-size:1.3rem;margin:0 auto .6rem;overflow:hidden;}
            .av img{width:100%;height:100%;object-fit:cover;}
            .role{display:inline-block;font-size:.6rem;font-weight:700;text-transform:uppercase;padding:.15rem .6rem;border-radius:50px;background:rgba(255,123,0,.12);color:#e66a00;margin-bottom:.4rem;}
            .role.landlord{background:rgba(52,152,219,.12);color:#1f6fa8;}
            .nm{font-weight:600;font-size:.95rem;}
            .st{font-size:.75rem;color:var(--gray);margin-top:.25rem;}
            .empty{max-width:1100px;margin:3rem auto;text-align:center;color:var(--gray);}
        </style>
    </head>
    <body>
        <nav class="mini-nav">
            <a href="index.php" class="brand"><i class="fas fa-store"></i> Ebonyi Market Hub</a>
            <div class="actions">
                <a href="index.php"><i class="fas fa-home"></i> Home</a>
                <?php if ($isLoggedIn): ?>
                    <a href="dashboard.php"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
                <?php else: ?>
                    <a href="index.php"><i class="fas fa-sign-in-alt"></i> Login</a>
                <?php endif; ?>
            </div>
        </nav>
        <div class="page-head">
            <h1>Vendors &amp; Landlords</h1>
            <p style="opacity:.8;margin:.5rem 0 0;">Browse every store on Ebonyi Market Hub</p>
        </div>
        <?php if (!empty($stores)): ?>
            <div class="grid">
                <?php foreach ($stores as $s): ?>
                    <?php $nm = $s['store_name'] ?: $s['username']; ?>
                    <a href="stores.php?user_id=<?php echo (int)$s['id']; ?>" class="card-store">
                        <span class="role <?php echo $s['role'] === 'landlord' ? 'landlord' : ''; ?>"><?php echo $s['role'] === 'landlord' ? 'Landlord' : 'Vendor'; ?></span>
                        <div class="av">
                            <?php if (!empty($s['avatar_url'])): ?>
                                <img src="<?php echo htmlspecialchars($s['avatar_url']); ?>" alt="">
                            <?php else: ?>
                                <?php echo strtoupper(substr($nm, 0, 2)); ?>
                            <?php endif; ?>
                        </div>
                        <div class="nm"><?php echo htmlspecialchars($nm); ?></div>
                        <div class="st"><?php echo (int)$s['listing_count']; ?> listings
                            <?php if ($s['store_verified'] == 1): ?> • <i class="fas fa-check-circle" style="color:#007bff"></i> Verified<?php endif; ?>
                        </div>
                    </a>
                <?php endforeach; ?>
            </div>
        <?php else: ?>
            <div class="empty"><i class="fas fa-store-slash fa-3x mb-3"></i><p>No stores yet.</p></div>
        <?php endif; ?>
    </body>
    </html>
    <?php
    $conn->close();
    exit();
}

// ============================================================
// SINGLE STORE PAGE
// ============================================================

// Fetch the store owner (must be an active vendor or landlord).
// u.* is used so the query cannot fail if one optional column is missing.
$owner = null;
$stmt = $conn->prepare("SELECT u.* FROM users u
                        WHERE u.id = ? AND u.status = 'active' AND (u.is_vendor = 1 OR u.role = 'landlord')
                        LIMIT 1");
if ($stmt) {
    $stmt->bind_param("i", $user_id);
    $stmt->execute();
    $owner_result = $stmt->get_result();
    if ($owner_result && $owner_result->num_rows > 0) {
        $owner = $owner_result->fetch_assoc();
    }
    $stmt->close();
}

// Optional extra store details (separate query so a missing column or table never breaks the page)
$ss = [];
try {
    $ss_stmt = $conn->prepare("SELECT * FROM store_settings WHERE user_id = ? LIMIT 1");
    if ($ss_stmt) {
        $ss_stmt->bind_param("i", $user_id);
        $ss_stmt->execute();
        $ss_res = $ss_stmt->get_result();
        if ($ss_res && $ss_res->num_rows > 0) {
            $ss = $ss_res->fetch_assoc();
        }
        $ss_stmt->close();
    }
} catch (Throwable $e) {
    $ss = [];
}

if (!$owner) {
    ?>
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Store Not Found - Ebonyi Market Hub</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            body{font-family:'Inter',sans-serif;background:#f5f7fa;display:flex;align-items:center;justify-content:center;min-height:100vh;margin:0;text-align:center;color:#343a40;}
            .box{padding:2rem;}
            .box i{font-size:3.5rem;color:#ff7b00;margin-bottom:1rem;}
            .box h2{margin-bottom:.5rem;}
            .box a{display:inline-block;margin:1rem .3rem 0;padding:.6rem 1.5rem;background:#ff7b00;color:#fff;border-radius:50px;text-decoration:none;font-weight:600;}
        </style>
    </head>
    <body>
        <div class="box">
            <i class="fas fa-store-slash"></i>
            <h2>Store Not Found</h2>
            <p>This vendor or landlord account doesn't exist or is no longer active.</p>
            <a href="stores.php">All Stores</a><a href="index.php">Back to Home</a>
        </div>
    </body>
    </html>
    <?php
    $conn->close();
    exit();
}

// Slogan / description: the Settings page saves them on the users table,
// older accounts may still have them in store_settings, so use whichever is filled.
$store_slogan      = $owner['store_slogan'] ?? ($ss['store_slogan'] ?? '');
$store_description = $owner['store_description'] ?? '';
if ($store_description === '' || $store_description === null) {
    $store_description = $ss['store_description'] ?? '';
}
$facebook_url    = $ss['facebook_url'] ?? '';
$twitter_url     = $ss['twitter_url'] ?? '';
$instagram_url   = $ss['instagram_url'] ?? '';
$whatsapp_number = $ss['whatsapp_number'] ?? '';

$is_landlord  = ($owner['role'] === 'landlord');
$display_name = $owner['store_name'] ?: ($owner['username'] . "'s Store");
$is_own_store = ($isLoggedIn && $viewer_id == $owner['id']);

// Fetch active listings for this store
$listings = [];
$stmt = $conn->prepare("SELECT * FROM listings WHERE user_id = ? AND status = 'active' ORDER BY created_at DESC");
if ($stmt) {
    $stmt->bind_param("i", $user_id);
    $stmt->execute();
    $result = $stmt->get_result();
    while ($row = $result->fetch_assoc()) {
        $listings[] = $row;
    }
    $stmt->close();
}

// Group listings by category for tabbed browsing
$categories_present = [];
foreach ($listings as $l) {
    $cat = $l['category'] ?: 'other';
    if (!isset($categories_present[$cat])) {
        $categories_present[$cat] = [];
    }
    $categories_present[$cat][] = $l;
}

$category_labels = [
    'property'  => 'Properties',
    'land'      => 'Land',
    'apartment' => 'Apartments for Rent',
    'item'      => 'Used Items',
    'other'     => 'Other Listings',
];

// Reviews (latest 10 shown, count and average use ALL approved reviews)
$reviews = [];
$stmt = $conn->prepare("SELECT r.*, u.username AS reviewer_name
                        FROM store_reviews r
                        JOIN users u ON r.reviewer_id = u.id
                        WHERE r.store_id = ? AND r.is_approved = 1
                        ORDER BY r.created_at DESC LIMIT 10");
if ($stmt) {
    $stmt->bind_param("i", $user_id);
    $stmt->execute();
    $result = $stmt->get_result();
    while ($row = $result->fetch_assoc()) {
        $reviews[] = $row;
    }
    $stmt->close();
}

$review_count = 0;
$avg_rating = 0;
$stmt = $conn->prepare("SELECT COUNT(*) AS c, COALESCE(AVG(rating), 0) AS a FROM store_reviews WHERE store_id = ? AND is_approved = 1");
if ($stmt) {
    $stmt->bind_param("i", $user_id);
    $stmt->execute();
    $agg = $stmt->get_result()->fetch_assoc();
    $review_count = (int)($agg['c'] ?? 0);
    $avg_rating = round((float)($agg['a'] ?? 0), 1);
    $stmt->close();
}

$listing_count = count($listings);
$conn->close();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="<?php echo htmlspecialchars($display_name); ?> on Ebonyi Market Hub">
    <title><?php echo htmlspecialchars($display_name); ?> - Ebonyi Market Hub</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        :root{
            --primary:#ff7b00; --primary-dark:#e66a00; --secondary:#2c3e50;
            --light:#f8f9fa; --gray:#6c757d; --light-gray:#e9ecef;
            --shadow-sm:0 2px 8px rgba(0,0,0,.05); --shadow-md:0 5px 15px rgba(0,0,0,.1); --shadow-lg:0 10px 25px rgba(0,0,0,.15);
            --radius:12px; --radius-sm:8px;
        }
        *{margin:0;padding:0;box-sizing:border-box;font-family:'Inter',-apple-system,BlinkMacSystemFont,'Segoe UI',Roboto,sans-serif;}
        body{background:#f5f7fa;color:#343a40;line-height:1.6;}

        .mini-nav{background:#fff;box-shadow:var(--shadow-sm);padding:.9rem 5%;display:flex;align-items:center;justify-content:space-between;position:sticky;top:0;z-index:100;}
        .mini-nav a.brand{font-weight:700;color:var(--secondary);text-decoration:none;display:flex;align-items:center;gap:.5rem;}
        .mini-nav a.brand i{color:var(--primary);}
        .mini-nav .actions a{color:var(--secondary);text-decoration:none;font-weight:500;font-size:.9rem;margin-left:1.25rem;}
        .mini-nav .actions a:hover{color:var(--primary);}

        .store-hero{
            background:linear-gradient(135deg,var(--secondary) 0%,#1a2632 100%);
            color:#fff; padding:3rem 5% 5rem; position:relative;
        }
        .store-hero-inner{max-width:1100px;margin:0 auto;display:flex;gap:1.75rem;align-items:center;flex-wrap:wrap;}
        .store-avatar-lg{
            width:96px;height:96px;border-radius:50%;background:var(--primary);color:#fff;
            display:flex;align-items:center;justify-content:center;font-size:2rem;font-weight:700;flex-shrink:0;
            border:4px solid rgba(255,255,255,.15);overflow:hidden;
        }
        .store-avatar-lg img{width:100%;height:100%;object-fit:cover;}
        .store-hero h1{font-size:clamp(1.5rem,3.5vw,2.1rem);font-weight:700;display:flex;align-items:center;gap:.6rem;flex-wrap:wrap;}
        .store-hero .role-tag{
            font-size:.65rem;font-weight:700;text-transform:uppercase;letter-spacing:.5px;
            padding:.3rem .7rem;border-radius:50px;background:rgba(255,123,0,.18);color:#ffb066;
        }
        .store-hero .role-tag.landlord{background:rgba(52,152,219,.18);color:#7fc2ef;}
        .store-hero .slogan{color:rgba(255,255,255,.7);margin-top:.35rem;font-size:.95rem;}
        .store-hero .meta-row{display:flex;gap:1.5rem;flex-wrap:wrap;margin-top:1rem;font-size:.85rem;color:rgba(255,255,255,.75);}
        .store-hero .meta-row span{display:flex;align-items:center;gap:.4rem;}
        .store-hero .verified-pill{
            display:inline-flex;align-items:center;gap:.35rem;background:#007bff;color:#fff;
            padding:.25rem .75rem;border-radius:50px;font-size:.7rem;font-weight:600;
        }
        .store-hero .unverified-pill{ background:var(--gray); }
        .store-hero .rating-stars{color:#f1c40f;font-size:.85rem;}

        .store-body{max-width:1100px;margin:-2.5rem auto 0;padding:0 5% 4rem;position:relative;z-index:5;}

        .store-panel{background:#fff;border-radius:var(--radius);box-shadow:var(--shadow-md);padding:1.75rem;margin-bottom:2rem;}
        .store-panel h2{font-size:1.3rem;font-weight:700;color:var(--secondary);margin-bottom:1rem;}

        .tabs{display:flex;flex-wrap:wrap;gap:.5rem;border-bottom:1px solid var(--light-gray);margin-bottom:1.5rem;padding-bottom:.75rem;}
        .tab-btn{
            padding:.55rem 1.1rem;background:var(--light);border:none;border-radius:50px;font-weight:600;
            color:var(--gray);cursor:pointer;font-size:.85rem;transition:.2s;
        }
        .tab-btn.active{background:var(--primary);color:#fff;}
        .tab-btn:hover:not(.active){background:var(--light-gray);}
        .tab-content{display:none;}
        .tab-content.active{display:block;}

        .listings-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(240px,1fr));gap:1.25rem;}
        .listing-card{background:#fff;border:1px solid var(--light-gray);border-radius:var(--radius);overflow:hidden;transition:.25s;display:flex;flex-direction:column;}
        .listing-card:hover{transform:translateY(-4px);box-shadow:var(--shadow-lg);}
        .listing-img{height:160px;position:relative;overflow:hidden;}
        .listing-img img{width:100%;height:100%;object-fit:cover;}
        .listing-badge{position:absolute;top:.7rem;left:.7rem;background:var(--primary);color:#fff;padding:.25rem .65rem;border-radius:50px;font-size:.65rem;font-weight:700;text-transform:uppercase;}
        .listing-body{padding:1rem;flex-grow:1;display:flex;flex-direction:column;}
        .listing-body h3{font-size:.95rem;font-weight:600;color:var(--secondary);margin-bottom:.4rem;line-height:1.3;}
        .listing-body .loc{font-size:.78rem;color:var(--gray);margin-bottom:.5rem;}
        .listing-body .price{font-weight:700;color:var(--primary);font-size:1.05rem;margin-bottom:.75rem;}
        .listing-body .btn-view{
            margin-top:auto;padding:.5rem 1rem;border:2px solid var(--primary);color:var(--primary);
            background:transparent;border-radius:50px;font-weight:600;font-size:.82rem;text-align:center;
            text-decoration:none;transition:.2s;cursor:pointer;
        }
        .listing-body .btn-view:hover{background:var(--primary);color:#fff;}

        .empty-state{text-align:center;padding:3rem 1rem;color:var(--gray);}
        .empty-state i{font-size:2.5rem;margin-bottom:1rem;color:var(--light-gray);}

        .review-item{padding:1rem 0;border-bottom:1px solid var(--light-gray);}
        .review-item:last-child{border-bottom:none;}
        .review-item .rh{display:flex;justify-content:space-between;align-items:center;margin-bottom:.4rem;flex-wrap:wrap;gap:.4rem;}
        .review-item .stars{color:#f1c40f;font-size:.85rem;}
        .review-item .date{font-size:.78rem;color:var(--gray);}
        .review-item p{color:#495057;font-size:.9rem;}

        .side-card{background:#fff;border-radius:var(--radius);box-shadow:var(--shadow-sm);padding:1.5rem;}
        .side-card h3{font-size:1rem;font-weight:700;margin-bottom:1rem;color:var(--secondary);}
        .contact-row{display:flex;align-items:center;gap:.6rem;font-size:.88rem;color:#495057;margin-bottom:.85rem;word-break:break-word;}
        .contact-row i{width:28px;height:28px;background:var(--light);border-radius:8px;display:flex;align-items:center;justify-content:center;color:var(--primary);flex-shrink:0;}

        .stats-strip{display:flex;gap:1.5rem;flex-wrap:wrap;margin-top:1.25rem;}
        .stats-strip .stat{text-align:center;}
        .stats-strip .stat b{display:block;font-size:1.3rem;font-weight:700;}
        .stats-strip .stat span{font-size:.75rem;color:rgba(255,255,255,.65);}

        @media (max-width:900px){
            .store-hero-inner{flex-direction:column;text-align:center;align-items:center;}
            .store-hero .meta-row{justify-content:center;}
            .stats-strip{justify-content:center;}
        }
    </style>
</head>
<body>

    <!-- Minimal nav -->
    <nav class="mini-nav">
        <a href="index.php" class="brand"><i class="fas fa-store"></i> Ebonyi Market Hub</a>
        <div class="actions">
            <a href="index.php"><i class="fas fa-home me-1"></i> Home</a>
            <a href="stores.php"><i class="fas fa-list me-1"></i> All Stores</a>
            <?php if ($isLoggedIn): ?>
                <a href="dashboard.php"><i class="fas fa-tachometer-alt me-1"></i> Dashboard</a>
            <?php else: ?>
                <a href="index.php"><i class="fas fa-sign-in-alt me-1"></i> Login</a>
            <?php endif; ?>
        </div>
    </nav>

    <!-- Store hero -->
    <section class="store-hero">
        <div class="store-hero-inner">
            <div class="store-avatar-lg">
                <?php if (!empty($owner['avatar_url'])): ?>
                    <img src="<?php echo htmlspecialchars($owner['avatar_url']); ?>" alt="<?php echo htmlspecialchars($display_name); ?>">
                <?php else: ?>
                    <?php echo strtoupper(substr($display_name, 0, 2)); ?>
                <?php endif; ?>
            </div>
            <div style="flex:1;min-width:220px;">
                <h1>
                    <?php echo htmlspecialchars($display_name); ?>
                    <span class="role-tag <?php echo $is_landlord ? 'landlord' : ''; ?>">
                        <i class="fas <?php echo $is_landlord ? 'fa-building' : 'fa-store'; ?> me-1"></i>
                        <?php echo $is_landlord ? 'Landlord' : 'Vendor'; ?>
                    </span>
                    <?php if ($owner['store_verified'] == 1): ?>
                        <span class="verified-pill"><i class="fas fa-check"></i> Verified</span>
                    <?php else: ?>
                        <span class="verified-pill unverified-pill"><i class="fas fa-clock"></i> Not Verified</span>
                    <?php endif; ?>
                </h1>
                <?php if (!empty($store_slogan)): ?>
                    <p class="slogan"><?php echo htmlspecialchars($store_slogan); ?></p>
                <?php endif; ?>
                <div class="meta-row">
                    <span><i class="fas fa-map-marker-alt"></i> Ebonyi State, Nigeria</span>
                    <span><i class="fas fa-calendar"></i> Joined <?php echo date('M Y', strtotime($owner['created_at'])); ?></span>
                    <?php if ($avg_rating > 0): ?>
                        <span class="rating-stars">
                            <?php for ($i = 1; $i <= 5; $i++): ?>
                                <i class="fas fa-star" style="<?php echo $i <= round($avg_rating) ? '' : 'color:rgba(255,255,255,.25);'; ?>"></i>
                            <?php endfor; ?>
                            &nbsp;<?php echo $avg_rating; ?>/5
                        </span>
                    <?php endif; ?>
                </div>
                <div class="stats-strip">
                    <div class="stat"><b><?php echo $listing_count; ?></b><span>Active Listings</span></div>
                    <div class="stat"><b><?php echo $review_count; ?></b><span>Reviews</span></div>
                    <div class="stat"><b><?php echo $avg_rating > 0 ? $avg_rating : '—'; ?></b><span>Rating</span></div>
                </div>
            </div>
        </div>
    </section>

    <div class="store-body">
        <div class="row g-4">
            <div class="col-lg-8">

                <!-- About -->
                <?php if (!empty($store_description)): ?>
                <div class="store-panel">
                    <h2>About <?php echo htmlspecialchars($display_name); ?></h2>
                    <p style="color:#495057;"><?php echo nl2br(htmlspecialchars($store_description)); ?></p>
                </div>
                <?php endif; ?>

                <!-- Listings -->
                <div class="store-panel">
                    <h2><?php echo $is_landlord ? 'Available Rentals' : 'Listings'; ?></h2>

                    <?php if ($listing_count > 0): ?>
                        <?php if (count($categories_present) > 1): ?>
                            <div class="tabs">
                                <?php $first = true; ?>
                                <?php foreach ($categories_present as $cat => $items): ?>
                                    <button class="tab-btn <?php echo $first ? 'active' : ''; ?>" data-tab="cat-<?php echo md5($cat); ?>">
                                        <?php echo htmlspecialchars($category_labels[$cat] ?? ucfirst($cat)); ?> (<?php echo count($items); ?>)
                                    </button>
                                    <?php $first = false; ?>
                                <?php endforeach; ?>
                            </div>
                        <?php endif; ?>

                        <?php $first = true; ?>
                        <?php foreach ($categories_present as $cat => $items): ?>
                            <div id="cat-<?php echo md5($cat); ?>" class="tab-content <?php echo $first ? 'active' : ''; ?>">
                                <div class="listings-grid">
                                    <?php foreach ($items as $listing): ?>
                                        <div class="listing-card">
                                            <div class="listing-img">
                                                <?php
                                                $img = !empty($listing['image']) ? htmlspecialchars($listing['image'])
                                                     : 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=500&q=80';
                                                ?>
                                                <img src="<?php echo $img; ?>" alt="<?php echo htmlspecialchars($listing['title']); ?>" loading="lazy">
                                                <span class="listing-badge"><?php echo htmlspecialchars(ucfirst($listing['category'])); ?></span>
                                            </div>
                                            <div class="listing-body">
                                                <h3><?php echo htmlspecialchars(substr($listing['title'], 0, 45)); ?></h3>
                                                <div class="loc"><i class="fas fa-map-marker-alt me-1"></i><?php echo htmlspecialchars($listing['location']); ?></div>
                                                <?php if (!empty($listing['price'])): ?>
                                                    <div class="price">₦<?php echo number_format($listing['price']); ?></div>
                                                <?php endif; ?>
                                                <?php
                                                $is_property = is_property_category($listing['category']);
                                                $detail_page = $is_property ? 'property_details.php' : 'item_details.php';
                                                ?>
                                                <?php if ($isLoggedIn): ?>
                                                    <a href="<?php echo $detail_page; ?>?id=<?php echo (int)$listing['id']; ?>" class="btn-view">
                                                        <?php echo $is_property ? 'View & Inquire' : 'View & Order'; ?>
                                                    </a>
                                                <?php else: ?>
                                                    <button class="btn-view" onclick="requireLogin()">
                                                        View Details
                                                    </button>
                                                <?php endif; ?>
                                            </div>
                                        </div>
                                    <?php endforeach; ?>
                                </div>
                            </div>
                            <?php $first = false; ?>
                        <?php endforeach; ?>

                    <?php else: ?>
                        <div class="empty-state">
                            <i class="fas fa-box-open"></i>
                            <p>This <?php echo $is_landlord ? 'landlord' : 'vendor'; ?> hasn't posted any active listings yet.</p>
                        </div>
                    <?php endif; ?>
                </div>

                <!-- Reviews -->
                <div class="store-panel">
                    <h2>Reviews <?php echo $review_count > 0 ? "($review_count)" : ''; ?></h2>
                    <?php if (!empty($reviews)): ?>
                        <?php foreach ($reviews as $review): ?>
                            <div class="review-item">
                                <div class="rh">
                                    <strong><?php echo htmlspecialchars($review['reviewer_name']); ?></strong>
                                    <span class="date"><?php echo date('M d, Y', strtotime($review['created_at'])); ?></span>
                                </div>
                                <div class="stars">
                                    <?php for ($i = 1; $i <= 5; $i++): ?>
                                        <i class="fas fa-star" style="<?php echo $i <= $review['rating'] ? '' : 'color:#ddd;'; ?>"></i>
                                    <?php endfor; ?>
                                </div>
                                <p><?php echo htmlspecialchars($review['review_text'] ?? ''); ?></p>
                            </div>
                        <?php endforeach; ?>
                    <?php else: ?>
                        <div class="empty-state">
                            <i class="fas fa-star"></i>
                            <p>No reviews yet.</p>
                        </div>
                    <?php endif; ?>
                </div>
            </div>

            <!-- Sidebar: contact card -->
            <div class="col-lg-4">
                <div class="side-card">
                    <h3><i class="fas fa-address-card me-2"></i>Contact <?php echo $is_landlord ? 'Landlord' : 'Vendor'; ?></h3>

                    <?php if ($isLoggedIn && !$is_own_store): ?>
                        <div class="contact-row"><i class="fas fa-phone"></i> <?php echo htmlspecialchars($owner['phone'] ?: 'Not provided'); ?></div>
                        <div class="contact-row"><i class="fas fa-envelope"></i> <?php echo htmlspecialchars($owner['email']); ?></div>
                        <?php if (!empty($whatsapp_number)): ?>
                            <a href="https://wa.me/<?php echo preg_replace('/[^0-9]/', '', $whatsapp_number); ?>" target="_blank" class="btn btn-success w-100 mb-2">
                                <i class="fab fa-whatsapp me-2"></i>WhatsApp
                            </a>
                        <?php endif; ?>
                        <?php if (!empty($owner['phone'])): ?>
                            <a href="tel:<?php echo htmlspecialchars($owner['phone']); ?>" class="btn btn-outline-secondary w-100" style="border-radius:50px;">
                                <i class="fas fa-phone me-2"></i>Call
                            </a>
                        <?php endif; ?>
                    <?php elseif ($is_own_store): ?>
                        <p class="text-muted small">This is your own storefront. Visitors see your contact details here.</p>
                        <a href="dashboard.php" class="btn btn-primary w-100" style="border-radius:50px;">
                            <i class="fas fa-tachometer-alt me-2"></i>Go to Dashboard
                        </a>
                    <?php else: ?>
                        <p class="text-muted small">Login to view contact details and place an order or inquiry.</p>
                        <a href="index.php" class="btn btn-primary w-100" style="border-radius:50px;">
                            <i class="fas fa-sign-in-alt me-2"></i>Login to Contact
                        </a>
                    <?php endif; ?>

                    <?php if (!empty($facebook_url) || !empty($instagram_url) || !empty($twitter_url)): ?>
                        <hr class="my-3">
                        <div class="d-flex gap-2 justify-content-center">
                            <?php if (!empty($facebook_url)): ?><a href="<?php echo htmlspecialchars($facebook_url); ?>" target="_blank" class="btn btn-sm btn-outline-secondary rounded-circle"><i class="fab fa-facebook-f"></i></a><?php endif; ?>
                            <?php if (!empty($instagram_url)): ?><a href="<?php echo htmlspecialchars($instagram_url); ?>" target="_blank" class="btn btn-sm btn-outline-secondary rounded-circle"><i class="fab fa-instagram"></i></a><?php endif; ?>
                            <?php if (!empty($twitter_url)): ?><a href="<?php echo htmlspecialchars($twitter_url); ?>" target="_blank" class="btn btn-sm btn-outline-secondary rounded-circle"><i class="fab fa-twitter"></i></a><?php endif; ?>
                        </div>
                    <?php endif; ?>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Tabs
        document.querySelectorAll('.tab-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
                document.querySelectorAll('.tab-content').forEach(c => c.classList.remove('active'));
                this.classList.add('active');
                document.getElementById(this.dataset.tab).classList.add('active');
            });
        });

        // Require login before viewing a listing's full detail/order page
        function requireLogin() {
            const modalHTML = `
                <div class="modal fade" id="loginNoticeModal" tabindex="-1">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title"><i class="fas fa-user-lock text-warning me-2"></i>Login Required</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body text-center py-4">
                                <p class="mb-3">Please login to view full details and place an order or inquiry.</p>
                                <a href="index.php" class="btn btn-primary"><i class="fas fa-sign-in-alt me-2"></i>Go to Login</a>
                            </div>
                        </div>
                    </div>
                </div>`;
            const existing = document.getElementById('loginNoticeModal');
            if (existing) existing.remove();
            document.body.insertAdjacentHTML('beforeend', modalHTML);
            new bootstrap.Modal(document.getElementById('loginNoticeModal')).show();
        }
    </script>
</body>
</html>