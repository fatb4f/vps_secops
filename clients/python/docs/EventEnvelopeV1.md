# EventEnvelopeV1


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**schema_version** | **object** |  | 
**event_id** | **str** |  | 
**event_type** | **str** |  | 
**host_id** | **str** |  | 
**collected_at_utc** | **datetime** |  | 
**payload** | **object** |  | 
**labels** | **List[str]** |  | [optional] 

## Example

```python
from vps_secops_client.models.event_envelope_v1 import EventEnvelopeV1

# TODO update the JSON string below
json = "{}"
# create an instance of EventEnvelopeV1 from a JSON string
event_envelope_v1_instance = EventEnvelopeV1.from_json(json)
# print the JSON string representation of the object
print(EventEnvelopeV1.to_json())

# convert the object into a dict
event_envelope_v1_dict = event_envelope_v1_instance.to_dict()
# create an instance of EventEnvelopeV1 from a dict
event_envelope_v1_from_dict = EventEnvelopeV1.from_dict(event_envelope_v1_dict)
```
[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


