#ifndef ASC_CONFIG_DEFAULTS_MQH
#define ASC_CONFIG_DEFAULTS_MQH

// Aurora Sentinel Core defaults for the Layer 1 market-open truth repair pass.
// This file owns small, compile-safe constants only.
// It does not own scan logic, file composition, or later-stage thresholds.

#define ASC_DEFAULT_HEARTBEAT_SECONDS 1
#define ASC_MIN_HEARTBEAT_SECONDS 1
#define ASC_MAX_HEARTBEAT_SECONDS 60
#define ASC_DEFAULT_SHOW_CHART_STATUS true

#define ASC_DEFAULT_PRODUCT_NAME    "Aurora Sentinel Core"
// Updated build metadata after row-height bug fix and Layer 1 posture hardening.
// Updated build metadata for the top‑chrome collapse and navigation grammar cleanup pass.
// Updated build metadata for the navigation & pagination enhancement pass.
#define ASC_DEFAULT_BUILD_NAME      "Aurora Sentinel Core - Navigation & Pagination Enhancement"
#define ASC_DEFAULT_PRODUCT_VERSION "1.027"

#define ASC_LAYER1_TICK_FRESH_SECONDS 300
#define ASC_LAYER1_STALE_TICK_SECONDS 86400
#define ASC_LAYER1_SCAN_LOG_INTERVAL_SECONDS 60
#define ASC_LAYER1_DECISION_LOG_THROTTLE_SECONDS 300
#define ASC_LAYER1_MAX_DECISION_LOGS_PER_SCAN 5

#define ASC_PUBLICATION_DOSSIER_FOLDER "Dossiers"

#endif // ASC_CONFIG_DEFAULTS_MQH
