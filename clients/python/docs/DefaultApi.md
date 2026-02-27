# vps_secops_client.DefaultApi

All URIs are relative to *https://secops.example.local*

Method | HTTP request | Description
------------- | ------------- | -------------
[**execute_guardrail_action**](DefaultApi.md#execute_guardrail_action) | **POST** /v1/guardrails/execute | Execute approved safe automated response
[**get_pipeline_health**](DefaultApi.md#get_pipeline_health) | **GET** /v1/health/pipeline | Pipeline health and freshness
[**ingest_pack**](DefaultApi.md#ingest_pack) | **POST** /v1/packs/ingest | Ingest baseline pack
[**list_packs**](DefaultApi.md#list_packs) | **GET** /v1/packs | List packs
[**promote_incident**](DefaultApi.md#promote_incident) | **POST** /v1/incidents/promote | Promote triage outcome into an incident
[**run_triage**](DefaultApi.md#run_triage) | **POST** /v1/triage/run | Run initial enrichment triage


# **execute_guardrail_action**
> GuardrailActionV1 execute_guardrail_action(guardrail_action_v1)

Execute approved safe automated response

### Example


```python
import vps_secops_client
from vps_secops_client.models.guardrail_action_v1 import GuardrailActionV1
from vps_secops_client.rest import ApiException
from pprint import pprint

# Defining the host is optional and defaults to https://secops.example.local
# See configuration.py for a list of all supported configuration parameters.
configuration = vps_secops_client.Configuration(
    host = "https://secops.example.local"
)


# Enter a context with an instance of the API client
with vps_secops_client.ApiClient(configuration) as api_client:
    # Create an instance of the API class
    api_instance = vps_secops_client.DefaultApi(api_client)
    guardrail_action_v1 = vps_secops_client.GuardrailActionV1() # GuardrailActionV1 | 

    try:
        # Execute approved safe automated response
        api_response = api_instance.execute_guardrail_action(guardrail_action_v1)
        print("The response of DefaultApi->execute_guardrail_action:\n")
        pprint(api_response)
    except Exception as e:
        print("Exception when calling DefaultApi->execute_guardrail_action: %s\n" % e)
```



### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **guardrail_action_v1** | [**GuardrailActionV1**](GuardrailActionV1.md)|  | 

### Return type

[**GuardrailActionV1**](GuardrailActionV1.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

### HTTP response details

| Status code | Description | Response headers |
|-------------|-------------|------------------|
**200** | Action execution result |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **get_pipeline_health**
> GetPipelineHealth200Response get_pipeline_health()

Pipeline health and freshness

### Example


```python
import vps_secops_client
from vps_secops_client.models.get_pipeline_health200_response import GetPipelineHealth200Response
from vps_secops_client.rest import ApiException
from pprint import pprint

# Defining the host is optional and defaults to https://secops.example.local
# See configuration.py for a list of all supported configuration parameters.
configuration = vps_secops_client.Configuration(
    host = "https://secops.example.local"
)


# Enter a context with an instance of the API client
with vps_secops_client.ApiClient(configuration) as api_client:
    # Create an instance of the API class
    api_instance = vps_secops_client.DefaultApi(api_client)

    try:
        # Pipeline health and freshness
        api_response = api_instance.get_pipeline_health()
        print("The response of DefaultApi->get_pipeline_health:\n")
        pprint(api_response)
    except Exception as e:
        print("Exception when calling DefaultApi->get_pipeline_health: %s\n" % e)
```



### Parameters

This endpoint does not need any parameter.

### Return type

[**GetPipelineHealth200Response**](GetPipelineHealth200Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

### HTTP response details

| Status code | Description | Response headers |
|-------------|-------------|------------------|
**200** | Current pipeline health |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **ingest_pack**
> IngestPack202Response ingest_pack(baseline_pack_v1)

Ingest baseline pack

### Example


```python
import vps_secops_client
from vps_secops_client.models.baseline_pack_v1 import BaselinePackV1
from vps_secops_client.models.ingest_pack202_response import IngestPack202Response
from vps_secops_client.rest import ApiException
from pprint import pprint

# Defining the host is optional and defaults to https://secops.example.local
# See configuration.py for a list of all supported configuration parameters.
configuration = vps_secops_client.Configuration(
    host = "https://secops.example.local"
)


# Enter a context with an instance of the API client
with vps_secops_client.ApiClient(configuration) as api_client:
    # Create an instance of the API class
    api_instance = vps_secops_client.DefaultApi(api_client)
    baseline_pack_v1 = vps_secops_client.BaselinePackV1() # BaselinePackV1 | 

    try:
        # Ingest baseline pack
        api_response = api_instance.ingest_pack(baseline_pack_v1)
        print("The response of DefaultApi->ingest_pack:\n")
        pprint(api_response)
    except Exception as e:
        print("Exception when calling DefaultApi->ingest_pack: %s\n" % e)
```



### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **baseline_pack_v1** | [**BaselinePackV1**](BaselinePackV1.md)|  | 

### Return type

[**IngestPack202Response**](IngestPack202Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

### HTTP response details

| Status code | Description | Response headers |
|-------------|-------------|------------------|
**202** | Accepted for verification and indexing |  -  |
**400** | Invalid request body |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **list_packs**
> List[ListPacks200ResponseInner] list_packs(host=host, var_from=var_from, to=to)

List packs

### Example


```python
import vps_secops_client
from vps_secops_client.models.list_packs200_response_inner import ListPacks200ResponseInner
from vps_secops_client.rest import ApiException
from pprint import pprint

# Defining the host is optional and defaults to https://secops.example.local
# See configuration.py for a list of all supported configuration parameters.
configuration = vps_secops_client.Configuration(
    host = "https://secops.example.local"
)


# Enter a context with an instance of the API client
with vps_secops_client.ApiClient(configuration) as api_client:
    # Create an instance of the API class
    api_instance = vps_secops_client.DefaultApi(api_client)
    host = 'host_example' # str |  (optional)
    var_from = '2013-10-20T19:20:30+01:00' # datetime |  (optional)
    to = '2013-10-20T19:20:30+01:00' # datetime |  (optional)

    try:
        # List packs
        api_response = api_instance.list_packs(host=host, var_from=var_from, to=to)
        print("The response of DefaultApi->list_packs:\n")
        pprint(api_response)
    except Exception as e:
        print("Exception when calling DefaultApi->list_packs: %s\n" % e)
```



### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **host** | **str**|  | [optional] 
 **var_from** | **datetime**|  | [optional] 
 **to** | **datetime**|  | [optional] 

### Return type

[**List[ListPacks200ResponseInner]**](ListPacks200ResponseInner.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

### HTTP response details

| Status code | Description | Response headers |
|-------------|-------------|------------------|
**200** | Pack list |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **promote_incident**
> PromoteIncident201Response promote_incident(triage_decision_v1)

Promote triage outcome into an incident

### Example


```python
import vps_secops_client
from vps_secops_client.models.promote_incident201_response import PromoteIncident201Response
from vps_secops_client.models.triage_decision_v1 import TriageDecisionV1
from vps_secops_client.rest import ApiException
from pprint import pprint

# Defining the host is optional and defaults to https://secops.example.local
# See configuration.py for a list of all supported configuration parameters.
configuration = vps_secops_client.Configuration(
    host = "https://secops.example.local"
)


# Enter a context with an instance of the API client
with vps_secops_client.ApiClient(configuration) as api_client:
    # Create an instance of the API class
    api_instance = vps_secops_client.DefaultApi(api_client)
    triage_decision_v1 = vps_secops_client.TriageDecisionV1() # TriageDecisionV1 | 

    try:
        # Promote triage outcome into an incident
        api_response = api_instance.promote_incident(triage_decision_v1)
        print("The response of DefaultApi->promote_incident:\n")
        pprint(api_response)
    except Exception as e:
        print("Exception when calling DefaultApi->promote_incident: %s\n" % e)
```



### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **triage_decision_v1** | [**TriageDecisionV1**](TriageDecisionV1.md)|  | 

### Return type

[**PromoteIncident201Response**](PromoteIncident201Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

### HTTP response details

| Status code | Description | Response headers |
|-------------|-------------|------------------|
**201** | Incident created |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **run_triage**
> TriageDecisionV1 run_triage(event_envelope_v1)

Run initial enrichment triage

### Example


```python
import vps_secops_client
from vps_secops_client.models.event_envelope_v1 import EventEnvelopeV1
from vps_secops_client.models.triage_decision_v1 import TriageDecisionV1
from vps_secops_client.rest import ApiException
from pprint import pprint

# Defining the host is optional and defaults to https://secops.example.local
# See configuration.py for a list of all supported configuration parameters.
configuration = vps_secops_client.Configuration(
    host = "https://secops.example.local"
)


# Enter a context with an instance of the API client
with vps_secops_client.ApiClient(configuration) as api_client:
    # Create an instance of the API class
    api_instance = vps_secops_client.DefaultApi(api_client)
    event_envelope_v1 = vps_secops_client.EventEnvelopeV1() # EventEnvelopeV1 | 

    try:
        # Run initial enrichment triage
        api_response = api_instance.run_triage(event_envelope_v1)
        print("The response of DefaultApi->run_triage:\n")
        pprint(api_response)
    except Exception as e:
        print("Exception when calling DefaultApi->run_triage: %s\n" % e)
```



### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **event_envelope_v1** | [**EventEnvelopeV1**](EventEnvelopeV1.md)|  | 

### Return type

[**TriageDecisionV1**](TriageDecisionV1.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

### HTTP response details

| Status code | Description | Response headers |
|-------------|-------------|------------------|
**200** | Triage completed |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

