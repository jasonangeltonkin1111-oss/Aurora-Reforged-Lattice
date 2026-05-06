#ifndef __ASC_CLASSIFICATION_AUTHORITY_MQH__
#define __ASC_CLASSIFICATION_AUTHORITY_MQH__

// Canonical runtime authority seam for classification consumption.
// Classification production still lives in ASC_ClassificationBridge.mqh.
// Consumers (Market Board / HUD / menu-facing surfaces) should read via this file.
#include "ASC_ClassificationBridge.mqh"

struct ASC_ClassificationAuthoritySnapshot
  {
   string authority_path;
   string main_bucket_id;
   string main_bucket_name;
   string sub_bucket_id;
   string sub_bucket_name;
   string sub_bucket_source;
   string hierarchy_l1_id;
   string hierarchy_l1_name;
   string hierarchy_l2_id;
   string hierarchy_l2_name;
   string hierarchy_l3_id;
   string hierarchy_l3_name;

   // Prompt-1 staging fields for deeper stock hierarchy lanes (Prompt 2+).
   string stock_family_id;
   string stock_family_name;
   string stock_venue_family_id;
   string stock_venue_family_name;
   string stock_product_family_id;
   string stock_product_family_name;
   string stock_family_review_state;
   string stock_sector_id;
   string stock_sector_resolution_state;
   string stock_sector_source;
   string stock_industry_id;
   string stock_industry_resolution_state;
   string stock_industry_source;
   string stock_sub_industry_id;
   string stock_sub_industry_resolution_state;
   string stock_sub_industry_source;
   string stock_venue_region_id;
   string stock_venue_region_name;
   string stock_sector_name;
   string stock_industry_name;
   string stock_sub_industry_name;
   string stock_special_family_tag;

   string authority_label;
  };

string ASC_ClassificationAuthoritySourcePath()
  {
   return "mt5/symbols/ASC_ClassificationAuthority.mqh";
  }

void ASC_ClassificationBuildAuthoritySnapshot(const ASC_SymbolClassification &classification,
                                              ASC_ClassificationAuthoritySnapshot &snapshot)
  {
   snapshot.authority_path = "classification_authority_v1_bridge_seed";
   snapshot.main_bucket_id = ASC_ClassificationEffectiveMainBucketId(classification);
   snapshot.main_bucket_name = ASC_ClassificationMainBucketName(snapshot.main_bucket_id);
   snapshot.sub_bucket_id = ASC_ClassificationEffectiveSubBucketId(classification);
   snapshot.sub_bucket_name = ASC_ClassificationEffectiveSubBucketName(classification);
   snapshot.sub_bucket_source = classification.sub_bucket_source;
   snapshot.hierarchy_l1_id = classification.hierarchy_l1_id;
   snapshot.hierarchy_l1_name = classification.hierarchy_l1_name;
   snapshot.hierarchy_l2_id = classification.hierarchy_l2_id;
   snapshot.hierarchy_l2_name = classification.hierarchy_l2_name;
   snapshot.hierarchy_l3_id = classification.hierarchy_l3_id;
   snapshot.hierarchy_l3_name = classification.hierarchy_l3_name;

   snapshot.stock_family_id = classification.stock_family_id;
   snapshot.stock_family_name = classification.stock_family_name;
   snapshot.stock_venue_family_id = classification.stock_venue_family_id;
   snapshot.stock_venue_family_name = classification.stock_venue_family_name;
   snapshot.stock_product_family_id = classification.stock_product_family_id;
   snapshot.stock_product_family_name = classification.stock_product_family_name;
   snapshot.stock_family_review_state = classification.stock_family_review_state;
   snapshot.stock_sector_id = classification.stock_sector_id;
   snapshot.stock_sector_resolution_state = classification.stock_sector_resolution_state;
   snapshot.stock_sector_source = classification.stock_sector_source;
   snapshot.stock_industry_id = classification.stock_industry_id;
   snapshot.stock_industry_resolution_state = classification.stock_industry_resolution_state;
   snapshot.stock_industry_source = classification.stock_industry_source;
   snapshot.stock_sub_industry_id = classification.stock_sub_industry_id;
   snapshot.stock_sub_industry_resolution_state = classification.stock_sub_industry_resolution_state;
   snapshot.stock_sub_industry_source = classification.stock_sub_industry_source;
   snapshot.stock_venue_region_id = classification.stock_venue_region_id;
   snapshot.stock_venue_region_name = classification.stock_venue_region_name;
   snapshot.stock_sector_name = classification.stock_sector_name;
   snapshot.stock_industry_name = classification.stock_industry_name;
   snapshot.stock_sub_industry_name = classification.stock_sub_industry_name;
   snapshot.stock_special_family_tag = classification.stock_special_family_tag;

   snapshot.authority_label = ASC_ClassificationAuthoritySource(classification);
  }

string ASC_ClassificationCanonicalMainBucketId(const ASC_SymbolClassification &classification)
  {
   // Hot-path accessor: avoid full snapshot materialization for single-field reads.
   return ASC_ClassificationEffectiveMainBucketId(classification);
  }

string ASC_ClassificationCanonicalMainBucketName(const ASC_SymbolClassification &classification)
  {
   return ASC_ClassificationMainBucketName(ASC_ClassificationCanonicalMainBucketId(classification));
  }

string ASC_ClassificationCanonicalSubBucketId(const ASC_SymbolClassification &classification)
  {
   return ASC_ClassificationEffectiveSubBucketId(classification);
  }

string ASC_ClassificationCanonicalSubBucketName(const ASC_SymbolClassification &classification)
  {
   return ASC_ClassificationEffectiveSubBucketName(classification);
  }

string ASC_ClassificationCanonicalAuthorityLabel(const ASC_SymbolClassification &classification)
  {
   return ASC_ClassificationAuthoritySource(classification);
  }

#endif
