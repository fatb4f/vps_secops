# DefaultApi

All URIs are relative to *https://secops.example.local*

| Method | HTTP request | Description |
|------------- | ------------- | -------------|
| [**executeGuardrailAction**](DefaultApi.md#executeguardrailaction) | **POST** /v1/guardrails/execute | Execute approved safe automated response |
| [**getPipelineHealth**](DefaultApi.md#getpipelinehealth) | **GET** /v1/health/pipeline | Pipeline health and freshness |
| [**ingestPack**](DefaultApi.md#ingestpack) | **POST** /v1/packs/ingest | Ingest baseline pack |
| [**listPacks**](DefaultApi.md#listpacks) | **GET** /v1/packs | List packs |
| [**promoteIncident**](DefaultApi.md#promoteincident) | **POST** /v1/incidents/promote | Promote triage outcome into an incident |
| [**runTriage**](DefaultApi.md#runtriage) | **POST** /v1/triage/run | Run initial enrichment triage |



## executeGuardrailAction

> GuardrailActionV1 executeGuardrailAction(guardrailActionV1)

Execute approved safe automated response

### Example

```ts
import {
  Configuration,
  DefaultApi,
} from '@vps-secops/client';
import type { ExecuteGuardrailActionRequest } from '@vps-secops/client';

async function example() {
  console.log("🚀 Testing @vps-secops/client SDK...");
  const api = new DefaultApi();

  const body = {
    // GuardrailActionV1
    guardrailActionV1: ...,
  } satisfies ExecuteGuardrailActionRequest;

  try {
    const data = await api.executeGuardrailAction(body);
    console.log(data);
  } catch (error) {
    console.error(error);
  }
}

// Run the test
example().catch(console.error);
```

### Parameters


| Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **guardrailActionV1** | [GuardrailActionV1](GuardrailActionV1.md) |  | |

### Return type

[**GuardrailActionV1**](GuardrailActionV1.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: `application/json`
- **Accept**: `application/json`


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **200** | Action execution result |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)


## getPipelineHealth

> GetPipelineHealth200Response getPipelineHealth()

Pipeline health and freshness

### Example

```ts
import {
  Configuration,
  DefaultApi,
} from '@vps-secops/client';
import type { GetPipelineHealthRequest } from '@vps-secops/client';

async function example() {
  console.log("🚀 Testing @vps-secops/client SDK...");
  const api = new DefaultApi();

  try {
    const data = await api.getPipelineHealth();
    console.log(data);
  } catch (error) {
    console.error(error);
  }
}

// Run the test
example().catch(console.error);
```

### Parameters

This endpoint does not need any parameter.

### Return type

[**GetPipelineHealth200Response**](GetPipelineHealth200Response.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: `application/json`


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **200** | Current pipeline health |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)


## ingestPack

> IngestPack202Response ingestPack(baselinePackV1)

Ingest baseline pack

### Example

```ts
import {
  Configuration,
  DefaultApi,
} from '@vps-secops/client';
import type { IngestPackRequest } from '@vps-secops/client';

async function example() {
  console.log("🚀 Testing @vps-secops/client SDK...");
  const api = new DefaultApi();

  const body = {
    // BaselinePackV1
    baselinePackV1: ...,
  } satisfies IngestPackRequest;

  try {
    const data = await api.ingestPack(body);
    console.log(data);
  } catch (error) {
    console.error(error);
  }
}

// Run the test
example().catch(console.error);
```

### Parameters


| Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **baselinePackV1** | [BaselinePackV1](BaselinePackV1.md) |  | |

### Return type

[**IngestPack202Response**](IngestPack202Response.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: `application/json`
- **Accept**: `application/json`


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **202** | Accepted for verification and indexing |  -  |
| **400** | Invalid request body |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)


## listPacks

> Array&lt;ListPacks200ResponseInner&gt; listPacks(host, from, to)

List packs

### Example

```ts
import {
  Configuration,
  DefaultApi,
} from '@vps-secops/client';
import type { ListPacksRequest } from '@vps-secops/client';

async function example() {
  console.log("🚀 Testing @vps-secops/client SDK...");
  const api = new DefaultApi();

  const body = {
    // string (optional)
    host: host_example,
    // Date (optional)
    from: 2013-10-20T19:20:30+01:00,
    // Date (optional)
    to: 2013-10-20T19:20:30+01:00,
  } satisfies ListPacksRequest;

  try {
    const data = await api.listPacks(body);
    console.log(data);
  } catch (error) {
    console.error(error);
  }
}

// Run the test
example().catch(console.error);
```

### Parameters


| Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **host** | `string` |  | [Optional] [Defaults to `undefined`] |
| **from** | `Date` |  | [Optional] [Defaults to `undefined`] |
| **to** | `Date` |  | [Optional] [Defaults to `undefined`] |

### Return type

[**Array&lt;ListPacks200ResponseInner&gt;**](ListPacks200ResponseInner.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: `application/json`


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **200** | Pack list |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)


## promoteIncident

> PromoteIncident201Response promoteIncident(triageDecisionV1)

Promote triage outcome into an incident

### Example

```ts
import {
  Configuration,
  DefaultApi,
} from '@vps-secops/client';
import type { PromoteIncidentRequest } from '@vps-secops/client';

async function example() {
  console.log("🚀 Testing @vps-secops/client SDK...");
  const api = new DefaultApi();

  const body = {
    // TriageDecisionV1
    triageDecisionV1: ...,
  } satisfies PromoteIncidentRequest;

  try {
    const data = await api.promoteIncident(body);
    console.log(data);
  } catch (error) {
    console.error(error);
  }
}

// Run the test
example().catch(console.error);
```

### Parameters


| Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **triageDecisionV1** | [TriageDecisionV1](TriageDecisionV1.md) |  | |

### Return type

[**PromoteIncident201Response**](PromoteIncident201Response.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: `application/json`
- **Accept**: `application/json`


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **201** | Incident created |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)


## runTriage

> TriageDecisionV1 runTriage(eventEnvelopeV1)

Run initial enrichment triage

### Example

```ts
import {
  Configuration,
  DefaultApi,
} from '@vps-secops/client';
import type { RunTriageRequest } from '@vps-secops/client';

async function example() {
  console.log("🚀 Testing @vps-secops/client SDK...");
  const api = new DefaultApi();

  const body = {
    // EventEnvelopeV1
    eventEnvelopeV1: ...,
  } satisfies RunTriageRequest;

  try {
    const data = await api.runTriage(body);
    console.log(data);
  } catch (error) {
    console.error(error);
  }
}

// Run the test
example().catch(console.error);
```

### Parameters


| Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **eventEnvelopeV1** | [EventEnvelopeV1](EventEnvelopeV1.md) |  | |

### Return type

[**TriageDecisionV1**](TriageDecisionV1.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: `application/json`
- **Accept**: `application/json`


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **200** | Triage completed |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

