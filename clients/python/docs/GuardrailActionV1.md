# GuardrailActionV1


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**schema_version** | **object** |  | 
**action_id** | **str** |  | 
**action_type** | **str** |  | 
**target** | **str** |  | 
**status** | **str** |  | 
**started_at_utc** | **datetime** |  | 
**ended_at_utc** | **datetime** |  | 
**result_message** | **str** |  | [optional] 
**rollback_ref** | **str** |  | [optional] 

## Example

```python
from vps_secops_client.models.guardrail_action_v1 import GuardrailActionV1

# TODO update the JSON string below
json = "{}"
# create an instance of GuardrailActionV1 from a JSON string
guardrail_action_v1_instance = GuardrailActionV1.from_json(json)
# print the JSON string representation of the object
print(GuardrailActionV1.to_json())

# convert the object into a dict
guardrail_action_v1_dict = guardrail_action_v1_instance.to_dict()
# create an instance of GuardrailActionV1 from a dict
guardrail_action_v1_from_dict = GuardrailActionV1.from_dict(guardrail_action_v1_dict)
```
[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


