# ListPacks200ResponseInner


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**pack_id** | **str** |  | 
**host** | **str** |  | 
**generated_at_utc** | **datetime** |  | 

## Example

```python
from vps_secops_client.models.list_packs200_response_inner import ListPacks200ResponseInner

# TODO update the JSON string below
json = "{}"
# create an instance of ListPacks200ResponseInner from a JSON string
list_packs200_response_inner_instance = ListPacks200ResponseInner.from_json(json)
# print the JSON string representation of the object
print(ListPacks200ResponseInner.to_json())

# convert the object into a dict
list_packs200_response_inner_dict = list_packs200_response_inner_instance.to_dict()
# create an instance of ListPacks200ResponseInner from a dict
list_packs200_response_inner_from_dict = ListPacks200ResponseInner.from_dict(list_packs200_response_inner_dict)
```
[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


