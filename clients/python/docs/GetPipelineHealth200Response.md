# GetPipelineHealth200Response


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**status** | **str** |  | 
**latest_pack_age_sec** | **int** |  | 
**packs_last_24h** | **int** |  | 
**expected_packs_last_24h** | **int** |  | [optional] 
**coverage_pct** | **float** |  | [optional] 

## Example

```python
from vps_secops_client.models.get_pipeline_health200_response import GetPipelineHealth200Response

# TODO update the JSON string below
json = "{}"
# create an instance of GetPipelineHealth200Response from a JSON string
get_pipeline_health200_response_instance = GetPipelineHealth200Response.from_json(json)
# print the JSON string representation of the object
print(GetPipelineHealth200Response.to_json())

# convert the object into a dict
get_pipeline_health200_response_dict = get_pipeline_health200_response_instance.to_dict()
# create an instance of GetPipelineHealth200Response from a dict
get_pipeline_health200_response_from_dict = GetPipelineHealth200Response.from_dict(get_pipeline_health200_response_dict)
```
[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


