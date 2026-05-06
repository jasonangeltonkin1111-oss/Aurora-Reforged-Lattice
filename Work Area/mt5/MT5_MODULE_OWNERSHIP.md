# MT5 Module Ownership

This file records the intended owner for each MT5 module family.

| Folder | Owns | Must Not Own |
|---|---|---|
| core/ | version, constants, shared types, result codes | runtime behavior, formulas |
| runtime/ | heartbeat, scheduler, warmup, cadence, budget | ranking, file writing, dossier prose |
| io/ | paths, atomic publication, manifests, output contracts | ranking, business decisions |
| telemetry/ | status, errors, runtime metrics | market truth ownership |
| account/ | account info, positions, orders, deals, exposure map | trading decisions |
| universe/ | Market Watch universe, symbol registry, symbol identity | bucket/rank formulas |
| buckets/ | major/minor bucket classification | scoring |
| layer1_market_state/ | open/closed/unknown market state | specs or ranking |
| layer2_symbol_specs/ | broker specs, spread, constraints, spec cache | scoring ownership |
| indicators/ | handles, buffer readiness, indicator facts | fake zero values, strategy signals |
| layer3_surface_rank/ | surface numeric scoring and rank table | group ranking, deep review |
| layer4_bucket_rank/ | global top 10, major top 5, minor top 5, active set | L3 formulas |
| layer5_deep_review/ | deep review for active set/manual requests | trade entry or signal permission |
| market_board/ | operator board and upload suggestion | hidden calculations |
| dossiers/ | numeric-first symbol dossier composition | hidden layer calculations |
| permission/ | no-trade/no-signal/no-execution boundary | exceptions |
| debug/ | scaffold/source sanity checks | proof inflation |
| tests/ | future static/output harnesses | runtime trading |
