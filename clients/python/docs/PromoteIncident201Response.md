# PromoteIncident201Response


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**incident_id** | **str** |  | 
**status** | **str** |  | 

## Example

```python
from vps_secops_client.models.promote_incident201_response import PromoteIncident201Response

# TODO update the JSON string below
json = "{}"
# create an instance of PromoteIncident201Response from a JSON string
promote_incident201_response_instance = PromoteIncident201Response.from_json(json)
# print the JSON string representation of the object
print(PromoteIncident201Response.to_json())

# convert the object into a dict
promote_incident201_response_dict = promote_incident201_response_instance.to_dict()
# create an instance of PromoteIncident201Response from a dict
promote_incident201_response_from_dict = PromoteIncident201Response.from_dict(promote_incident201_response_dict)
```
[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


