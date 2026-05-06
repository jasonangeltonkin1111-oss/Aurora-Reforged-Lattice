#ifndef ASC_TYPES_ARTIFACTS_MQH
#define ASC_TYPES_ARTIFACTS_MQH

#include "ASC_Enums.mqh"

// Stage 1 artifact metadata scaffolding only.
// Payload construction and landing behavior belong to later stages.

struct ASC_ArtifactBuildIdentity
  {
   string BuildId;
   string GenerationId;
   string DependencySetId;
   string RuntimeSessionId;
  };

struct ASC_ArtifactLineageRef
  {
   string UpstreamArtifactId;
   string UpstreamGenerationId;
   string UpstreamOwnerKey;
  };

struct ASC_ArtifactScope
  {
   string ServerName;
   string SymbolKey;
   string BucketKey;
   string PageKey;
  };

struct ASC_ArtifactMetadata
  {
   string ArtifactId;
   string ArtifactName;
   string ArtifactKind;
   string SchemaVersion;

   ASC_ArtifactFamily Family;
   ASC_ArtifactOwnerDomain OwnerDomain;

   ASC_FreshnessPosture Freshness;
   ASC_CompletenessPosture Completeness;
   ASC_ContinuityPosture Continuity;
   ASC_CoherencePosture Coherence;
   ASC_LandingPosture Landing;
   ASC_RestoreTrustPosture RestoreTrust;

   ASC_ArtifactBuildIdentity Build;
   ASC_ArtifactScope Scope;
   ASC_ArtifactLineageRef PrimaryLineage;

   datetime BuiltAt;
   datetime LandedAt;
   datetime SourceObservedAt;
  };

struct ASC_ArtifactPublishRequest
  {
   ASC_ArtifactMetadata Metadata;
   string PayloadOwnerKey;
   bool RequiresAtomicLanding;
   bool PreserveLastGood;
  };

struct ASC_ArtifactPublishResult
  {
   ASC_ArtifactMetadata Metadata;
   bool Accepted;
   bool Landed;
   string ResultNote;
  };

#endif // ASC_TYPES_ARTIFACTS_MQH
